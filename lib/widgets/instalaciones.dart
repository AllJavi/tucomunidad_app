// ignore_for_file: file_names
import 'package:flutter/material.dart';

class InstalacionesCard extends StatelessWidget {
  final dynamic instalacion;

  const InstalacionesCard({Key? key, required this.instalacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF000000).withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 6,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: const Color(0xFFE0E0E0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(instalacion['url']),
                      ),
                    ),
                  ),
                  Container(
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: const Color(0xFFE0E0E0),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: Text(
                      instalacion['nombre'].toString().toUpperCase(),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
