import 'package:flutter/material.dart';

class CustomGoogleButton extends StatelessWidget {
  final void Function()? onPressed;
  const CustomGoogleButton({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        child:const  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/search.png',
            //   height: 25,
            //   width: 25,
            // ),
           SizedBox(
              width: 30,
            ),
            Text('Sign in with Google'),
          ],
        ),
      ),
    );
  }
}
