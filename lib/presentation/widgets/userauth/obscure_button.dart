import 'package:flutter/material.dart';

class CustomObscureButton extends StatelessWidget {
  final bool isObscure;
 final void Function()? onPressed;
  const CustomObscureButton({super.key,required this.isObscure,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed,
      icon: Icon(
                        isObscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colors.grey,
                        size: 19,
                      ),
    ) ;
  }
}