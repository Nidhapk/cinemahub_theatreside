import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TimeState extends Equatable {
  const TimeState();

  @override
  List<Object> get props => [];
}

class TimeInitial extends TimeState {}

class TimeLoaded extends TimeState {
  final TimeOfDay selectedTime;

  const TimeLoaded(this.selectedTime);

  @override
  List<Object> get props => [selectedTime];
}
