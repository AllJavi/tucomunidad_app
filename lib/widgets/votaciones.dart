// ignore_for_file: file_names

import 'package:flutter/material.dart';

class VotacionesCard extends StatefulWidget {
  final List<dynamic> votaciones;

  const VotacionesCard({Key? key, required this.votaciones}) : super(key: key);

  @override
  State<VotacionesCard> createState() => _VotacionesCardState();
}

class _VotacionesCardState extends State<VotacionesCard> {
  bool opcionA = false;
  bool opcionB = false;
  int votacion = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 170,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color(0xFFE0E0E0),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 6,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ]),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 11,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: const Color(0xFFffffff),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
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
                    Expanded(
                        flex: 11,
                        child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Center(
                                child: Text(
                                    widget.votaciones[votacion]['titulo'])))),
                    Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            Expanded(
                                child: IconButton(
                                    icon: const Icon(Icons.arrow_left),
                                    onPressed: () {
                                      if (votacion > 0) {
                                        setState(() {
                                          votacion--;
                                        });
                                      }
                                    })),
                            Expanded(
                                child: IconButton(
                                    icon: const Icon(Icons.arrow_right),
                                    onPressed: () {
                                      if (widget.votaciones.length - 1 >
                                          votacion) {
                                        setState(() {
                                          votacion++;
                                        });
                                      }
                                    })),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFFE0E0E0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 30,
                              width: 35,
                              child: Checkbox(
                                  activeColor: const Color(0xFFff7517),
                                  value: opcionA,
                                  onChanged: (value) {
                                    setState(() {
                                      opcionA = !opcionA;
                                      if (opcionA && opcionB) {
                                        opcionB = !opcionB;
                                      }
                                    });
                                  })),
                          Text(widget.votaciones[votacion]['opcionA'])
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 30,
                              width: 35,
                              child: Checkbox(
                                  activeColor: const Color(0xFFff7517),
                                  value: opcionB,
                                  onChanged: (value) {
                                    setState(() {
                                      opcionB = !opcionB;
                                      if (opcionA && opcionB) {
                                        opcionA = !opcionA;
                                      }
                                    });
                                  })),
                          Text(widget.votaciones[votacion]['opcionB'])
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
