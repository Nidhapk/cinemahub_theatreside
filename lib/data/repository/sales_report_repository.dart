import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:onlinebooking_theatreside/data/models/booking/booking_model.dart';

class SalesReportRepository {
  final bookingCollection = FirebaseFirestore.instance.collection('booking');

  Future<Map<String, double>> calculateSalesReport(String movieName) async {
    try {
      final docRef = await bookingCollection.get();
      final List<BookingModel> allBookings =
          docRef.docs.map((doc) => BookingModel.fromJson(doc.data())).toList();
      log('all:$allBookings');
      final List<BookingModel> filteredBookings = allBookings
          .where((booking) =>
              booking.theatreId == FirebaseAuth.instance.currentUser!.email)
          .toList();
      log('filteres: $filteredBookings');
       final List<BookingModel> bookingsToCalculate = movieName == "All Movies"
        ? filteredBookings
        : filteredBookings
            .where((booking) => booking.movieName == movieName)
            .toList();
      Map<String, double> monthlySales = {};
      for (var booking in bookingsToCalculate) {
        DateTime date = booking.showDate;
        String monthYear = '${date.year}-${date.month}';

        monthlySales[monthYear] =
            (monthlySales[monthYear] ?? 0) + booking.totalAmount;
      }
      log('eport:$monthlySales');
      return monthlySales;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<List<FlSpot>> getSalesSpots(String movieName) async {
    Map<String, double> salesReport = await calculateSalesReport(movieName);
    List<FlSpot> salesSpots = [];
    for (int i = 1; i <= 12; i++) {
      String monthKey = '${DateTime.now().year}-$i';
      double sales = salesReport[monthKey] ?? 0;
      salesSpots.add(FlSpot(i.toDouble(), sales));
    }

    return salesSpots;
  }

  Future<Map<String, dynamic>> calculatebookings(String movieName) async {
  try {
    final docRef = await bookingCollection.get();
    final List<BookingModel> allBookings =
        docRef.docs.map((doc) => BookingModel.fromJson(doc.data())).toList();
    log('All bookings: $allBookings');

    // Filter bookings by the current theatre's email
    final List<BookingModel> filteredBookings = allBookings
        .where((booking) =>
            booking.theatreId == FirebaseAuth.instance.currentUser!.email)
        .toList();
    log('Filtered bookings by theatre: $filteredBookings');

    // Further filter by movie name if a specific movie is selected
    final List<BookingModel> bookingsToCalculate = movieName == "All Movies"
        ? filteredBookings
        : filteredBookings
            .where((booking) => booking.movieName == movieName)
            .toList();
    log('Bookings for selected movie: $bookingsToCalculate');

    // Initialize counters
    double totalAmount = 0.0;
    int ticketCount = 0;

    // Calculate total amount and ticket count
    for (var booking in bookingsToCalculate) {
      totalAmount += booking.totalAmount;
      ticketCount += 1;  // Each booking is considered a ticket sale
    }

    // Create report map
    Map<String, dynamic> report = {
      "totalAmount": totalAmount,
      "ticketCount": ticketCount
    };

    log('Sales report: $report');
    return report;
  } on FirebaseException catch (_) {
    rethrow;
  }
}
}
