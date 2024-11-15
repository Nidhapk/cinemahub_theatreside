import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/validation_methods.dart';
import 'package:onlinebooking_theatreside/presentation/screens/forgetpass/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/forgetpass/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/forgetpass/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_snackbox.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_textform.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/sizedbox_one.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/userauth/custom_elevatedbutton.dart';

class ForgetPassScreen extends StatelessWidget {
  const ForgetPassScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    final emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Password'),
      ),
      body: BlocListener<ForgetPassBloc, ForgetPassState>(
        listener: (context, state) {
          if (state is ForgetPassEmailSendSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  text: 'Verify email has been sent',
                  icon: Icons.check_circle_outlined,
                  iconColor: green,
                  borderColor: green,
                  backgroundColor: Colors.black),
            );
            Navigator.of(context).pop();
          } else if (state is ForgetPassEmailFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  text: state.error,
                  icon: Icons.error_outline_outlined,
                  iconColor: red,
                  borderColor: red,
                  backgroundColor: Colors.black),
            );
          }
        },
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedboxOne(),
              const Text(
                'Enter email associated with your account and\n we \'ll send an email to reset password',
                textAlign: TextAlign.center,
              ),
              const SizedboxOne(),
              CustomTextForm(
                controller: emailController,
                labelText: 'email',
                obscureText: false,
                validator: emailValidator,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomAccesButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<ForgetPassBloc>().add(
                          SendResetPasswordLink(
                            email: emailController.text.trim(),
                          ),
                        );
                  }
                },
                text: 'Send',
              )
            ],
          ),
        ),
      ),
    );
  }
}
