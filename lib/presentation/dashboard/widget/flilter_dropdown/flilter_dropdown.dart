import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/flilter_dropdown/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/flilter_dropdown/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/flilter_dropdown/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/overall_report/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/overall_report/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/sales_report/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/sales_report/bloc/blocbloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_state.dart';

Widget salesReportFilter(String selectedOption) {
  return BlocBuilder<SalesFilterBloc, SalesFilterState>(
    builder: (context, state) {
      if (state is SalesReportDropdownSelected) {
        selectedOption = state.selectedOption;
      }
      return SizedBox(
        // height: 20,
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            List<String> movieNames = ['All Movies'];
            if (state is MoviesLoaded) {
              movieNames.addAll(
                  state.movies.map((movie) => movie.movieName).toList());
            }
            return DropdownButton<String>(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.zero,
                underline: const SizedBox.shrink(),
                icon: const Icon(Icons.arrow_drop_down,
                    color: Colors.grey, size: 19),
                value: selectedOption,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    log(newValue);
                    context.read<SalesFilterBloc>().add(
                          ChangeDropdownSelectionEvent(newValue),
                        );
                    context
                        .read<SalesReportBloc>()
                        .add(FetchsalesReportEvent(newValue));
                    context
                        .read<OverallReportBloc>()
                        .add(FetchOverallReportEvent(newValue));
                  }
                },
                selectedItemBuilder: (BuildContext context) {
                  return <String>[...movieNames].map(
                    (String value) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 16.0, right: 8),
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ).toList();
                },
                items: [
                  ...movieNames.map((movieName) {
                    return DropdownMenuItem(
                      value: movieName,
                      child: Text(movieName),
                    );
                  })
                ]);
          },
        ),
      );
    },
  );
}
