// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tucomunidad/widgets/instalaciones.dart';

class InstalacionesPage extends StatefulWidget {
  final dynamic usuario;
  final void Function(String) changeTitulo;
  final void Function(String) comunityCode;

  const InstalacionesPage(
      {Key? key,
      required this.usuario,
      required this.changeTitulo,
      required this.comunityCode})
      : super(key: key);

  @override
  State<InstalacionesPage> createState() => _InstalacionesPageState();
}

class _InstalacionesPageState extends State<InstalacionesPage> {
  int comunidadSeleccionada = 0;
  dynamic miComunidad;

  Future _load() async {
    var comunidadCode = widget.usuario['comunidades'][0];
    final response = await http.get(
        Uri.parse("http://159.89.11.206:8080/api/v1/comunidad/$comunidadCode"));
    if (response.statusCode == 200 && response.body != '') {
      dynamic comunidad = jsonDecode(response.body);
      widget.changeTitulo(comunidad['calle']);
      widget.comunityCode(comunidad['comunityCode']);
      miComunidad = comunidad;
      return comunidad;
    }
  }

  List<Widget> getInstalaciones(dynamic miComunidad) {
    List<Widget> instalaciones = <Widget>[];
    for (var i = 0; i < miComunidad['instalaciones'].length; i++) {
      instalaciones
          .add(InstalacionesCard(instalacion: miComunidad['instalaciones'][i]));
    }
    return instalaciones;
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
                      ...getInstalaciones(miComunidad),
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
