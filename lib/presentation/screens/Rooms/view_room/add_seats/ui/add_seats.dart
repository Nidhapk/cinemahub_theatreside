import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';
import 'package:onlinebooking_theatreside/data/repository/rooms_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/common/custom_bottom_appbar.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_textform.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/custom_screen.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/custom_seat_grid.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rooms/seat_container.dart';

class AddSeatsScreen extends StatefulWidget {
  final RoomModel room;
  final String roomId;
  const AddSeatsScreen(
      {super.key, required this.room, required this.roomId});

  @override
  State<AddSeatsScreen> createState() => _AddSeatsScreenState();
}

class _AddSeatsScreenState extends State<AddSeatsScreen> {
  final rowController = TextEditingController();

  final columnController = TextEditingController();
  int _rows = 0;
  int _columns = 0;
  int totalSeats = 0;
  List<SeatStates> _seatStates = [];
  @override
  void initState() {
    super.initState();
    rowController.addListener(generateGrid);
    columnController.addListener(generateGrid);
  }

  void generateGrid() {
    setState(() {
      _rows = int.tryParse(rowController.text) ?? 0;
      _columns = int.tryParse(columnController.text) ?? 0;

      // Default state is 'unselected' for all seats
      _seatStates =
          List<SeatStates>.filled(_rows * _columns, SeatStates.unselected);
    });
  }

  void toggleSeatStateTap(int index) {
    setState(() {
      if (_seatStates[index] == SeatStates.unavailable) {
        _seatStates[index] = SeatStates.unselected;
      } else {
        _seatStates[index] = SeatStates.unavailable;
      }
    });
  }

  // Handle double tap to mark seat as empty
  void toggleSeatStateOnDoubleTap(int index) {
    setState(() {
      if (_seatStates[index] == SeatStates.empty) {
        _seatStates[index] = SeatStates.unselected;
      } else {
        _seatStates[index] = SeatStates.empty;
      }
    });
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
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: CustomTextForm(
                        hintColor: Colors.grey,
                        fillColor: Colors.transparent,
                        controller: rowController,
                        labelText: 'no.of rows'),
                  ),
                  Flexible(
                    child: CustomTextForm(
                        hintColor: Colors.grey,
                        fillColor: Colors.transparent,
                        controller: columnController,
                        labelText: 'no.of columns'),
                  ),
                ],
              ),
              if (_rows > 0 && _columns > 0)
                customseatGrid(
                  height: _rows == 1 ? 55 : _rows * 40.0,
                  itemCount: _rows * _columns,
                  crossAxisCount: _rows,
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
          ),
        ),
        bottomNavigationBar: customBottomappBar(
            onPressed: () async {
              calculateTotalSeats();
              RoomsRepository()
                  .addAndUpdateSeats(
                    widget.roomId,
                    RoomModel(roomId: widget.roomId,
                        userId: FirebaseAuth.instance.currentUser!.uid,
                        roomName: widget.room.roomName,
                        rows: _rows,
                        columns: _columns,
                        seatStates: convertSeatStatesToStrings(_seatStates),
                        totalSeats: totalSeats),
                  )
                  .then((_) => Navigator.of(context).pop());
              context
                  .read<SeatBloc>()
                  .add(FetchSeatsEvent(roomId: widget.roomId));
            },
            text: 'Save'));
  }

  void calculateTotalSeats() {
    if (_seatStates.isNotEmpty) {
      // Filter out empty seats and count only non-empty seats
      totalSeats =
          _seatStates.where((state) => state != SeatStates.empty).length;
    } else {
      totalSeats = 0;
    }
  }

  List<String> convertSeatStatesToStrings(List<SeatStates> seatStates) {
    return seatStates.map((seatState) {
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
    }).toList();
  }
}

enum SeatStates { unselected, selected, empty, unavailable }
