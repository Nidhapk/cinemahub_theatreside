import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
  @override
  List<Object> get props => [];
}

class PasswordChangedEvent extends ChangePasswordEvent {
  final String password;
  const PasswordChangedEvent(this.password);
  @override
  List<Object> get props => [password];
}
