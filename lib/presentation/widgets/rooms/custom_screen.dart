import 'package:flutter/material.dart';

Widget customScreen() {
  return Container(
    height: 25,
    width: 300,
    decoration:const  BoxDecoration(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          Color.fromARGB(255, 52, 52, 52),
          Color.fromARGB(255, 171, 168, 168),
          Color.fromARGB(255, 221, 217, 217),
          Color.fromARGB(255, 243, 239, 239),
          Colors.white
        ],
      ),
    ),
  );
}
