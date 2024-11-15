import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';

class RoomsRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addRooms(RoomModel roomModel) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String userId = currentUser.uid;
        RoomModel room =
            RoomModel(userId: userId, roomName: roomModel.roomName, roomId: '');
        final data = await firestore.collection('rooms').add(
              room.toJson(),
            );
        String roomId = data.id;
        await firestore
            .collection('rooms')
            .doc(roomId)
            .update({'roomId': roomId});
      }
    } catch (e) {
      log('error adding room : $e');
    }
  }

  Future<void> deleteRoom(String roomId) async {
    try {
      await FirebaseFirestore.instance.collection('rooms').doc(roomId).delete();
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<void> editRoomName(String roomId, String newName) async {
  try {
    await FirebaseFirestore.instance.collection('rooms').doc(roomId).update({
      'roomName': newName,
    });
    print("Room name updated successfully.");
  } on FirebaseException catch (e) {
    print("Failed to update room name: $e");
    rethrow;
  }
}

  Future<List<RoomModel>> fetchRooms() async {
    try {
      CollectionReference roomsRef =
          FirebaseFirestore.instance.collection('rooms');
      QuerySnapshot snapshot = await roomsRef.get();
      final rooms = snapshot.docs.map((doc) {
        return RoomModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      return rooms;
    } catch (e) {
      log('Error fetching rooms: $e');
      return [];
    }
  }

  Future<void> addAndUpdateSeats(String roomId, RoomModel roomModel) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        RoomModel room = RoomModel(
            roomId: roomModel.roomId,
            userId: currentUser.uid,
            roomName: roomModel.roomName,
            rows: roomModel.rows,
            columns: roomModel.columns,
            seatStates: roomModel.seatStates,
            totalSeats: roomModel.totalSeats);
        await firestore.collection('rooms').doc(roomId).update(
              room.toJson(),
            );
      }
    } catch (e) {
      log('$e');
    }
  }

  //  Future<List<DocumentSnapshot<Object?>>> fetchSeatDetails() async {
  //   try {
  //     CollectionReference roomsRef =
  //         FirebaseFirestore.instance.collection('rooms');
  //     QuerySnapshot snapshot = await roomsRef.get();
  //     return snapshot.docs.toList();
  //   } catch (e) {
  //     log('Error fetching rooms: $e');
  //     return [];
  //   }
  // }

  Future<DocumentSnapshot> fetchseatDetailsDetails(String roomId) async {
    return await firestore.collection('rooms').doc(roomId).get();
  }
}
