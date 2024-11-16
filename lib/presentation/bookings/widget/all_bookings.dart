import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/models/booking/booking_model.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/widget/bookings_builder.dart';

Widget allBookings() {
  return BlocBuilder<BookingBloc, BookingStates>(builder: (context, state) {
    if (state is BookingsLoadingState) {
      return const CircularProgressIndicator();
    } else if (state is BookingsLoadedState) {
      final bookings = state.bookingModel;
      final sortedBookings = List<BookingModel>.from(bookings)
        ..sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
      return bookingBuilder(context: context, booking: sortedBookings);
    } else if (state is BookingsLoadedErrorState) {
      return Text(state.error);
    } else {
      return const Text('Something went wrong');
    }
  });
}
