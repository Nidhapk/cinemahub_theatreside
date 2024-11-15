import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_textstyles.dart';

class CustomForgetPassTextButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomForgetPassTextButton({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.6),
      child: TextButton(
        onPressed:onPressed,
        child: const Text(
          'Forget password ? ',
          style: AppTextStyles.forgetPassStyle,
        ),
      ),
    );
  }
}
