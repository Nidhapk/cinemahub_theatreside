import 'package:flutter/material.dart';

Widget itemTile(
    {required String title,
    String? subtitle,
    required IconData icon,
    required Color iconColor}) {
  return ListTile(
    onTap: () {},
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
    subtitle: Text(
      subtitle ?? '',
      style: const TextStyle(
          color: Colors.grey, fontWeight: FontWeight.w300, fontSize: 13),
    ),
  );
}
