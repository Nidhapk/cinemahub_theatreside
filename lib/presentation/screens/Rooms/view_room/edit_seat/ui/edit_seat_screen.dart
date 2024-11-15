import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';
import 'package:onlinebooking_theatreside/data/repository/rooms_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/add_seats/ui/add_seats.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/edit_seat/ui/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/edit_seat/ui/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/edit_seat/ui/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/common/custom_bottom_appbar.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_textform.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/custom_screen.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/custom_seat_grid.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/seat_container.dart';

class EditSeatsScreen extends StatefulWidget {
  final RoomModel room;
  final String roomId;
  const EditSeatsScreen(
      {super.key, required this.room, required this.roomId});

  @override
  State<EditSeatsScreen> createState() => _EditSeatsScreenState();
}

class _EditSeatsScreenState extends State<EditSeatsScreen> {
  TextEditingController rowController = TextEditingController();

  TextEditingController columnController = TextEditingController();

  int totalSeats = 0;
  List<SeatStates> _seatStates = [];
  @override
  void initState() {
    super.initState();
    context.read<EditSeatBloc>().add(FetchEditSeatsEvent(widget.roomId));
  }

  void generateGrid(int newRows, int newColumns) {
    context.read<EditSeatBloc>().add(
          UpdateGridDimensionsEvent(newRows, newColumns),
        );
  }

  void toggleSeatStateTap(int index) {
    context.read<EditSeatBloc>().add(
          UpdateSeatStateOnTapEvent(index),
        );
  }

  void toggleSeatStateOnDoubleTap(int index) {
    context.read<EditSeatBloc>().add(
          UpdateSeatStateOnDoubleTapEvent(index),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu_book_outlined),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<EditSeatBloc, EditSeatsState>(
          builder: (context, state) {
            if (state is EditSeatsLoaded) {
              rowController.text = state.rows.toString();
              columnController.text = state.columns.toString();
              log(' edit page : ${state.seatStates}');
              _seatStates = List<SeatStates>.from(state.seatStates);
              return Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: CustomTextForm(
                          hintColor: Colors.grey,
                          fillColor: Colors.transparent,
                          controller: rowController,
                          labelText: 'no.of rows',
                          onChanged: (value) {
                            generateGrid(int.parse(value),
                                int.parse(columnController.text));
                          },
                        ),
                      ),
                      Flexible(
                        child: CustomTextForm(
                          hintColor: Colors.grey,
                          fillColor: Colors.transparent,
                          controller: columnController,
                          labelText: 'no.of columns',
                          onChanged: (value) {
                            generateGrid(int.parse(rowController.text),
                                int.parse(value));
                          },
                        ),
                      ),
                    ],
                  ),
                  if (state.rows > 0 && state.columns > 0)
                    customseatGrid(
                      height: state.rows == 1 ? 55 : state.rows * 40.0,
                      itemCount: state.rows * state.columns,
                      crossAxisCount: state.rows,
                      itemBuilder: (context, index) {
                        return seatContainer(
                          onDoubleTap: () => setState(
                            () {
                              toggleSeatStateOnDoubleTap(index);
                            },
                          ),
                          onTap: () => setState(
                            () {
                              toggleSeatStateTap(index);
                            },
                          ),
                          emptySeatCondition:
                              _seatStates[index] != SeatStates.empty,
                          disAbledSeatCondition:
                              _seatStates[index] == SeatStates.unavailable,
                        );
                      },
                    ),
                  customScreen(),
                ],
              );
            } else if (state is EditSeatsLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
      ),
      bottomNavigationBar: customBottomappBar(
          onPressed: () async {
            calculateTotalSeats();
            RoomsRepository()
                .addAndUpdateSeats(
                  widget.roomId,
                  RoomModel(
                      roomId: widget.roomId,
                      userId: FirebaseAuth.instance.currentUser!.uid,
                      roomName: widget.room.roomName,
                      rows: int.parse(rowController.text),
                      columns: int.parse(columnController.text),
                      seatStates: convertSeatStatesToStrings(_seatStates),
                      totalSeats: totalSeats),
                )
                .then((_) => Navigator.of(context).pop());
            context
                .read<SeatBloc>()
                .add(FetchSeatsEvent(roomId: widget.roomId));
          },
          text: 'Edit'),
    );
  }

  void calculateTotalSeats() {
    if (_seatStates.isNotEmpty) {
      totalSeats =
          _seatStates.where((state) => state != SeatStates.empty).length;
    } else {
      totalSeats = 0;
    }
  }

  List<String> convertSeatStatesToStrings(List<SeatStates> seatStates) {
    return seatStates.map(
      (seatState) {
        switch (seatState) {
          case SeatStates.unselected:
            return 'unselected';
          case SeatStates.selected:
            return 'selected';
          case SeatStates.empty:
            return 'empty';
          case SeatStates.unavailable:
            return 'unavailable';
        }
      },
    ).toList();
  }

  SeatStates convertStringToSeatState(String seatState) {
    switch (seatState) {
      case 'selected':
        return SeatStates.selected;
      case 'empty':
        return SeatStates.empty;
      case 'unavailable':
        return SeatStates.unavailable;
      case 'unselected':
      default:
        return SeatStates.unselected;
    }
  }
}
