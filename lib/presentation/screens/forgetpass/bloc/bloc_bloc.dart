import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/user_auth_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/forgetpass/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/forgetpass/bloc/bloc_state.dart';

class ForgetPassBloc extends Bloc<ForgetPassEvent, ForgetPassState> {
  ForgetPassBloc() : super(ForgetPassInitial()) {
    on<SendResetPasswordLink>(sendForgetPassLink);
  }
  Future<void> sendForgetPassLink(
      SendResetPasswordLink event, Emitter<ForgetPassState> emit) async {
    emit(
      ForgetPassLoading(),
    );
    try {
      await UserAuthRepository().sendResetPasswordLink(event.email);
      emit(
        ForgetPassEmailSendSuccess(),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid';
          break;
        case 'user-not-found':
          errorMessage = 'No user found with this email address.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      emit(
        ForgetPassEmailFailure(errorMessage),
      );
    } on SocketException {
      emit(
        const ForgetPassEmailFailure(
            'Network error.Please check your internet connection and try again.'),
      );
    } on TimeoutException {
      emit(
        const ForgetPassEmailFailure(
            'The request timedout.Please try again later.'),
      );
    } catch (e) {
      emit(
        const ForgetPassEmailFailure(
            'An unexpected error occurred. Please try again.'),
      );
    }
  }
}
