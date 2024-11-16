import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/constants/constants.dart';
import 'package:onlinebooking_theatreside/data/repository/user_auth_repository.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/overall_report/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/overall_report/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/sales_report/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/sales_report/bloc/blocbloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Drawer/bloc/drawer_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Drawer/bloc/drawer_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Drawer/bloc/drawer_state.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_alertbox.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/home/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovieBloc>().add(FetchAllMoviesEvent());
    context
        .read<SalesReportBloc>()
        .add(const FetchsalesReportEvent('All Movies'));
    context
        .read<OverallReportBloc>()
        .add(FetchOverallReportEvent('All Movies'));
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: HomeAppBar(
            title: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                builder: (context, state) {
              String title;
              switch (state) {
                case DashboardState():
                  title = 'Dashboard';
                  break;
                case RoomsState():
                  title = 'Rooms';
                  break;
                case BookingsState():
                  title = 'Bookings';
                  break;
                default:
                  title = 'Profile';
              }
              return Text(title);
            }),
          ),
          body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
              return state.page;
            },
          ),
          drawer: Drawer(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  leading: Icon(item.icon),
                  title: Text(item.title),
                  onTap: () {
                    switch (item.title) {
                      case 'Dashborad':
                        context
                            .read<HomeScreenBloc>()
                            .add(NavigateToDashboardEvent());
                        Navigator.of(context).pop();
                        break;
                      case 'Rooms':
                        context
                            .read<HomeScreenBloc>()
                            .add(NavigateToRoomsEvent());
                        Navigator.of(context).pop();
                        break;
                      case 'Bookings':
                        context
                            .read<HomeScreenBloc>()
                            .add(NavigateToBookingsEvent());
                        Navigator.of(context).pop();
                        break;

                      case 'Profile':
                        context
                            .read<HomeScreenBloc>()
                            .add(NavigateToProfileEvent());
                        Navigator.of(context).pop();
                        break;
                      case 'Logout':
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertBox(
                            title: 'Logout',
                            content:
                                'Are you sure you want to logout from this account ?',
                            confirmText: 'Ok',
                            onPressed: () async {
                              await UserAuthRepository().signOut().then(
                                    (value) => Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/splash', (context) => false),
                                  );
                            },
                          ),
                        );
                        break;
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
