import 'package:equatable/equatable.dart';

abstract class BookingEvents extends Equatable {
  const BookingEvents();
  @override
  List<Object> get props => [];
}

class FetchAllBookingsEvent extends BookingEvents {

  const FetchAllBookingsEvent();
  @override
  List<Object> get props => [];
}
