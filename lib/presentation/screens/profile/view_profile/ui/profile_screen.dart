import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebooking_theatreside/data/models/theatre_model/thatre_model.dart';
import 'package:onlinebooking_theatreside/data/repository/user_auth_repository.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/privacy_policy/ui/privacy_policy.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/view_profile/edit_location/ui/edit_map.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_textform.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/profile/custom_container.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/profile/custom_ontap.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/profile/custom_profile.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/profile/image_container.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/profile/item_tile.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/profile/onTap_tile.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/profile/other_images.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  List<String> images = [];
  String pickedImage = '';
  final ImagePicker picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    TheatreModel? theatre;

    context.read<TheatreBloc>().add(
          const FetchTheatreDetails(),
        );
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    return Scaffold(
      body: BlocBuilder<TheatreBloc, TheatreState>(
        builder: (context, state) {
          if (state is MultipleImageselectedState) {
            // images = state.images;
          } else if (state is EditeAccountSuccessState) {
            Navigator.of(context).pop();
            context.read<TheatreBloc>().add(const FetchTheatreDetails());
          } else if (state is EditProfileImageSuccessState) {
            context.read<TheatreBloc>().add(const FetchTheatreDetails());
          }
          if (state is TheatreLoaded) {
            theatre = state.theatreData;
            images = theatre!.images;
            pickedImage = theatre!.profileImage;
            nameController.text = theatre!.name;
            phoneController.text = theatre!.name;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customProfileContainer(
                  onTap: () async {
                    final img = await _pickImage(context);
                    context.read<TheatreBloc>().add(EditProfileEvent(img));
                  },
                  backgroundImage: theatre!.profileImage.isEmpty
                      ? const AssetImage('assets/profile.jpg')
                      : NetworkImage(theatre!.profileImage),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return customContainer(
                            title: 'Account',
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              CustomTextForm(
                                                controller: nameController,
                                                labelText: 'Name of Buisiness',
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Name cant be empty';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                              CustomTextForm(
                                                controller: phoneController,
                                                labelText: 'Phone number',
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Name cant be empty';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  context
                                                      .read<TheatreBloc>()
                                                      .add(EditAccountEvent(
                                                          name: nameController
                                                              .text
                                                              .trim()));
                                                },
                                                child: const Text('Save'),
                                              ),
                                            ],
                                          ),
                                          state is EditingAccountState
                                              ? const CircularProgressIndicator()
                                              : const SizedBox.shrink()
                                        ],
                                      ),
                                    );
                                  });
                            },
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              String title;
                              String subtitle;
                              IconData icon;
                              Color iconColor;
                              switch (index) {
                                case 0:
                                  title = 'Name';
                                  subtitle = theatre!.name;
                                  icon = Icons.person_outline_rounded;
                                  iconColor =
                                      const Color.fromARGB(255, 85, 49, 105);
                                  break;
                                case 1:
                                  title = 'Email';
                                  subtitle = theatre!.emailId;
                                  icon = Icons.email_outlined;
                                  iconColor = Colors.blue;
                                  break;
                                default:
                                  title = 'Phone';
                                  subtitle = theatre!.name;
                                  icon = Icons.phone_outlined;
                                  iconColor = green;
                              }
                              return itemTile(
                                  icon: icon,
                                  iconColor: iconColor,
                                  title: title,
                                  subtitle: subtitle);
                            },
                          );
                        case 1:
                          return customContainer(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditLocationScreen(
                                      latlng: theatre!.latLng)));
                            },
                            title: 'Address',
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              String title;
                              String subtitle;
                              IconData icon;
                              Color iconColor;
                              switch (index) {
                                case 0:
                                  title = 'Location';
                                  subtitle = theatre!.address;
                                  icon = Icons.location_on_outlined;
                                  iconColor = Colors.indigo;
                                  break;
                                default:
                                  title = 'Phone';
                                  subtitle = 'Location';
                                  icon = Icons.phone_outlined;
                                  iconColor = Colors.indigo;
                              }
                              return itemTile(
                                  title: title,
                                  icon: icon,
                                  subtitle: subtitle,
                                  iconColor: iconColor);
                            },
                          );
                        case 2:
                          return customOnTapContainer(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              void Function()? onTap;
                              String title;
                              IconData icon;
                              Color iconColor;
                              switch (index) {
                                case 0:
                                  title = 'About Us';
                                  icon = Icons.info;
                                  iconColor = Colors.grey;
                                  break;

                                default:
                                  onTap = () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PrivacyPolicyScreen()));
                                  title = 'Privacy policy';
                                  icon = Icons.lock;
                                  iconColor =
                                      const Color.fromARGB(255, 61, 86, 63);
                              }
                              return onTapTile(
                                  onTap: onTap,
                                  title: title,
                                  icon: icon,
                                  iconColor: iconColor);
                            },
                          );
                        case 3:
                          return customOnTapContainer(
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              String title;
                              IconData icon;
                              Color iconColor;
                              void Function()? onTap;
                              switch (index) {
                                case 0:
                                  title = 'Delete Account';
                                  icon = Icons.block_flipped;
                                  iconColor =
                                      const Color.fromARGB(255, 114, 112, 111);
                                  break;

                                default:
                                  onTap = () async {
                                    await UserAuthRepository().signOut().then(
                                          (value) => Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  '/splash',
                                                  (context) => false),
                                        );
                                  };
                                  title = 'logout';
                                  icon = Icons.output_rounded;
                                  iconColor = Colors.grey;
                              }
                              return onTapTile(
                                  onTap: onTap,
                                  title: title,
                                  icon: icon,
                                  iconColor: iconColor);
                            },
                          );
                        default:
                          return otherImagesContainer(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return ListView(
                                    children: [
                                      BlocBuilder<TheatreBloc, TheatreState>(
                                        builder: (context, state) {
                                          if (state
                                              is MultipleImageselectedState) {
                                            log('staeeeeee');
                                            images.addAll(state.images);
                                          }
                                          return SizedBox(
                                            height: 400,
                                            child: GridView.builder(
                                              itemCount: images.length + 1,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3),
                                              itemBuilder: (context, index) {
                                                if (index == images.length) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        context
                                                            .read<TheatreBloc>()
                                                            .add(
                                                              const EditMultipleImagesEvent(),
                                                            );
                                                      },
                                                      child: Container(
                                                        height: 200,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              width: 1,
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        child: const Icon(
                                                            Icons.add_a_photo),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: images[index]
                                                                .startsWith(
                                                                    'http')
                                                            ? NetworkImage(
                                                                images[index],
                                                              )
                                                            : FileImage(
                                                                File(
                                                                  images[index],
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<TheatreBloc>()
                                                .add(SaveImagesEvent(images));
                                          },
                                          child: const Text('save'))
                                    ],
                                  );
                                },
                              );
                            },
                            itemCount: theatre!.images.length,
                            itemBuilder: (context, index) {
                              return imageContainer(
                                url: theatre!.images[index],
                              );
                            },
                          );
                      }
                    },
                  ),
                ),
              ],
            );
          } else if (state is TheatreError) {
            log('error : ${state.message}');
            return Center(
              child: Text(state.message),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<String> _pickImage(BuildContext context) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Handle the selected image (e.g., update state, upload the image, etc.)
      log('Selected image path: ${image.path}');
      return image.path;
    }
    return '';
  }
}
