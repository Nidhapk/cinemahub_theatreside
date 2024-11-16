import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onlinebooking_theatreside/data/models/booking/booking_model.dart';

class BookingsRepository {
  final bookingCollection = FirebaseFirestore.instance.collection('booking');

  Future<List<BookingModel>> fetchallBookings() async {
    try {
      final snapshot = await bookingCollection.get();
      final List<BookingModel> bookings = snapshot.docs.map((doc) {
        return BookingModel.fromJson(doc.data());
      }).toList();
      return bookings;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future<List<BookingModel>> fetchBookingsByTheatreId() async {
    try {
      final allBookings = await fetchallBookings();
      final filteredBookings = allBookings.where((booking) {
        return booking.theatreId == FirebaseAuth.instance.currentUser!.email;
      }).toList();
      return filteredBookings;
    } catch (_) {
      rethrow;
    }
  }
}
