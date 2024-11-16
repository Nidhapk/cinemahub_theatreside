import 'package:flutter/material.dart';
import 'package:onlinebooking_theatreside/data/models/booking/booking_model.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/widget/booking_container.dart';

Widget bookingBuilder(
    {required BuildContext context, required List<BookingModel> booking}) {
  final width = MediaQuery.of(context).size.width;
  return ListView.builder(
    padding: EdgeInsets.all(width * 0.05),
    itemCount: booking.length,
    itemBuilder: (context, index) {
      return bookingContainer(
        context: context,
        bookingModel: booking[index],
      );
    },
  );
}
