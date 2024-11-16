import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/widget/all_bookings.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<BookingBloc>().add(const FetchAllBookingsEvent());
    return Scaffold(
      body: allBookings(),
    );
  }
}
