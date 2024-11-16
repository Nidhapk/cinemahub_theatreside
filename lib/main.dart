import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/repository/movie_repository.dart';
import 'package:onlinebooking_theatreside/data/repository/rooms_repository.dart';
import 'package:onlinebooking_theatreside/firebase_options.dart';
import 'package:onlinebooking_theatreside/presentation/bookings/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/flilter_dropdown/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/overall_report/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/dashboard/widget/sales_report/bloc/blocbloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Drawer/bloc/drawer_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/room_home/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/edit_seat/ui/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/add_show/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/edit_show/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/shows/view_shows/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Rooms/view_room/view_seats/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/forgetpass/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Drawer/home_screen.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_location/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_profile/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/change_password/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signin/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signin/singn_in.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signup/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signup/signup_screen.dart';
import 'package:onlinebooking_theatreside/presentation/screens/splash/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/splash/splash_screen.dart';
import 'package:onlinebooking_theatreside/presentation/theme/dark_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light),
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SplashScreenbloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(
          create: (context) => ForgetPassBloc(),
        ),
        BlocProvider(
          create: (context) => LocationBloc(),
        ),
        BlocProvider(
          create: (context) => HomeScreenBloc(),
        ),
        BlocProvider(
          create: (context) => RoomBloc(),
        ),
        BlocProvider(
          create: (context) => SeatBloc(),
        ),
        BlocProvider(
          create: (context) => EditSeatBloc(
            RoomsRepository(),
          ),
        ),
        BlocProvider(
          create: (context) => TheatreBloc(),
        ),
        BlocProvider(
          create: (context) => MovieBloc(
            MovieDatabaserepository(),
          ),
        ),
        BlocProvider(
          create: (context) => ShowBloc(),
        ),
        BlocProvider(
          create: (context) => EditShowBloc(),
        ),
        BlocProvider(
          create: (context) => AddProfileBloc(),
        ),
        BlocProvider(
          create: (context) => SalesReportBloc(),
        ),
        BlocProvider(
          create: (context) => SalesFilterBloc(),
        ),
        BlocProvider(create: (context) => OverallReportBloc()),
        BlocProvider(create: (context) => BookingBloc()),
        BlocProvider(create: (context) => ChangePasswordBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme().blackTheme,
        home: const SplashScreen(),
        routes: {
          '/signUp': (context) => const SignUpScreen(),
          '/splash': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/signIn': (context) => const SiginScreen(),
        },
      ),
    );
  }
}
