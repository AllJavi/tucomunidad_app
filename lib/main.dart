import 'package:flutter/material.dart';
import 'package:tucomunidad/pages/create.dart';
import 'package:tucomunidad/pages/instalaciones.dart';
import 'package:tucomunidad/pages/login.dart';

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
                              usuario: widget.usuario,
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
                              ListTile(
                                leading: const Icon(Icons.house),
                                title: Text(snapshot.data ?? "tuComunidad"),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.logout),
                                title: const Text('Logout'),
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
                  onTap: () {},
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
              usuario: widget.usuario,
              changeTitulo: (nuevoTitulo) => appBloc.updateTitle(nuevoTitulo),
              comunityCode: (comunityCode) =>
                  comunityBloc.updateTitle(comunityCode),
            ),
            InstalacionesPage(
              usuario: widget.usuario,
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
