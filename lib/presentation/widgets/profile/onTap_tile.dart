import 'package:flutter/material.dart';

Widget onTapTile(
    {required String title, required IconData icon, required Color iconColor,void Function()? onTap}) {
  return ListTile(
    onTap: onTap,
    leading: Padding(
      padding: const EdgeInsets.only(
        top: 0,
      ),
      child: Icon(
        icon,
        size: 18,
        color: iconColor,
      ),
    ),
    title: Text(
      title,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
    ),
  );
}
