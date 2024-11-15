import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/user_auth_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signup/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signup/bloc/bloc_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc()
      : super(const SignUpInitial(isObscure1: true, isObscure2: true)) {
    on<SignUpRequestedEvent>(signUpRequested);
    on<ToggleObscureButton>(toggledObscureButton);
  }

  Future<void> signUpRequested(
      SignUpRequestedEvent event, Emitter<SignUpState> emit) async {
    emit(
      SignUpInProgress(
          isObscure1: state.isObscure1, isObscure2: state.isObscure2),
    );
    try {
      await UserAuthRepository().signUp(event.email, event.password);
      
      emit(
        SignUpSuccess(
            isObscure1: state.isObscure1, isObscure2: state.isObscure2),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          emit(
            SignUpFailure(
                error:
                    'The email address is already in use by another account.',
                isObscure1: state.isObscure1,
                isObscure2: state.isObscure2),
          );
          break;
        case 'invalid-email':
          emit(
            SignUpFailure(
                error: 'The email address is not valid.',
                isObscure1: state.isObscure1,
                isObscure2: state.isObscure2),
          );
          break;
        default:
          emit(
            SignUpFailure(
                error: 'An unknown error occurred: ${e.message}',
                isObscure1: state.isObscure1,
                isObscure2: state.isObscure2),
          );
          break;
      }
    } on SocketException {
      emit(
        SignUpFailure(
            error:
                'No internet connection. Please check your network settings.',
            isObscure1: state.isObscure1,
            isObscure2: state.isObscure2),
      );
    } on TimeoutException {
      emit(
        SignUpFailure(
            error: 'The request timed out. Please try again later.',
            isObscure1: state.isObscure1,
            isObscure2: state.isObscure2),
      );
    } catch (e) {
      emit(
        SignUpFailure(
            error: 'An unexpected error occurred: $e',
            isObscure1: state.isObscure1,
            isObscure2: state.isObscure2),
      );
    }
  }

  toggledObscureButton(ToggleObscureButton event, Emitter<SignUpState> emit) {
    if (event.field == 'firstField') {
      emit(
        SignUpInitial(
            isObscure1: !state.isObscure1, isObscure2: state.isObscure2),
      );
    } else if (event.field == 'secondField') {
      emit(
        SignUpInitial(
            isObscure1: state.isObscure1, isObscure2: !state.isObscure2),
      );
    }
  }
}
