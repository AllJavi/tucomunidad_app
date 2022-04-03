import 'package:flutter/material.dart';
import 'package:tucomunidad/pages/login.dart';

import 'pages/home.dart';
import 'pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TuComunidad',
      theme: ThemeData(),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final dynamic usuario;

  const MyHomePage({Key? key, this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.usuario);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFf5f5f5),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
            backgroundColor: const Color(0xFFff7517)),
        appBar: AppBar(
          backgroundColor: const Color(0xFFff7517),
          automaticallyImplyLeading: false,
          title: GestureDetector(
              onTap: () {},
              child: Row(
                children: const <Widget>[
                  Text("TuComunidad"),
                  Icon(Icons.arrow_drop_down)
                ],
              )),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.notifications),
                )),
          ],
          bottom: const TabBar(
            tabs: [Tab(text: "Home"), Tab(text: "Instalaciones")],
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            HomePage(),
            Center(child: Text("Hola mundo 2")),
          ],
        ),
      ),
    );
  }
}
