import 'package:flutter/material.dart';

class ListItem {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  ListItem({
    required this.icon,
    required this.title,
    this.onTap ,
  });
}
