import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/ui/add_show_screen.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/edit_show/ui/edit_show.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_alertbox.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_snackbox.dart';

class ViewShowsScreen extends StatelessWidget {
  final String roomId;
  final RoomModel room;
  const ViewShowsScreen({super.key, required this.roomId, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 13, 13),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Shows',
          style: TextStyle(color: grey),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: BlocConsumer<ShowBloc, ShowState>(
          listener: (context, state) {
            if (state is ShowDeletedSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                  text: state.message,
                  icon: Icons.check_circle_rounded,
                  iconColor: green,
                  borderColor: green,
                  backgroundColor: black));
              context.read<ShowBloc>().add(FetchAllShows(roomId));
            } else if (state is ShowDeletedeErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                  text: state.error,
                  icon: Icons.error,
                  iconColor: red,
                  borderColor: red,
                  backgroundColor: black));
            }
          },
          builder: (context, state) {
            if (state is ShowsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ShowsLoadedState) {
              final shows = state.shows;
              if (state.shows.isEmpty) {
                return const Center(
                  child: Text('No Shows has been added yet.'),
                );
              } else {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        const Color.fromARGB(255, 17, 17, 17).withOpacity(0.8),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: shows.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, bottom: 20.0, top: 20),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 60,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 58, 58, 58),
                                    border: Border.all(color: black),
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            NetworkImage(shows[index].poster)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                '${shows[index].movieName}\n'),
                                        TextSpan(
                                            text:
                                                'Date :   ${DateFormat('MMM dd yyyy').format(shows[index].date)}\n'),
                                        TextSpan(
                                            text:
                                                'Time : ${shows[index].time}\n'),
                                        TextSpan(
                                            text:
                                                'Language : ${shows[index].language}'),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 53),
                                  child: PopupMenuButton<String>(
                                    color:
                                        const Color.fromARGB(255, 13, 13, 13),
                                    padding: const EdgeInsets.only(
                                        right: 5, bottom: 25, top: 0),
                                    icon: const Icon(
                                      Icons.more_vert_outlined,
                                      color: grey,
                                      size: 20,
                                    ),
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        // context.read<MovieBloc>().add(
                                        //       FetchMovieEvent(movie.movieId ?? ''),
                                        //     );
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditShowsScreen(
                                              roomModel: room,
                                              roomId: roomId,
                                              show: shows[index],
                                            ),
                                          ),
                                        );
                                      } else if (value == 'delete') {
                                        context.read<ShowBloc>().add(
                                              DeleteShowEvent(
                                                  shows[index].showId),
                                            );
                                        // context.read<MovieBloc>().add(
                                        //       BlockMovieEvent(
                                        //           blocked: true,
                                        //           movieId: movie.movieId ?? '',
                                        //           trailerLink: movie.trailerLink,
                                        //           movieName: movie.movieName,
                                        //           certificate: movie.certificate,
                                        //           languages: movie.languages,
                                        //           genres: movie.genres,
                                        //           releaseDate: movie.releaseDate,
                                        //           duration: movie.duration,
                                        //           description: movie.description,
                                        //           castMembers: movie.castMembers,
                                        //           posterImage: movie.posterImage,
                                        //           backdropImage: movie.backdropImage),
                                        //     );
                                      }
                                    },
                                    itemBuilder: (BuildContext context) =>
                                        <PopupMenuEntry<String>>[
                                      const PopupMenuItem<String>(
                                        height: 10,
                                        value: 'edit',
                                        padding: EdgeInsets.only(
                                            top: 5), // Adjust padding here
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text('Edit     ',
                                                style: TextStyle(fontSize: 12)),
                                            Icon(
                                              Icons.edit_note,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const PopupMenuItem<String>(
                                        height: 10,
                                        value: 'delete',
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: 5), // Adjust padding here
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Cancel',
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Icon(
                                              Icons.delete_sweep_outlined,
                                              size: 16,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]));
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 0,
                        thickness: 0.8,
                        color: Color.fromARGB(255, 13, 13, 13),
                      );
                    },
                  ),
                );
              }
            } else if (state is ShowsLoadederrorState) {
              return CustomAlertBox(
                  title: ' Error',
                  content: state.error,
                  confirmText: 'Ok',
                  onPressed: () {
                    Navigator.of(context).pop();
                  });
            } else {
              return CustomAlertBox(
                  title: ' Something went wrong',
                  content: 'unable to load shows, try again later.',
                  confirmText: 'Ok',
                  onPressed: () {
                    Navigator.of(context).pop();
                  });
            }
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor:
                  const Color.fromARGB(255, 17, 17, 17).withOpacity(0.8)),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddShowsScreen(
                      roomId: roomId,
                      roomModel: room,
                    )));
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 18,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Add new show',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
