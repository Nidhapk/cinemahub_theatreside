import 'package:equatable/equatable.dart';

abstract class ForgetPassEvent extends Equatable {
  const ForgetPassEvent();

  @override
  List<Object?> get props => [];
}

class SendResetPasswordLink extends ForgetPassEvent {
  final String email;

  const SendResetPasswordLink({required this.email});

  @override
  List<Object?> get props => [email];
}