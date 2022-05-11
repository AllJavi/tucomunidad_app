// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePostPage extends StatefulWidget {
  final dynamic usuario;
  final String comunityCode;

  const CreatePostPage(
      {Key? key, required this.usuario, required this.comunityCode})
      : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late TextEditingController _tituloController;
  late TextEditingController _cuerpoController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController();
    _cuerpoController = TextEditingController();
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _cuerpoController.dispose();
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
                  child: Text("Cuerpo")),
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextField(
                minLines: 4,
                maxLines: 5,
                controller: _cuerpoController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFff7517), width: 2)),
                  hintText: 'cuerpo',
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  var titulo = _tituloController.text;
                  var cuerpo = _cuerpoController.text;

                  final response = await http.post(
                      Uri.parse("http://159.89.11.206:8090/api/v1/post/"),
                      headers: {"Content-Type": "application/json"},
                      body: json.encode({
                        "cuerpo": cuerpo,
                        "titulo": titulo,
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
