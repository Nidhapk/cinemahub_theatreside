import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/ui/view_shows.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/ui/view_seats_screen.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/add_interface_container.dart';

class ViewRoomScreen extends StatelessWidget {
  final String title;
  final String roomId;
  final RoomModel room;
  const ViewRoomScreen(
      {super.key,
      required this.title,
      required this.roomId,
      required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addInterfaceContainer(
                onTap: () {
                  log('room rows: ${room.rows}');
                  log('viewromm:$room');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => ViewseatsScreen(
                              roomId: roomId,
                              room: room,
                            )
                        //AddSeatsScreen(roomName: title,roomId: roomId
                        // ,),

                        ),
                  );
                },
                assetName: 'assets/577653f8034fcd797578e8d60827930a.jpg',
                gradientColors: [
                  mainColor.withOpacity(0.9),
                  black.withOpacity(0.2),
                ],
                title: 'CREATE INTERFACE',
                subTitle: 'Create interface for \nyour room',
                text: 'CLICK HERE'),
            addInterfaceContainer(
                onTap: () {
                  context.read<ShowBloc>().add(FetchAllShows());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewShowsScreen(
                            room: room,
                            roomId: roomId,
                          )));
                },
                assetName: 'assets/movieShows.jpg',
                gradientColors: [
                  black.withOpacity(0.7),
                  white.withOpacity(0.3)
                ],
                title: 'ADD SHOWS',
                subTitle: 'Add upcoming shows here',
                text: 'CLICK HERE')
          ],
        ),
      ),
    );
  }
}
