// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tucomunidad/pages/addComunity.dart';
import 'package:tucomunidad/pages/create.dart';
import 'package:tucomunidad/pages/instalaciones.dart';
import 'package:tucomunidad/pages/login.dart';
import 'package:tucomunidad/pages/notifications.dart';

import 'pages/home.dart';
import 'pages/login.dart';
import 'streams/appbar.dart';

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

class MyHomePage extends StatefulWidget {
  final dynamic usuario;

  const MyHomePage({Key? key, this.usuario}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final appBloc = AppPropertiesBloc();
  final comunityBloc = AppPropertiesBloc();
  late dynamic usuario;

  @override
  void initState() {
    usuario = widget.usuario;
    super.initState();
  }

  void logout() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFf5f5f5),
        floatingActionButton: StreamBuilder<String>(
            stream: comunityBloc.titleStream,
            initialData: "0",
            builder: (context, snapshot) {
              return FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreatePage(
                              usuario: usuario,
                              comunityCode: snapshot.data ?? "0")));
                },
                child: const Icon(Icons.add),
                backgroundColor: const Color(0xFFff7517),
              );
            }),
        appBar: AppBar(
          backgroundColor: const Color(0xFFff7517),
          automaticallyImplyLeading: false,
          title: StreamBuilder<String>(
            stream: appBloc.titleStream,
            initialData: "TuComunidad",
            builder: (context, snapshot) => GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      context: context,
                      builder: (context) {
                        return Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ...List.generate(usuario["comunidades"].length,
                                  (index) {
                                return ListTile(
                                  leading: Icon(
                                    Icons.house,
                                    color: usuario["selectedComunity"] == index
                                        ? const Color(0xFFff7517)
                                        : Colors.grey,
                                  ),
                                  title: Text(
                                    usuario["comunidadesNombre"]
                                        [usuario["comunidades"][index]],
                                    style: TextStyle(
                                      color:
                                          usuario["selectedComunity"] == index
                                              ? const Color(0xFFff7517)
                                              : Colors.grey,
                                    ),
                                  ),
                                  onTap: () {
                                    if (usuario["selectedComunity"] != index) {
                                      setState(() {
                                        usuario["selectedComunity"] = index;
                                      });
                                    }
                                    Navigator.pop(context);
                                  },
                                );
                              }),
                              ListTile(
                                leading: const Icon(
                                  Icons.add,
                                  color: Colors.grey,
                                ),
                                title: const Text(
                                  "Agregar Comunidad",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                onTap: () {
                                  Navigator.pop(context);

                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder: (_, __, ___) =>
                                              AddComunityPopUp(
                                                usuario: usuario,
                                                load: (context) async {
                                                  final response =
                                                      await http.get(Uri.parse(
                                                          "http://159.89.11.206:8090/api/v1/usuario/login?email=${usuario['email']}&password=${usuario['password']}"));
                                                  if (response.statusCode ==
                                                          200 &&
                                                      response.body != '') {
                                                    dynamic nuevoUsuario =
                                                        jsonDecode(
                                                            response.body);
                                                    nuevoUsuario[
                                                        "comunidadesNombre"] = {};

                                                    final comunidades =
                                                        await http.get(Uri.parse(
                                                            "http://159.89.11.206:8090/api/v1/comunidad"));

                                                    for (var comunidad
                                                        in jsonDecode(
                                                            comunidades.body)) {
                                                      if (nuevoUsuario[
                                                              "comunidades"]
                                                          .contains(comunidad[
                                                              "comunityCode"])) {
                                                        nuevoUsuario[
                                                                    "comunidadesNombre"]
                                                                [comunidad[
                                                                    "comunityCode"]] =
                                                            comunidad["calle"];
                                                      }
                                                    }
                                                    nuevoUsuario[
                                                            "selectedComunity"] =
                                                        usuario[
                                                            "selectedComunity"];

                                                    setState(() {
                                                      usuario = nuevoUsuario;
                                                    });
                                                  }
                                                  Navigator.pop(context);
                                                },
                                              )));
                                },
                              ),
                              ListTile(
                                leading: const Icon(
                                  Icons.logout,
                                  color: Colors.grey,
                                ),
                                title: const Text(
                                  'Logout',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                  logout();
                                },
                              ),
                              ListTile(
                                onTap: () {},
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Row(
                  children: <Widget>[
                    Text(snapshot.data ?? ''),
                    const Icon(Icons.arrow_drop_down)
                  ],
                )),
          ),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsPage(
                                usuario: usuario,
                              )),
                    );
                  },
                  child: const Icon(Icons.notifications),
                )),
          ],
          bottom: const TabBar(
            tabs: [Tab(text: "Home"), Tab(text: "Instalaciones")],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            HomePage(
              usuario: usuario,
              changeTitulo: (nuevoTitulo) => appBloc.updateTitle(nuevoTitulo),
              comunityCode: (comunityCode) =>
                  comunityBloc.updateTitle(comunityCode),
            ),
            InstalacionesPage(
              usuario: usuario,
              changeTitulo: (nuevoTitulo) => appBloc.updateTitle(nuevoTitulo),
              comunityCode: (comunityCode) =>
                  comunityBloc.updateTitle(comunityCode),
            ),
          ],
        ),
      ),
    );
  }
}
