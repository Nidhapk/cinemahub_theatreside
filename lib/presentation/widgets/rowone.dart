import 'package:flutter/material.dart';

class RowOne extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final String textTwo;
  const RowOne(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.textTwo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textTwo),
        TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(color: Colors.indigo),
          ),
        )
      ],
    );
  }
}
