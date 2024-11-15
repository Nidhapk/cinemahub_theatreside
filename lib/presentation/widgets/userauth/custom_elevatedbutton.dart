import 'package:flutter/material.dart';

class CustomAccesButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomAccesButton({super.key, required this.onPressed,required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        child:  Text(text),
      ),
    );
  }
}
