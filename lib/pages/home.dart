// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:tucomunidad/widgets/votaciones.dart';
import 'package:tucomunidad/widgets/post.dart';

class HomePage extends StatefulWidget {
  final dynamic usuario;
  final void Function(String) changeTitulo;
  final void Function(String) comunityCode;

  const HomePage(
      {Key? key,
      this.usuario,
      required this.changeTitulo,
      required this.comunityCode})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic miComunidad;

  Future _load() async {
    var comunityIndex = widget.usuario["selectedComunity"];
    var comunidadCode = widget.usuario['comunidades'][comunityIndex];
    final response = await http.get(
        Uri.parse("http://159.89.11.206:8090/api/v1/comunidad/$comunidadCode"));
    final posts =
        await http.get(Uri.parse("http://159.89.11.206:8090/api/v1/post"));
    final votaciones =
        await http.get(Uri.parse("http://159.89.11.206:8090/api/v1/votacion"));
    final reuniones =
        await http.get(Uri.parse("http://159.89.11.206:8090/api/v1/reunion"));
    final usuarios =
        await http.get(Uri.parse("http://159.89.11.206:8090/api/v1/usuario"));
    if (response.statusCode == 200 && response.body != '') {
      dynamic comunidad = jsonDecode(response.body);
      comunidad['posts'] = jsonDecode(posts.body)
          .where((post) =>
              post['comunityCode'] ==
              widget.usuario['comunidades'][comunityIndex])
          .toList();
      comunidad['votaciones'] = jsonDecode(votaciones.body)
          .where((votacion) =>
              votacion['comunityCode'] ==
              widget.usuario['comunidades'][comunityIndex])
          .toList();
      comunidad['reuniones'] = jsonDecode(reuniones.body)
          .where((reunion) =>
              reunion['comunityCode'] ==
              widget.usuario['comunidades'][comunityIndex])
          .toList();
      comunidad['usuarios'] = jsonDecode(usuarios.body)
          .where((usuario) =>
              (usuario['comunidades']
                  .contains(widget.usuario['comunidades'][comunityIndex])) ==
              true)
          .toList();

      widget.changeTitulo(comunidad['calle']);
      widget.comunityCode(comunidad['comunityCode']);
      miComunidad = comunidad;
      return comunidad;
    }
  }

  List<Widget> getPosts(dynamic miComunidad) {
    List<Widget> posts = <Widget>[];
    for (var i = 0; i < miComunidad['posts'].length; i++) {
      posts.add(PostCard(
          postData: miComunidad['posts'][i],
          comunityCode: miComunidad['comunityCode'],
          comunidad: miComunidad,
          usuario: widget.usuario,
          load: () async {
            dynamic comunidad = await _load();
            setState(() {
              miComunidad = comunidad;
            });
          }));
    }
    return posts;
  }

  List<Widget> getVotaciones(dynamic miComunidad) {
    List<Widget> votaciones = <Widget>[];
    if (miComunidad['votaciones'].length != 0) {
      votaciones.add(VotacionesCard(
        votaciones: miComunidad['votaciones'],
      ));
      votaciones.add(const Padding(
        padding: EdgeInsets.all(15),
        child: Divider(
          thickness: 1,
        ),
      ));
    }
    return votaciones;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _load(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return RefreshIndicator(
              color: const Color(0xFFff7517),
              onRefresh: () async {
                dynamic comunidad = await _load();
                setState(() {
                  miComunidad = comunidad;
                });
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ...getVotaciones(miComunidad),
                      ...getPosts(miComunidad).reversed,
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Divider(
                          thickness: 0,
                          color: Color(0xFff5f5f5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xFFff7517),
            ));
          }
        });
  }
}
