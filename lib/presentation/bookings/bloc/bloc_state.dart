import 'package:equatable/equatable.dart';
import 'package:onlinebooking_theatreside/data/models/booking/booking_model.dart';

abstract class BookingStates extends Equatable {
  const BookingStates();
  @override
  List<Object> get props => [];
}

class BookingsLoadingState extends BookingStates {
  const BookingsLoadingState();
  @override
  List<Object> get props => [];
}

class BookingsLoadedState extends BookingStates {
  final List<BookingModel> bookingModel;
  const BookingsLoadedState({required this.bookingModel});
  @override
  List<Object> get props => [bookingModel];
}

class BookingsLoadedErrorState extends BookingStates {
  final String error;
  const BookingsLoadedErrorState({required this.error});
  @override
  List<Object> get props => [error];
}