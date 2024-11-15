import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';

class AppTextStyles {
  static const TextStyle forgetPassStyle = TextStyle(
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.w500,
      color: indigo,
      fontSize: 13);
  static const TextStyle mainHeadingStyle =
      TextStyle(fontSize: 35, fontWeight: FontWeight.bold);
  static const TextStyle roomHeadTextstyle =
      TextStyle(fontWeight: FontWeight.w800, fontSize: 15);
  static const TextStyle roomsubtitleTextstyle =
      TextStyle(fontWeight: FontWeight.w800, fontSize: 30);
  static const addProfileTitleStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30,
    color: Color.fromARGB(255, 78, 92, 169),
  );
  static const addProfilesubtitleStyle =
      TextStyle(fontWeight: FontWeight.w300, fontSize: 16);

  static const monthTextStyle = TextStyle(fontSize: 8, color: Colors.white);
}
