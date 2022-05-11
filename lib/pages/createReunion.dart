// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateReunionPage extends StatefulWidget {
  final dynamic usuario;
  final String comunityCode;

  const CreateReunionPage(
      {Key? key, required this.usuario, required this.comunityCode})
      : super(key: key);

  @override
  State<CreateReunionPage> createState() => _CreateReunionPageState();
}

class _CreateReunionPageState extends State<CreateReunionPage> {
  late TextEditingController _motivoController;
  late TextEditingController _localizacionController;
  bool _opcionPresencial = false;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
          context: context,
          initialTime: selectedTime,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFFff7517), // <-- SEE HERE
                ),
              ),
              child: child!,
            );
          },
        ) ??
        selectedTime;
    if (picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2025),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: Color(0xFFff7517), // <-- SEE HERE
                ),
              ),
              child: child!,
            );
          },
        ) ??
        selectedDate;

    if (selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _motivoController = TextEditingController();
    _localizacionController = TextEditingController();
  }

  @override
  void dispose() {
    _motivoController.dispose();
    _localizacionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Text("Motivo")),
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextField(
                controller: _motivoController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFff7517), width: 2)),
                  hintText: 'motivo',
                ),
              ),
            ),
            SizedBox(
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Text("Fecha")),
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.date_range,
                        size: 26,
                        color: Color.fromARGB(255, 103, 103, 103),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Text(
                          "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year.toString().padLeft(2, '0')}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 103, 103, 103),
                              fontSize: 16),
                        ),
                      ),
                      Expanded(child: Container()),
                      GestureDetector(
                        onTap: () => _selectTime(context),
                        child: Text(
                          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 103, 103, 103),
                              fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.schedule,
                        size: 26,
                        color: Color.fromARGB(255, 103, 103, 103),
                      ),
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, bottom: 16),
              child: SizedBox(
                  // color: Colors.red,
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              height: 30,
                              width: 35,
                              child: Checkbox(
                                  activeColor: const Color(0xFFff7517),
                                  value: _opcionPresencial,
                                  onChanged: (value) {
                                    setState(() {
                                      _opcionPresencial = !_opcionPresencial;
                                    });
                                  })),
                          const Text("Presencial")
                        ],
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: 30,
                              width: 35,
                              child: Checkbox(
                                  activeColor: const Color(0xFFff7517),
                                  value: !_opcionPresencial,
                                  onChanged: (value) {
                                    setState(() {
                                      _opcionPresencial = !_opcionPresencial;
                                    });
                                  })),
                          const Text("Online")
                        ],
                      ),
                    ],
                  )),
            ),
            SizedBox(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Text(_opcionPresencial ? "Localizacion" : "Enlace")),
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: TextField(
                controller: _localizacionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFFff7517), width: 2)),
                  hintText: _opcionPresencial ? "Localizacion" : "Enlace",
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 55,
              child: ElevatedButton(
                onPressed: () async {
                  var motivo = _motivoController.text;
                  var fecha =
                      "${selectedDate.day.toString().padLeft(2, '0')}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.year.toString().padLeft(2, '0')},${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
                  var localizacion = _localizacionController.text;

                  final response = await http.post(
                      Uri.parse("http://159.89.11.206:8090/api/v1/reunion/"),
                      headers: {"Content-Type": "application/json"},
                      body: json.encode({
                        "motivo": motivo,
                        "fecha": fecha,
                        "presencial": _opcionPresencial,
                        "localizacion": localizacion,
                        "comunityCode": widget.comunityCode
                      }).toString());
                  if (response.statusCode == 200) {
                    Navigator.pop(context);
                  } else {}
                },
                child: const Text("CREATE"),
                style:
                    ElevatedButton.styleFrom(primary: const Color(0xFFff7517)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
