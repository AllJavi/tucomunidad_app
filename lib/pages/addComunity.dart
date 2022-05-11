// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddComunityPopUp extends StatefulWidget {
  final dynamic usuario;

  const AddComunityPopUp({Key? key, @required this.usuario}) : super(key: key);

  @override
  State<AddComunityPopUp> createState() => _AddComunityPopUpState();
}

class _AddComunityPopUpState extends State<AddComunityPopUp> {
  late TextEditingController _comunityCode;

  @override
  void initState() {
    super.initState();
    _comunityCode = TextEditingController();
  }

  @override
  void dispose() {
    _comunityCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(color: Colors.black.withAlpha(150))),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                SizedBox(
                    height: 120,
                    width: 120,
                    child: Image.asset('assets/logo.png')),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Material(
                    child: TextField(
                      controller: _comunityCode,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFFff7517), width: 2)),
                        hintText: 'codigo de comunidad',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        onPressed: () async {
                          var comunityCode = _comunityCode.text;
                          final response = await http.post(
                              Uri.parse(
                                  "http://159.89.11.206:8090/api/v1/usuario/comunidad/"),
                              headers: {"Content-Type": "application/json"},
                              body: json.encode({
                                "email": widget.usuario["email"],
                                "password": widget.usuario["password"],
                                "comunitycode": comunityCode
                              }).toString());

                          if (response.statusCode == 200 &&
                              jsonDecode(response.body) == true) {
                            Navigator.pop(context);
                          } else {}
                        },
                        child: const Text("LOGIN"),
                        style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFff7517)),
                      )),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
