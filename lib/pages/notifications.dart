// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:tucomunidad/widgets/reuniones.dart';

class NotificationsPage extends StatefulWidget {
  final dynamic usuario;

  const NotificationsPage({Key? key, required this.usuario}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  dynamic miComunidad;

  Future _load() async {
    var comunityIndex = widget.usuario["selectedComunity"];
    var comunidadCode = widget.usuario['comunidades'][comunityIndex];
    final response = await http.get(
        Uri.parse("http://159.89.11.206:8090/api/v1/comunidad/$comunidadCode"));
    final reuniones =
        await http.get(Uri.parse("http://159.89.11.206:8090/api/v1/reunion"));

    if (response.statusCode == 200 && response.body != '') {
      dynamic comunidad = jsonDecode(response.body);
      comunidad['reuniones'] = jsonDecode(reuniones.body)
          .where((reunion) =>
              reunion['comunityCode'] ==
              widget.usuario['comunidades'][comunityIndex])
          .toList();
      miComunidad = comunidad;
      return comunidad;
    }
  }

  List<Widget> getReuniones(dynamic miComunidad) {
    List<Widget> posts = <Widget>[];
    for (var i = 0; i < miComunidad['reuniones'].length; i++) {
      posts.add(ReunionCard(
        reunionData: miComunidad['reuniones'][i],
      ));
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFff7517),
        title: const Text('Reuniones'),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
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
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.only(top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          ...getReuniones(miComunidad),
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
            }),
      ),
    );
  }
}
