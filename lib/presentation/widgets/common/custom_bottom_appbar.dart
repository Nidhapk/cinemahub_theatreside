import 'package:flutter/material.dart';

Widget customBottomappBar(
    {required void Function()? onPressed, required String text}) {
  return BottomAppBar(
    color: Colors.transparent,
    child: ElevatedButton(
      onPressed: onPressed,
      child:  Text(text),
    ),
  );
}
