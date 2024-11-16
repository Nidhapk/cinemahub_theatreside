import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/validation_methods.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/change_password/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/change_password/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/profile/change_password/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_snackbox.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_textform.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Scaffold(
      body: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is PasswordChangedState) {
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                text: 'Password successfully changed',
                icon: Icons.check_circle,
                iconColor: green,
                borderColor: green,
                backgroundColor: black));
            Navigator.of(context).pop();
          } else if (state is PasswordChangedErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(customSnackBar(
                text: state.error,
                icon: Icons.check_circle,
                iconColor: red,
                borderColor: red,
                backgroundColor: black));
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is PasswordChangingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                // CustomTextForm(
                //     controller: oldPasswordController, labelText: 'Current password'),
                CustomTextForm(
                    controller: newPasswordController,
                    labelText: 'New password',
                    validator: (value) => passwordValidator(value)),
                CustomTextForm(
                  controller: confirmPasswordController,
                  labelText: 'Confirm password',
                  validator: (value) => confirmPassValidator(
                      value, newPasswordController.text.trim()),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor, foregroundColor: white),
                      onPressed: () {
                        context.read<ChangePasswordBloc>().add(
                            PasswordChangedEvent(
                                newPasswordController.text.trim()));
                      },
                      child: const Text('Change password')),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
