// ignore_for_file: use_super_parameters

import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
 final bool isObscure1;
 final bool isObscure2;
  const SignUpState({required this.isObscure1,required this.isObscure2});

  @override
  List<Object> get props => [isObscure1,isObscure2];
}

class SignUpInitial extends SignUpState {
const SignUpInitial({required bool isObscure1,required bool isObscure2}) : super(isObscure1: isObscure1,isObscure2: isObscure2);
}

class SignUpInProgress extends SignUpState {
  const SignUpInProgress({required bool isObscure1,required bool isObscure2}) : super(isObscure1: isObscure1,isObscure2: isObscure2);
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess({required bool isObscure1,required bool isObscure2}) : super(isObscure1: isObscure1,isObscure2: isObscure2);
}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({required this.error, required bool isObscure1,required bool isObscure2}) : super(isObscure1: isObscure1,isObscure2: isObscure2);

  @override
  List<Object> get props => [error, isObscure1,isObscure2];
}
