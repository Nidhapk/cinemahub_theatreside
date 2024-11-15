import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class TimeEvent extends Equatable {
  const TimeEvent();

  @override
  List<Object> get props => [];
}

class TimeSelected extends TimeEvent {
  final TimeOfDay selectedTime;

 const TimeSelected(this.selectedTime);

  @override
  List<Object> get props => [selectedTime];
}
