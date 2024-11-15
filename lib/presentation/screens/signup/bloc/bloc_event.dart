import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequestedEvent extends SignUpEvent {
  final String email;
  final String password;

 const SignUpRequestedEvent(this.email, this.password);
}

class ToggleObscureButton extends SignUpEvent {
  final String field;
  const ToggleObscureButton(this.field);
}
