import 'package:equatable/equatable.dart';

abstract class SplashscreenEvent extends Equatable {
  const SplashscreenEvent();

  @override
  List<Object?> get props => [];
}

class CheckLoginEvent extends SplashscreenEvent {}
