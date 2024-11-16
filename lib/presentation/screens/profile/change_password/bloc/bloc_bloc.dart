import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/user_auth_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/change_password/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/change_password/bloc/bloc_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(const PasswordChangingInitialState()) {
    on<PasswordChangedEvent>(changePassword);
  }

  Future<void> changePassword(
      PasswordChangedEvent event, Emitter<ChangePasswordState> emit) async {
    emit(
      const PasswordChangingState(),
    );
    try {
      await UserAuthRepository().changePassword(event.password);
      emit(const PasswordChangedState());
    } catch (e) {
      log('$e');
      emit(
        PasswordChangedErrorState('error:$e'),
      );
    }
  }
}
