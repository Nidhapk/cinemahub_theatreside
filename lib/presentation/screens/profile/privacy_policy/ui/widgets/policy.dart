import 'package:flutter/material.dart';

Widget policyContents({
  required BuildContext context,
  required String mainHeading,
  required String introduction,required Widget subcontents
}) {
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        mainHeading,
        style: TextStyle(
            color: Colors.indigo[500],
            fontSize: width * 0.05,
            fontWeight: FontWeight.w500),
      ),
      SizedBox(
        height: height * 0.01,
      ),
      Text(
        introduction,
        textAlign: TextAlign.start,
        style: TextStyle(
            color: const Color.fromARGB(255, 243, 241, 241),
            fontSize: width * 0.035,
            fontWeight: FontWeight.w200),
      ),
      SizedBox(
        height: height * 0.02,
      ),
      subcontents
    ],
  );
}
