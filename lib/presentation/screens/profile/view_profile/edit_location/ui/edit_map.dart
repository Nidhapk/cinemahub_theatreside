import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_location/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_location/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_location/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/ui/profile_screen.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_alertbox.dart';

class EditLocationScreen extends StatefulWidget {
  final LatLng latlng;
  const EditLocationScreen({super.key, required this.latlng});

  @override
  State<EditLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<EditLocationScreen> {
  TileLayer get openStreetMapTileLater => TileLayer(
        urlTemplate: "https://a.tile.openstreetmap.org/{z}/{x}/{y}.png",
        userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      );
  LatLng? selectedLocation;
  List<Marker> markers = [];
  String? address;
  @override
  Widget build(BuildContext context) {
    context.read<LocationBloc>().add(OpenMapEvent());
    return Scaffold(
      body: BlocConsumer<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LocationLoaded) {
            selectedLocation = state.latlng;
            showBottomSheet(
              context,
              state.address,
            );
          }
        },
        builder: (context, state) {
          if (state is MapLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MapLoadedState ||
              state is LocationLoaded ||
              state is LocationLoading) {
            return FlutterMap(
                options: MapOptions(
                    minZoom: 3,
                    maxZoom: 18,
                    initialCenter: (widget.latlng).toString().isEmpty
                        ? LatLng(10.8505, 76.2711)
                        : widget.latlng,
                    initialZoom: 11,
                    interactionOptions:
                        InteractionOptions(flags: InteractiveFlag.all),
                    onTap: (tapPosition, point) {
                      context.read<LocationBloc>().add(
                            LocationSelectedEvent(point),
                          );
                    }),
                children: [
                  openStreetMapTileLater,
                  MarkerLayer(markers: markers)
                ]);
          } else if (state is MapError) {
            return AlertDialog(
              title: Text('Error Loading map'),
              content: Text('Error:${state.errorMessage}'),
            );
          } else {
            return CustomAlertBox(
              title: 'Something went wrong',
              content:
                  'something unexpected had been happened,Please try again later',
              confirmText: 'OK',
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          }
        },
      ),
    );
  }

  void showBottomSheet(BuildContext context, String address) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          buildBottomSheet(address, context, selectedLocation),
    );
  }
}

Widget buildBottomSheet(String address, BuildContext context, LatLng? latlng) {
  return SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Selected Address",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            address,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 78, 92, 169)),
                onPressed: () {
                  context
                      .read<TheatreBloc>()
                      .add(EditLocationEvent(latlng: latlng, address: address));
                  context.read<TheatreBloc>().add(const FetchTheatreDetails());
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
                child: const Text(
                  "Ok",
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Close"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
