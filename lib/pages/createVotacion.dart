// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateVotacionPage extends StatefulWidget {
  final dynamic usuario;
  final String comunityCode;

  const CreateVotacionPage(
      {Key? key, required this.usuario, required this.comunityCode})
      : super(key: key);

  @override
  State<CreateVotacionPage> createState() => _CreateVotacionPageState();
}

class _CreateVotacionPageState extends State<CreateVotacionPage> {
  late TextEditingController _tituloController;
  late TextEditingController _opcionAController;
  late TextEditingController _opcionBController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController();
    _opcionAController = TextEditingController();
    _opcionBController = TextEditingController();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _opcionAController.dispose();
    _opcionBController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Text("Titulo")),
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextField(
                controller: _tituloController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFff7517), width: 2)),
                  hintText: 'titulo',
                ),
              ),
            ),
            SizedBox(
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Text("Opcion A")),
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextField(
                controller: _opcionAController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFff7517), width: 2)),
                  hintText: 'opcion A',
                ),
              ),
            ),
            SizedBox(
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Text("Opcion B")),
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextField(
                controller: _opcionBController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFff7517), width: 2)),
                  hintText: 'opcion B',
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  var titulo = _tituloController.text;
                  var opcionA = _opcionAController.text;
                  var opcionB = _opcionBController.text;

                  final response = await http.post(
                      Uri.parse("http://159.89.11.206:8090/api/v1/votacion/"),
                      headers: {"Content-Type": "application/json"},
                      body: json.encode({
                        "titulo": titulo,
                        "opcionA": opcionA,
                        "opcionB": opcionB,
                        "autor": widget.usuario['id'],
                        "comunityCode": widget.comunityCode
                      }).toString());
                  if (response.statusCode == 200) {
                    Navigator.pop(context);
                  } else {}
                },
                child: const Text("CREATE"),
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xFFff7517)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
