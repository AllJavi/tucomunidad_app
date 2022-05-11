// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class InstalacionesCard extends StatelessWidget {
  final dynamic instalacion;
  final dynamic usuario;
  final String comunityCode;
  final Function() load;

  const InstalacionesCard(
      {Key? key,
      required this.instalacion,
      required this.comunityCode,
      required this.usuario,
      required this.load})
      : super(key: key);

  int _getNumeroTurnos() {
    return ((instalacion["horaFin"] - instalacion["horaInicio"]) /
            instalacion["intervalo"])
        .round();
  }

  String _getHour(int base) {
    var stringBase = base.toString().padLeft(4, "0");
    return stringBase.substring(0, 2);
  }

  String _getMinute(int base) {
    var stringBase = base.toString().padLeft(4, "0");
    var minBase100 = int.parse(stringBase.substring(2, 4));
    return (minBase100 * 60 / 100).round().toString().padLeft(2, "0");
  }

  bool _isReserved(int horaInicio) {
    for (var i = 0; i < instalacion["reservas"].length; i++) {
      if (instalacion["reservas"][i]["horaInicio"] == horaInicio &&
          instalacion["reservas"][i]["usuario"] != usuario["id"]) {
        return true;
      }
    }
    return false;
  }

  bool _isReservedByMe(int horaInicio) {
    for (var i = 0; i < instalacion["reservas"].length; i++) {
      if (instalacion["reservas"][i]["horaInicio"] == horaInicio &&
          instalacion["reservas"][i]["usuario"] == usuario["id"]) {
        return true;
      }
    }
    return false;
  }

  int _isReservedByMeId(int horaInicio) {
    for (var i = 0; i < instalacion["reservas"].length; i++) {
      if (instalacion["reservas"][i]["horaInicio"] == horaInicio &&
          instalacion["reservas"][i]["usuario"] == usuario["id"]) {
        return instalacion["reservas"][i]["id"];
      }
    }
    return 0;
  }

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
              flex: 12,
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
                flex: 4,
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
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(_getNumeroTurnos(), (index) {
                    var hour = instalacion["horaInicio"] +
                        index * instalacion["intervalo"];
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: SizedBox(
                          width: 90,
                          child: ElevatedButton(
                            onPressed: _isReserved(hour)
                                ? null
                                : !_isReservedByMe(hour)
                                    ? () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title:
                                                const Text('Realizar Reserva'),
                                            content: const Text(
                                                '¿Desea realizar la reserva?'),
                                            actions: <Widget>[
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    primary: const Color(
                                                        0xFFff7517)),
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    primary: const Color(
                                                        0xFFff7517)),
                                                onPressed: () async {
                                                  final response = await http.post(
                                                      Uri.parse(
                                                          "http://159.89.11.206:8090/api/v1/reserva/"),
                                                      headers: {
                                                        "Content-Type":
                                                            "application/json"
                                                      },
                                                      body: json.encode({
                                                        "horaInicio": hour,
                                                        "horaFin": hour,
                                                        "usuario":
                                                            usuario["id"],
                                                        "comunityCode":
                                                            comunityCode,
                                                        "instalacionId":
                                                            instalacion["id"]
                                                      }).toString());
                                                  Navigator.pop(context, 'OK');
                                                  if (response.statusCode ==
                                                      200) {
                                                    load();
                                                  } else {
                                                    showDialog<String>(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                              title: const Text(
                                                                  'Error al reservar'),
                                                              content: const Text(
                                                                  'Ha habido errores en la reserva, intentelo de nuevo mas tarde'),
                                                              actions: <Widget>[
                                                                TextButton(
                                                                  style: TextButton
                                                                      .styleFrom(
                                                                          primary:
                                                                              const Color(0xFFff7517)),
                                                                  onPressed:
                                                                      () {
                                                                    load();
                                                                    Navigator.pop(
                                                                        context,
                                                                        'Ok');
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Ok'),
                                                                ),
                                                              ],
                                                            ));
                                                  }
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        )
                                    : () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            title:
                                                const Text('Cancelar Reserva'),
                                            content: const Text(
                                                '¿Desea cancelar la reserva?'),
                                            actions: <Widget>[
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    primary: const Color(
                                                        0xFFff7517)),
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text('Cancel'),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    primary: const Color(
                                                        0xFFff7517)),
                                                onPressed: () async {
                                                  final response = await http.get(
                                                      Uri.parse(
                                                          "http://159.89.11.206:8090/api/v1/reserva/delete/${_isReservedByMeId(hour)}"),
                                                      headers: {
                                                        "Content-Type":
                                                            "application/json"
                                                      });
                                                  Navigator.pop(context, 'OK');
                                                  if (response.statusCode ==
                                                      200) {
                                                    load();
                                                  }
                                                },
                                                child: const Text('OK'),
                                              ),
                                            ],
                                          ),
                                        ),
                            style: ElevatedButton.styleFrom(
                                primary: !_isReservedByMe(hour)
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : const Color(0xFFff7517),
                                shadowColor: const Color(0xFFFFFFFF)),
                            child: Text(
                              "${_getHour(hour)}:${_getMinute(hour)}",
                              style: TextStyle(
                                  color: _isReservedByMe(hour)
                                      ? const Color(0xFFffffff)
                                      : const Color(0xFF000000)),
                            ),
                          ),
                        ));
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
