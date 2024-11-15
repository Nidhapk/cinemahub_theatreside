import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Drawer/home_screen.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_profile/add_profile.dart';
import 'package:onlinebooking_theatreside/presentation/screens/splash/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/splash/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/splash/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/screens/verify/verify_screen.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_alertbox.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashScreenbloc>().add(
          CheckLoginEvent(),
        );
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: BlocConsumer<SplashScreenbloc, SplashScreenStates>(
        builder: (context, state) {
          if (state is SplashScreenLoginCheckingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SplashScreenLoginCheckingErrorState) {
            return CustomAlertBox(
              title: 'Alert',
              content: state.message,
              confirmText: 'Ok',
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          } else {
            return const Center(
              child: Text('WELCOME'),
            );
          }
        },
        listener: (context, state) {
          if (state is SplashScreenNavigateToHomeScreenState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (context) => false);
          } else if (state is SplashScreenNavigateToLoginScreenState) {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/signIn', (context) => false);
          } else if (state is SplashScreenEmailVerificationCheckState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      VerifyScreen(user: FirebaseAuth.instance.currentUser),
                ),
                (context) => false);
          } else if (state is SplashScreenNavigateToProfileState) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AddProfileScreen(address: ''),
              ),
            );
          }
        },
      ),
    );
  }
}
