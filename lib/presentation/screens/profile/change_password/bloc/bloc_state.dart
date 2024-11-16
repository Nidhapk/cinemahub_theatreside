import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
  @override
  List<Object> get props => [];
}
class PasswordChangingInitialState extends ChangePasswordState {
  const PasswordChangingInitialState();
  @override
  List<Object> get props => [];
}

class PasswordChangingState extends ChangePasswordState {
  const PasswordChangingState();
  @override
  List<Object> get props => [];
}

class PasswordChangedState extends ChangePasswordState {
  const PasswordChangedState();
  @override
  List<Object> get props => [];
}

class PasswordChangedErrorState extends ChangePasswordState {
  final String error;
  const PasswordChangedErrorState(this.error);
  @override
  List<Object> get props => [error];
  
}
