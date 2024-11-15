import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/user_auth_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/splash/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/splash/bloc/bloc_state.dart';

class SplashScreenbloc extends Bloc<SplashscreenEvent, SplashScreenStates> {
  SplashScreenbloc() : super(SplashScreenInitialState()) {
    on<CheckLoginEvent>(onCheckLogin);
  }

  Future<void> onCheckLogin(
      CheckLoginEvent event, Emitter<SplashScreenStates> emit) async {
    try {
      emit(
        SplashScreenLoginCheckingState(),
      );
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Future.delayed(
          const Duration(seconds: 3),
        );
        await user.reload();
        bool signedInWithGoogle = user.providerData
            .any((userInfo) => userInfo.providerId == 'google.com');
        if (signedInWithGoogle == true) {
          emit(
            SplashScreenNavigateToHomeScreenState(),
          );
        } else if (user.emailVerified) {
          final userDoc = await FirebaseFirestore.instance
              .collection('theatres')
              .doc(user.uid)
              .get();
          if (userDoc.exists) {
            emit(SplashScreenNavigateToHomeScreenState());
          }else{emit(
            SplashScreenNavigateToProfileState(),
          );}
          
        } else {
          UserAuthRepository().sendVerificationLink();
          emit(
            SplashScreenEmailVerificationCheckState(),
          );
        }
      } else {
        emit(
          SplashScreenNavigateToLoginScreenState(),
        );
      }
    } on SocketException {
      emit(
        const SplashScreenLoginCheckingErrorState(
            'No internet connection. Please check your network settings.'),
      );
    } on TimeoutException {
      emit(
        const SplashScreenLoginCheckingErrorState(
            'The request timed out. Please try again later.'),
      );
    } on FirebaseAuthException catch (e) {
      emit(
        SplashScreenLoginCheckingErrorState('An error occured : $e'),
      );
    }
  }
}
