// ignore_for_file: use_super_parameters

import 'package:equatable/equatable.dart';

abstract class SigInState extends Equatable {
  final bool isObscure;

  const SigInState({required this.isObscure});

  @override
  List<Object> get props => [isObscure];
}

class SigInInitial extends SigInState {
  const SigInInitial({required bool isObscure}) : super(isObscure: isObscure);
}

class SigInButtonPressed extends SigInState {
  const SigInButtonPressed({required bool isObscure}) : super(isObscure: isObscure);
}

class SigInSuccess extends SigInState {
  const SigInSuccess({required bool isObscure}) : super(isObscure: isObscure);
}

class SigInFailure extends SigInState {
  final String message;

  const SigInFailure({required this.message, required bool isObscure}) : super(isObscure: isObscure);

  @override
  List<Object> get props => [message, isObscure];
}
class GoogleSiginintialState extends SigInState{
  const GoogleSiginintialState({required bool isObscure}) : super(isObscure: isObscure);
}
