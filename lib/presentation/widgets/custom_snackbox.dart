import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';

SnackBar customSnackBar({
  required String text,
  required IconData icon,
  required Color iconColor,
  required Color borderColor,
  required Color backgroundColor,
}) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: borderColor,
        width: 0.5,
      ),
    ),
    content: Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 14,
        ),
        const SizedBox(
          width: 30,
        ),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(color: grey, fontSize: 10),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
  );
}
