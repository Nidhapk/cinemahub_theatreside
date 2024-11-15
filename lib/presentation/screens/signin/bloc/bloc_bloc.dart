import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/user_auth_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signin/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signin/bloc/bloc_state.dart';

class SignInBloc extends Bloc<SignInEvent, SigInState> {
  SignInBloc() : super(const SigInInitial(isObscure: true)) {
    on<SignInRequested>(signinRequest);
    on<ToggleObscureText>(toggledobscureText);
    on<GoogleSiginEvent>(googleSiginRequested);
  }

  Future<void> signinRequest(
    SignInRequested event,
    Emitter<SigInState> emit,
  ) async {
    emit(
      const SigInButtonPressed(isObscure: true),
    );

    try {
      await UserAuthRepository().sigin(event.email, event.password);
      emit(
        SigInSuccess(isObscure: state.isObscure),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' || e.code == 'invalid-credential') {
        emit(
          SigInFailure(
              message: 'Invalid email or password', isObscure: state.isObscure),
        );
      } else if (e.code == 'network-request-failed') {
        emit(
          SigInFailure(
              message: 'Network error : Try again later',
              isObscure: state.isObscure),
        );
      } else {
        emit(
          SigInFailure(
              message: 'An unexpected error occurred.',
              isObscure: state.isObscure),
        );
      }
    } catch (e) {
      emit(
        SigInFailure(message: '$e', isObscure: true),
      );
    }
  }

  void toggledobscureText(ToggleObscureText event, Emitter<SigInState> emit) {
    emit(
      SigInInitial(isObscure: !state.isObscure),
    );
  }

  Future<void> googleSiginRequested(
      GoogleSiginEvent evet, Emitter<SigInState> emit) async {
    emit(
      SigInInitial(isObscure: state.isObscure),
    );
    try {
      await UserAuthRepository().signInWithGoogle();
      emit(
        SigInSuccess(isObscure: state.isObscure),
      );
    } on FirebaseAuthException catch (e) {
      String? errorMessage;
      switch (e.code) {
        case 'sign_in_failed':
          errorMessage = "Sign-In failed. Please try again.";
          break;
        case 'account_not_found':
          errorMessage = "Google account not found.";
          break;
        default:
          errorMessage = "An unknown error occurred: ${e.message}";
      }
      emit(
        SigInFailure(message: errorMessage, isObscure: state.isObscure),
      );
    } on SocketException {
      emit(
        SigInFailure(
          message:
              'No internet connection. Please check your network settings.',
          isObscure: state.isObscure,
        ),
      );
    } on TimeoutException {
      emit(
        SigInFailure(
          message: 'The request timed out. Please try again later.',
          isObscure: state.isObscure,
        ),
      );
    }
  }
}
