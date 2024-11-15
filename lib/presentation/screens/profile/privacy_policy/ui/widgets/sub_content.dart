import 'package:flutter/material.dart';

Widget subContent({required String title, required String subtitle}) {
  return Text.rich(
    TextSpan(
      children: [TextSpan(text: title), TextSpan(text: '$subtitle\n')],
    ),
  );
}
