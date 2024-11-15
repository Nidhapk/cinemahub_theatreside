import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/data/repository/user_auth_repository.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/sizedbox_one.dart';

class VerifyScreen extends StatelessWidget {
  final User? user;
  const VerifyScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Check your email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedboxOne(),
            const Text(
              'We have send an email to your account \nopen the email and click on the link to verify!',
              textAlign: TextAlign.center,
            ),
            const SizedboxOne(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                maximumSize: const Size(290, 40),
              ),
              onPressed: () {
                UserAuthRepository().checkVerified(context, user!);
              },
              child: const Text(
                'Yes, I have verified',
              ),
            )
          ],
        ),
      ),
    );
  }
}
