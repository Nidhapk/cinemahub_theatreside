import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/room_home/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/room_home/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/room_home/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_room/view_room.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_textstyles.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/add_bottomsheet.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/add_room_container.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/room_container.dart';

class RoomsScreen extends StatelessWidget {
  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController editroomNameController = TextEditingController();
  RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<RoomBloc>().add(FetchRoomsEvent());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.black,
        mainColor,
        Color.fromARGB(255, 144, 118, 247),
        // Colors.black,
      ], begin: Alignment.topCenter, end: Alignment.bottomRight)),
      child: SingleChildScrollView(
        child: BlocConsumer<RoomBloc, RoomState>(
          listener: (context, state) {
            if (state is RoomAddedSuccess) {
              context.read<RoomBloc>().add(FetchRoomsEvent());
              Navigator.of(context).pop();
            } else if (state is RoomAdding) {
              const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is RoomEditedSuccessState) {
              context.read<RoomBloc>().add(FetchRoomsEvent());
            } else if (state is RoomDeletedState) {
              context.read<RoomBloc>().add(FetchRoomsEvent());
            }
          },
          builder: (context, state) {
            if (state is RoomLoaded) {
              final filteredRooms = state.rooms;
              return Column(
                children: [
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Rooms',
                            style: AppTextStyles.roomHeadTextstyle,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(
                            '2',
                            style: AppTextStyles.roomsubtitleTextstyle,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Seats',
                            style: AppTextStyles.roomHeadTextstyle,
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text(
                            '100',
                            style: AppTextStyles.roomsubtitleTextstyle,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Available Seats',
                            style: AppTextStyles.roomHeadTextstyle,
                          ),
                          SizedBox(
                            height: height * 0.037,
                          ),
                          CircularProgressIndicator(
                            value: 0.6,
                            color: white,
                            backgroundColor: Colors.grey,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: mainColor,
                        ),
                        color: const Color.fromARGB(255, 28, 27, 27),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: width * 0.1,
                            crossAxisCount: 2),
                        itemCount: filteredRooms.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return addRoomContainer(
                              onTap: () {
                                addRoomsheet(
                                  context,
                                  roomNameController,
                                  buttononPressed: () {
                                    context.read<RoomBloc>().add(
                                          AddRoomEvent(
                                              room: RoomModel(
                                                  roomId: '',
                                                  userId: FirebaseAuth.instance
                                                      .currentUser!.uid,
                                                  roomName: roomNameController
                                                      .text
                                                      .trim())),
                                        );
                                  },
                                );
                              },
                            );
                          } else {
                            final room = filteredRooms[index - 1];
                            editroomNameController.text = room.roomName;

                            return roomContainer(context,
                                onTap: () {
                                  log('roomhome:${room}');
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewRoomScreen(
                                        room: room,
                                        title: room.roomName,
                                        roomId: room.roomId,
                                      ),
                                    ),
                                  );
                                },
                                text: room.roomName,
                                deleteonTap: () {
                                  context
                                      .read<RoomBloc>()
                                      .add(DeleteRoomEvent(room.roomId));
                                },
                                editonTap: () {
                                  addRoomsheet(
                                    context,
                                    editroomNameController,
                                    buttononPressed: () {
                                      context.read<RoomBloc>().add(
                                          EditRoomEvent(
                                              roomId: room.roomId,
                                              roomName: editroomNameController
                                                  .text
                                                  .trim()));
                                    },
                                  );
                                });
                          }
                        },
                      ),
                    ),
                  )
                ],
              );
            } else if (state is RoomAddedError) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
