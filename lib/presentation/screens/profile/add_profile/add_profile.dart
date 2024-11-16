import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:onlinebooking_theatreside/data/models/theatre_model/thatre_model.dart';
import 'package:onlinebooking_theatreside/data/validation_methods.dart';
import 'package:onlinebooking_theatreside/presentation/screens/Drawer/home_screen.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_location/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_location/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_location/open_map.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_profile/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_profile/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/add_profile/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_textstyles.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_snackbox.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_textform.dart';

class AddProfileScreen extends StatefulWidget {
  final String address;
  final LatLng? latlng;
  const AddProfileScreen({super.key, required this.address, this.latlng});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  List<String>? selectedImages;
  XFile? selectedImage;
  final GlobalKey<FormState> profileformKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final placeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    log('${widget.latlng}');
    locationController.text = widget.address;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: BlocConsumer<AddProfileBloc, AddProfilestate>(
              listener: (context, state) {
                if (state is AddProfileSuccessState) {
                  ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                      text: state.message,
                      icon: Icons.check_circle,
                      iconColor: green,
                      borderColor: green,
                      backgroundColor: paleGreen));
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (context) => false);
                }
              },
              builder: (context, state) {
                if (state is AddingProfileState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Form(
                  key: profileformKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Start Building Your\nBuisiness Profile',
                          style: AppTextStyles.addProfileTitleStyle),
                      const Text(
                        'Helps you get discovered by costumers \non Search and Maps.',
                        style: AppTextStyles.addProfilesubtitleStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          pickprofileImage();
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              //border: Border.all(color: grey),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: selectedImage != null
                                    ? FileImage(File(selectedImage!.path))
                                    : const AssetImage(
                                        'assets/profile.jpg',
                                      ),
                              )),
                        ),
                      ),
                      CustomTextForm(
                        controller: nameController,
                        labelText: 'Name of Buisiness (*required)',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please provide the buisiness name';
                          } else {
                            return null;
                          }
                        },
                      ),
                      // CustomTextForm(
                      //     controller: placeController,
                      //     labelText: 'Place (*required)'),
                      CustomTextForm(
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please provide the location';
                          } else {
                            return null;
                          }
                        },
                        controller: locationController,
                        labelText: 'Location (*required)',
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<LocationBloc>().add(OpenMapEvent());
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddLocationScreen(),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.location_on,
                            color: Color.fromARGB(255, 40, 40, 43),
                          ),
                        ),
                      ),
                      // const Text(
                      //   'Other Details',
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.w500,
                      //       color: Color.fromARGB(255, 55, 55, 58)),
                      // ),
                      CustomTextForm(
                          validator: (value) {
                            if (!isValidPhoneNumber(value!)) {
                              return 'Enter an valid phone number';
                            } else {
                              return null;
                            }
                          },
                          controller: phoneController,
                          labelText: 'Phone number'),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: pickImages,
                        child: const Text("Pick Images"),
                      ),
                      selectedImages != null
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                              ),
                              itemCount: selectedImages!.length,
                              itemBuilder: (context, index) {
                                return Image.file(
                                  File(selectedImages![index]),
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (profileformKey.currentState!.validate()) {
                              String emailId =
                                  FirebaseAuth.instance.currentUser?.email ??
                                      '';

                              // .then((value) => Navigator.of(context)
                              //     .pushAndRemoveUntil(
                              //         MaterialPageRoute(
                              //             builder: (context) =>
                              //                 const HomeScreen()),

                              context
                                  .read<AddProfileBloc>()
                                  .add(AddProfileOnClickedEvent(TheatreModel(
                                    userId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    emailId: emailId,
                                    name: nameController.text.trim(),
                                    address: locationController.text.trim(),
                                    latLng: widget.latlng!,
                                    phone: phoneController.text.trim(),
                                    profileImage: selectedImage!.path,
                                    images: selectedImages ?? [],
                                  )));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 78, 92, 169),
                          ),
                          child: const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImages() async {
    try {
      // Picking multiple images
      final List<XFile> pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        setState(() {
          // Convert XFile objects to a list of file paths
          selectedImages = pickedFiles.map((file) => file.path).toList();
        });
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> pickprofileImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          selectedImage = pickedFile;
        });
      }
    } catch (_) {
      rethrow;
    }
  }
}
