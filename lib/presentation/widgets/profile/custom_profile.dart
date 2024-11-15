import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget customProfileContainer(
    {required ImageProvider<Object>? backgroundImage,
    required void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 16.0, top: 30.0),
    child: CircleAvatar(
      backgroundColor: Colors.grey,
      backgroundImage: backgroundImage,
      radius: 35,
      child: Padding(
        padding: const EdgeInsets.only(left: 47, top: 26),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 101, 181, 246),
                shape: BoxShape.circle),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: const Icon(
                color: Colors.white,
                Icons.add_a_photo,
                size: 13,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
