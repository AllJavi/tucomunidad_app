// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ReunionCard extends StatefulWidget {
  final dynamic reunionData;

  const ReunionCard({
    Key? key,
    required this.reunionData,
  }) : super(key: key);

  @override
  State<ReunionCard> createState() => _ReunionCardState();
}

class _ReunionCardState extends State<ReunionCard> {
  bool silenced = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 110,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 241, 241),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000).withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: Container(
                    margin: const EdgeInsets.all(5),
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xFFffffff),
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: const Color(0xFFff7517)),
                        child: Icon(
                          silenced
                              ? Icons.notifications_off
                              : Icons.notifications,
                          size: 34,
                          color: const Color(0xFFff7517),
                        ),
                        onPressed: () {
                          setState(() {
                            silenced = !silenced;
                          });
                        },
                      ),
                    ))),
            Expanded(
                flex: 8,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.reunionData["motivo"],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Text(widget.reunionData["fecha"].split(",")[0]),
                          const Spacer(
                            flex: 1,
                          ),
                          Text(widget.reunionData["fecha"].split(",")[1]),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        widget.reunionData["presencial"]
                            ? "Presencial"
                            : "Online",
                      ),
                    ],
                  ),
                )),
            Expanded(
                flex: 3,
                child: Transform.rotate(
                  angle: -45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: TextButton(
                        style: TextButton.styleFrom(
                            primary: const Color(0xFFff7517)),
                        onPressed: () {},
                        child: Icon(
                            widget.reunionData['presencial']
                                ? Icons.gps_fixed
                                : Icons.link,
                            size: 30,
                            color: const Color(0xFFff7517))),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
