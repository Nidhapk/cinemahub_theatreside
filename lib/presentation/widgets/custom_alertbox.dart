import 'package:flutter/material.dart';

class CustomAlertBox extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
 final void Function()? onPressed;
  const CustomAlertBox(
      {super.key,
      required this.title,
      required this.content,
      required this.confirmText,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed:onPressed,
            child: Text(confirmText),
          )
        ]);
  }
}
