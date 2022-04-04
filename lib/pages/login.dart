// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:tucomunidad/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailcontroller;
  late TextEditingController _passwordcontroller;

  @override
  void initState() {
    super.initState();
    _emailcontroller = TextEditingController();
    _passwordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffffff),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFffffff),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: 250,
                    width: 250,
                    child: Image.asset('assets/logo.png')),
                SizedBox(
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Text("Email")),
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: TextField(
                    controller: _emailcontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFff7517), width: 2)),
                      hintText: 'Email',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22),
                      child: Text("Password")),
                  width: MediaQuery.of(context).size.width,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 21, vertical: 16),
                  child: TextField(
                    controller: _passwordcontroller,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFff7517), width: 2)),
                      hintText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () async {
                      var email = _emailcontroller.text;
                      var password = _passwordcontroller.text;
                      final response = await http.get(Uri.parse(
                          "http://159.89.11.206:8080/api/v1/usuario/login?email=$email&password=$password"));
                      if (response.statusCode == 200 && response.body != '') {
                        dynamic usuario = jsonDecode(response.body);
                        _emailcontroller.text = '';
                        _passwordcontroller.text = '';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    usuario: usuario,
                                  )),
                        );
                      } else {
                        _emailcontroller.text = '';
                        _passwordcontroller.text = '';

                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Inicio de sesion no valido'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text("LOGIN"),
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFff7517)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
