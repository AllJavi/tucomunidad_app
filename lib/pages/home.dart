// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:tucomunidad/widgets/votaciones.dart';
import 'package:tucomunidad/widgets/post.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            VotacionesCard(),
            Padding(
              padding: EdgeInsets.all(15),
              child: Divider(
                thickness: 1,
              ),
            ),
            PostCard(),
            PostCard(),
            PostCard(),
          ],
        ),
      ),
    );
  }
}
