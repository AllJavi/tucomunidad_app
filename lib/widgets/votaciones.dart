// ignore_for_file: file_names

import 'package:flutter/material.dart';

class VotacionesCard extends StatefulWidget {
  const VotacionesCard({Key? key}) : super(key: key);

  @override
  State<VotacionesCard> createState() => _VotacionesCardState();
}

class _VotacionesCardState extends State<VotacionesCard> {
  bool test = false;

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
                    const Expanded(
                        flex: 11,
                        child: Padding(
                            padding: EdgeInsets.all(3),
                            child: Center(
                                child:
                                    Text("Lorem Ipsum is simply dummy text")))),
                    Expanded(
                        flex: 5,
                        child: Row(
                          children: [
                            Expanded(
                                child: IconButton(
                                    icon: const Icon(Icons.arrow_left),
                                    onPressed: () {})),
                            Expanded(
                                child: IconButton(
                                    icon: const Icon(Icons.arrow_right),
                                    onPressed: () {})),
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
                              child:
                                  Checkbox(value: test, onChanged: (value) {})),
                          const Text("Opcion A")
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 30,
                              width: 35,
                              child:
                                  Checkbox(value: test, onChanged: (value) {})),
                          const Text("Opcion B")
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ));
  }
}
