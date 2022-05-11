// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:tucomunidad/pages/createPost.dart';
import 'package:tucomunidad/pages/createVotacion.dart';
import 'package:tucomunidad/pages/createReunion.dart';

class CreatePage extends StatefulWidget {
  final dynamic usuario;
  final String comunityCode;

  const CreatePage(
      {Key? key, required this.usuario, required this.comunityCode})
      : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    if (widget.usuario['rol'] == 0) {
      return DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: const Color(0xFFf5f5f5),
          appBar: AppBar(
            backgroundColor: const Color(0xFFff7517),
            bottom: const TabBar(
              tabs: [Tab(text: "Post")],
              indicatorColor: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              CreatePostPage(
                usuario: widget.usuario,
                comunityCode: widget.comunityCode,
              ),
            ],
          ),
        ),
      );
    } else {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color(0xFFf5f5f5),
          appBar: AppBar(
            backgroundColor: const Color(0xFFff7517),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Post"),
                Tab(text: "Votacion"),
                Tab(text: "Reunion")
              ],
              indicatorColor: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              CreatePostPage(
                usuario: widget.usuario,
                comunityCode: widget.comunityCode,
              ),
              CreateVotacionPage(
                usuario: widget.usuario,
                comunityCode: widget.comunityCode,
              ),
              CreateReunionPage(
                usuario: widget.usuario,
                comunityCode: widget.comunityCode,
              ),
            ],
          ),
        ),
      );
    }
  }
}
