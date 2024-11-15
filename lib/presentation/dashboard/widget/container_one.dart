import 'package:flutter/material.dart';

Widget containerOne({
  required String title,
  required String value,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Container(
        padding: const EdgeInsets.all(20),
        height: 150,
        width: 160,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 25, 25, 30).withOpacity(0.65),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text.rich(TextSpan(
            text: '$title\n\n',
            style: const TextStyle(fontSize: 10),
            children: [
              TextSpan(
                  text: '$value\n',
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.bold))
            ]))),
  );
}
