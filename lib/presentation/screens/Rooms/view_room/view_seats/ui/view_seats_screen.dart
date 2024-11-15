import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/add_seats/ui/add_seats.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/edit_seat/ui/edit_seat_screen.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/bloc/bloc_states.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/custom_seat_grid.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/seat_container.dart';

class ViewseatsScreen extends StatelessWidget {
  final String roomId;
  final RoomModel room;
  const ViewseatsScreen({super.key, required this.roomId, required this.room});

  @override
  Widget build(BuildContext context) {
    context.read<SeatBloc>().add(FetchSeatsEvent(roomId: roomId));
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<SeatBloc, SeatState>(
              builder: (context, state) {
                if (state is SeatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SeatLoaded) {
                  final roomData = state.rooms.data() as Map<String, dynamic>?;
                  if (roomData == null) {
                    return const Center(
                      child:
                          Text('Click add to create interface for your room'),
                    );
                  } else if (roomData['rows'] == 0) {
                    return const Center(
                      child: Text('No interface has been created yet.'),
                    );
                  } else {
                    return customseatGrid(
                      height: (roomData['rows'] * 30).toDouble(),
                      itemCount: roomData['rows'] * roomData['columns'],
                      crossAxisCount: roomData['rows'],
                      itemBuilder: (context, index) {
                        return seatContainer(
                          onDoubleTap: () {},
                          emptySeatCondition:
                              roomData['seatDetails'][index] != 'empty',
                          disAbledSeatCondition:
                              roomData['seatDetails'][index] == 'unavailable',
                          onTap: () {},
                        );
                      },
                    );
                  }
                } else if (state is SeatLoadedError) {
                  return Center(
                    child: Text("Error: ${state.error}"),
                  );
                } else {
                  return const Center(
                    child: Text("something went wrong"),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<SeatBloc, SeatState>(
        builder: (context, state) {
          return FloatingActionButton.small(
            backgroundColor: Colors.transparent,
            onPressed: () {
              if (state is SeatLoaded) {
                final roomData = state.rooms.data() as Map<String, dynamic>?;
                if (roomData != null && roomData['rows'] == null) {
                  log('roo:$room');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AddSeatsScreen(room: room, roomId: roomId),
                    ),
                  );
                } else {
                  log('rood:$room');
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditSeatsScreen(
                          room: room, roomId: roomId)));
                }
              }
            },
            child: const Icon(Icons.add_road_sharp),
          );
        },
      ),
    );
  }
}
