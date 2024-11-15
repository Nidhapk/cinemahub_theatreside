import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/container_one.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/flilter_dropdown/flilter_dropdown.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/overall_report/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/overall_report/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/overall_report/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/sales_report/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/sales_report/bloc/bloc_states.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/sales_report/bloc/blocbloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_textstyles.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/sizedbox_one.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(FetchAllMoviesEvent());
    context
        .read<OverallReportBloc>()
        .add(const FetchOverallReportEvent('All Movies'));

    return DashBoardScreen();
  }
}

dashBoardScreen() {
  String selectedOption = 'All Movies';
  return Container(
    color: const Color.fromARGB(255, 15, 15, 20),
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'OverView',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Show : ',
              style: TextStyle(color: Colors.grey),
            ),
            salesReportFilter(selectedOption),
          ],
        ),
        BlocBuilder<OverallReportBloc, OverAllReportStates>(
          builder: (context, state) {
            // if (state is OverAllReportinitial) {
            //   return Row(
            //     children: [
            //       SizedBox(
            //         child: CircularProgressIndicator(),
            //       ),
            //       SizedBox(
            //         child: CircularProgressIndicator(),
            //       )
            //     ],
            //   );
            if (state is OverAllReportLoadedState) {
              log('staeteee');
              final report = state.details;
              return Row(
                children: [
                  containerOne(
                      title: 'Tickets Sold',
                      value: report['ticketCount'].toString()),
                  const SizedBox(
                    width: 20,
                  ),
                  containerOne(
                      title: 'Revenue', value: report['totalAmount'].toString())
                ],
              );
            } else {
              return const Text('Something went wrong');
            }
          },
        ),
        const SizedboxOne(),
        BlocBuilder<SalesReportBloc, SalesReportStates>(
          builder: (context, state) {
            if (state is SalesReportLoaded) {
              final salesReport = state.salesMap;
              log('sales: $salesReport');
              return Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Container(
                  padding: const EdgeInsets.only(top: 30, left: 16, right: 20),
                  //  height: 250,
                  //width: 180,
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 25, 25, 30).withOpacity(0.65),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, _) {
                                switch (value.toInt()) {
                                  case 1:
                                    return const Text('Jan',
                                        style: AppTextStyles.monthTextStyle);
                                  case 2:
                                    return const Text('Feb',
                                        style: AppTextStyles.monthTextStyle);
                                  case 3:
                                    return const Text('Mar',
                                        style: AppTextStyles.monthTextStyle);
                                  case 4:
                                    return const Text('Apr',
                                        style: AppTextStyles.monthTextStyle);
                                  case 5:
                                    return const Text('May',
                                        style: AppTextStyles.monthTextStyle);
                                  case 6:
                                    return const Text('Jun',
                                        style: AppTextStyles.monthTextStyle);
                                  case 7:
                                    return const Text('Jul',
                                        style: AppTextStyles.monthTextStyle);
                                  case 8:
                                    return const Text('Aug',
                                        style: AppTextStyles.monthTextStyle);
                                  case 9:
                                    return const Text('Sep',
                                        style: AppTextStyles.monthTextStyle);
                                  case 10:
                                    return const Text('Oct',
                                        style: AppTextStyles.monthTextStyle);
                                  case 11:
                                    return const Text('Nov',
                                        style: AppTextStyles.monthTextStyle);
                                  case 12:
                                    return const Text('Dec',
                                        style: AppTextStyles.monthTextStyle);
                                  default:
                                    return const Text('');
                                }
                              },
                              interval: 1,
                              reservedSize: 40,
                            ),
                          ),
                          rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                // Format the values for Y-axis
                                if (value == 0) {
                                  return const Text('0',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else if (value == 1000) {
                                  return const Text('1k',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else if (value == 2000) {
                                  return const Text('2k',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else if (value == 3000) {
                                  return const Text('3k',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else if (value == 4000) {
                                  return const Text('4k',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else if (value == 5000) {
                                  return const Text('5k',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else if (value == 6000) {
                                  return const Text('6k',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else if (value == 7000) {
                                  return const Text('7k',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else if (value == 8000) {
                                  return const Text('8k',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else if (value == 9000) {
                                  return const Text('9k',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else if (value == 10000) {
                                  return const Text('10k',
                                      style: TextStyle(
                                          fontSize: 8, color: Colors.white));
                                } else {
                                  return const Text('');
                                }
                              },
                              interval:
                                  50, // Adjust the interval based on your price range
                            ),
                          ),
                        ),
                        lineBarsData: [
                          LineChartBarData(
                            spots: salesReport,
                            isCurved: true,
                            gradient: const LinearGradient(colors: [
                              Colors.indigo,
                              Color.fromARGB(255, 171, 181, 238)
                            ]),
                            barWidth: 1,
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true, drawHorizontalLine: false,
                          verticalInterval:
                              1, // Draws a vertical line for each month
                          horizontalInterval:
                              1000, // Adjust based on price range
                          getDrawingVerticalLine: (value) => FlLine(
                            color: Colors.grey.withOpacity(0.3),
                            strokeWidth: 1,
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                          border: Border.all(color: Colors.grey),
                        ),
                        minX: 0,
                        maxX:
                            13, // Max value for 12 months (0 - Jan to 11 - Dec)
                        minY: 0,
                        maxY: 10000, // Adjust this based on your price range
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is SalesReportLoadedError) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        )
      ],
    ),
  );
}
