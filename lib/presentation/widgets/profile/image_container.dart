import 'package:flutter/material.dart';

Widget imageContainer({required String url}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 100,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 19, 19, 19),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            url,
          ),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}
