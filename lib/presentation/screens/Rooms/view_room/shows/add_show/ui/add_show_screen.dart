import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:onlinebooking_theatreside/data/models/movie/movie_model.dart';
import 'package:onlinebooking_theatreside/data/models/rooms/rooms_model.dart';
import 'package:onlinebooking_theatreside/data/models/shows/shows_model.dart';
import 'package:onlinebooking_theatreside/data/models/theatre_model/thatre_model.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_alertbox.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_snackbox.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_textform.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/movies/custom_movie_container.dart';

class AddShowsScreen extends StatelessWidget {
  final String roomId;
  final RoomModel roomModel;
  AddShowsScreen({super.key, required this.roomId, required this.roomModel});
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  final languageController = TextEditingController();
  final movieController = TextEditingController();
  final ticketPriceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  MovieClass? movie;

  bool iconSelected = false;
  bool languageSelected = false;
  List<String> languages = [];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    log('roomoel : ${roomModel.rows}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              languages.clear();
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        title: const Text(
          'ADD SHOWS',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<MovieBloc, MovieState>(
        listener: (context, state) {
          if (state is ShowAddingState) {
            const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ShowAddedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  text: state.message,
                  icon: Icons.check_circle_rounded,
                  iconColor: green,
                  borderColor: green,
                  backgroundColor: black),
            );
            context.read<ShowBloc>().add(
                  FetchAllShows(roomId),
                );
            Navigator.of(context).pop();
          } else if (state is ShowAddedFailureState) {
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                text: state.error,
                icon: Icons.error,
                iconColor: red,
                borderColor: red,
                backgroundColor: black));
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextForm(
                controller: movieController,
                labelText: 'Select movie',
                suffixIcon: IconButton(
                    onPressed: () {
                      context.read<MovieBloc>().add(FetchAllMoviesEvent());
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return BlocConsumer<MovieBloc, MovieState>(
                              listener: (context, state) {
                                if (state is MovieLoading) {
                                  const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is MovieSelectedState) {
                                  movieController.text = state.movie.movieName;
                                  iconSelected = !iconSelected;
                                  languages = state.movie.languages;
                                  Navigator.of(context).pop();
                                }
                              },
                              builder: (context, state) {
                                return Container(
                                  width: width,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 24, 23, 23),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 5,
                                        width: width * 0.1,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: grey),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Movies',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: grey),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        thickness: 0.4,
                                        height: 0,
                                      ),
                                      // const SizedBox(
                                      //   height: 20,
                                      // ),
                                      BlocBuilder<MovieBloc, MovieState>(
                                        builder: (context, state) {
                                          if (state is MovieLoading) {
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          } else if (state is MoviesLoaded) {
                                            final movies = state.movies
                                                .where((movie) =>
                                                    movie.blocked == false)
                                                .toList();
                                            if (movies.isEmpty) {
                                              return const Center(
                                                child:
                                                    Text('No movies available'),
                                              );
                                            } else {
                                              return Expanded(
                                                child: GridView.builder(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16, right: 16),
                                                  itemCount: movies.length,
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          mainAxisSpacing: 10,
                                                          crossAxisSpacing: 20,
                                                          childAspectRatio:
                                                              0.55),
                                                  itemBuilder:
                                                      (context, index) {
                                                    final movie = movies[index];

                                                    return customMovieContainer(
                                                        iconPressed: () {
                                                          context
                                                              .read<MovieBloc>()
                                                              .add(
                                                                  SelectMovieEvent(
                                                                      movie));
                                                        },
                                                        icon: iconSelected
                                                            ? Icons
                                                                .radio_button_checked_outlined
                                                            : Icons
                                                                .radio_button_off,
                                                        image: movie.posterImage
                                                                .isEmpty
                                                            ? const AssetImage(
                                                                'assets/profile.jpg')
                                                            : NetworkImage(movie
                                                                .posterImage),
                                                        movieName:
                                                            movie.movieName,
                                                        onPressed: () {});
                                                  },
                                                ),
                                              );
                                            }
                                          } else if (state is MovieError) {
                                            return Text(state.message);
                                          } else {
                                            return CustomAlertBox(
                                                title: 'Something went wrong',
                                                content:
                                                    'Unable to load movies,Ty again later',
                                                confirmText: 'OK',
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                });
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: grey,
                      size: 20,
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an movie';
                  } else {
                    return null;
                  }
                },
              ),
              CustomTextForm(
                controller: dateController,
                labelText: 'Date',
                readOnly: true,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());

                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: dateController.text.isEmpty
                        ? DateTime.now()
                        : DateTime.parse(dateController.text),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    dateController.text = formattedDate;
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select date';
                  } else {
                    return null;
                  }
                },
              ),
              CustomTextForm(
                controller: timeController,
                labelText: 'Show time',
                readOnly: true,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: timeController.text.isEmpty
                        ? TimeOfDay.now()
                        : TimeOfDay(
                            hour: int.parse(timeController.text.split(":")[0]),
                            minute: int.parse(timeController.text
                                .split(":")[1]
                                .split(" ")[0]),
                          ),
                  );
                  if (pickedTime != null) {
                    timeController.text = pickedTime.format(context);
                  }
                },
                suffixIcon: const Icon(
                  Icons.access_time,
                  color: grey,
                  size: 20,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an movie';
                  } else {
                    return null;
                  }
                },
              ),
              BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieSelectedState) {
                    languages = state.movie.languages;
                    movie = state.movie;
                  }
                  return CustomTextForm(
                    onTap: () {
                      languages.isEmpty
                          ? ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar(
                                  text:
                                      " please select a movie to see the available languages",
                                  icon: Icons.warning_amber_rounded,
                                  iconColor: red,
                                  borderColor: red,
                                  backgroundColor: black))
                          : showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        height: 5,
                                        width: width * 0.1,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: grey),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'Languages',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: grey),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        thickness: 0.4,
                                        height: 0,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: languages.length,
                                        itemBuilder: (context, index) {
                                          final selectedLanguage =
                                              languages[index] ==
                                                  languageController.text;
                                          return ListTile(
                                            onTap: () {
                                              languageController.text =
                                                  languages[index];

                                              Navigator.of(context).pop();
                                            },
                                            title: Text(
                                              languages[index],
                                              style: TextStyle(
                                                  color: selectedLanguage
                                                      ? mainColor
                                                      : grey),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                    },
                    controller: languageController,
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: grey,
                      size: 20,
                    ),
                    labelText: 'Language',
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select an movie';
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
              CustomTextForm(
                controller: ticketPriceController,
                labelText: 'Enter ticket price',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an movie';
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: mainColor, foregroundColor: white),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        log('roomoel : ${roomModel.roomName}');
                        final theatre = await FirebaseFirestore.instance
                            .collection('theatres')
                            .where('userId',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .get();
                        context.read<MovieBloc>().add(AddShowEvent(ShowModel(
                            showId: '',
                            movieName: movieController.text,
                            poster: movie!.posterImage,
                            movie: movie!,
                            theatre:
                                TheatreModel.fromMap(theatre.docs.first.data()),
                            roomId: roomId,
                            room: roomModel,
                            date: DateFormat("yyy-MM-dd")
                                .parse(dateController.text),
                            time: timeController.text.trim(),
                            language: languageController.text.trim(),
                            ticketPrice:
                                double.parse(ticketPriceController.text.trim()),
                            userId: FirebaseAuth.instance.currentUser!.uid)));
                      }
                    },
                    child: const Text('Add Show')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
