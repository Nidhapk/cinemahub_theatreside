import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/data/models/theatre_model/thatre_model.dart';

abstract class AddProfileEvent extends Equatable {
  const AddProfileEvent();
  @override
  List<Object> get props => [];
}

class AddProfileOnClickedEvent extends AddProfileEvent {
  final TheatreModel theatre;
  const AddProfileOnClickedEvent(
    this.  theatre);
  @override
  List<Object> get props => [];
}
