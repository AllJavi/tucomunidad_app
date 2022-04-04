// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostCard extends StatefulWidget {
  final dynamic postData;
  final String comunityCode;
  final dynamic usuario;
  final Function() load;

  const PostCard(
      {Key? key,
      required this.postData,
      required this.comunityCode,
      required this.usuario,
      required this.load})
      : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late bool upvoted;

  @override
  void initState() {
    super.initState();
    upvoted = false;
    for (dynamic upvotedUser in widget.postData['upvoted']) {
      if (upvotedUser['id'] == widget.usuario['id']) {
        upvoted = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 240,
      color: const Color(0xFFffffff),
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Expanded(
            flex: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(300.0),
                            child: Image.asset('assets/profile.jpg')),
                      )),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 22,
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.postData['autor']['nombre'] +
                              " " +
                              widget.postData['autor']['apellidos'].join(" ")),
                          Text(
                            widget.postData['titulo'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: PopupMenuButton(
                      child: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          child: Text("Edit"),
                          value: 1,
                        ),
                        if (widget.postData['autor']['id'] ==
                            widget.usuario['id'])
                          PopupMenuItem(
                            child: const Text("Delete"),
                            onTap: () async {
                              if (widget.postData['autor']['id'] ==
                                  widget.usuario['id']) {
                                final response = await http.post(
                                    Uri.parse(
                                        "http://159.89.11.206:8080/api/v1/comunidad/${widget.comunityCode}/post/delete"),
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: widget.postData['id'].toString());
                                if (response.statusCode == 200) {
                                  widget.load();
                                } else {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Error'),
                                      content: const Text(
                                          'Ha habido un error al eliminar el post intentalo mas tarde'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } else {
                                await Future.delayed(
                                    const Duration(milliseconds: 100));
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'No puede eliminar un post que no es tuyo'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'OK'),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            value: 2,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 14,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(widget.postData['cuerpo']),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite),
                    iconSize: 20,
                    color: (upvoted)
                        ? const Color(0xFFff7517)
                        : const Color(0xFFC4C4C4),
                    onPressed: () {
                      setState(() {
                        upvoted = !upvoted;
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    iconSize: 20,
                    color: const Color(0xFFC4C4C4),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    iconSize: 20,
                    color: const Color(0xFFC4C4C4),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
