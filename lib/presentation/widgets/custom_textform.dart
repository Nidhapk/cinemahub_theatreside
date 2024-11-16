import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String labelText;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Color? fillColor;
  final Color? hintColor;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final bool? readOnly;
  const CustomTextForm(
      {super.key,
      required this.controller,
      this.validator,
      required this.labelText,
      this.suffixIcon,
      this.obscureText,
      this.onChanged,
      this.fillColor,
      this.hintColor,
      this.onTap,
      this.readOnly});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: TextFormField(
        readOnly: readOnly ?? false,
        onTap: onTap,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        enabled: true,
        controller: controller,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.only(left: 15),
          constraints: const BoxConstraints(minHeight: 50),
          hintStyle: TextStyle(color: hintColor, fontSize: 14),
          hintText: labelText,
          errorStyle: const TextStyle(fontSize: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 0.5,
              color: hintColor ?? white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: mainColor,
              width: 0.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 0.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 0.5,
            ),
          ),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
