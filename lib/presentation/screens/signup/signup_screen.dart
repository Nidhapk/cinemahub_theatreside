import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/validation_methods.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signup/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signup/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signup/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_textstyles.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_snackbox.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_textform.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rowone.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/sizedbox_one.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/userauth/custom_elevatedbutton.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/userauth/obscure_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    return Scaffold(
      body: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  text: 'User registered successfully',
                  icon: Icons.check_circle_outline,
                  iconColor: green,
                  borderColor: green,
                  backgroundColor: paleGreen),
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/splash', (context) => false);
          } else if (state is SignUpFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  text: state.error,
                  icon: Icons.error_outline,
                  iconColor: red,
                  borderColor: red,
                  backgroundColor: paleRed),
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/splash', (context) => false);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 120,
                ),
                const Center(
                  child: Text(
                    'Sign Up',
                    style: AppTextStyles.mainHeadingStyle,
                  ),
                ),
                const SizedboxOne(),
                CustomTextForm(
                  controller: emailController,
                  labelText: 'email',
                  validator: emailValidator,
                ),
                const SizedboxOne(),
                CustomTextForm(
                  controller: passwordController,
                  labelText: 'password',
                  obscureText: state.isObscure1,
                  suffixIcon: CustomObscureButton(
                    isObscure: state.isObscure1,
                    onPressed: () {
                      context.read<SignUpBloc>().add(
                            const ToggleObscureButton('firstField'),
                          );
                    },
                  ),
                  validator: passwordValidator,
                ),
                const SizedboxOne(),
                CustomTextForm(
                  controller: confirmPasswordController,
                  labelText: 'password',
                  obscureText: state.isObscure2,
                  suffixIcon: CustomObscureButton(
                    isObscure: state.isObscure2,
                    onPressed: () {
                      context.read<SignUpBloc>().add(
                            const ToggleObscureButton('secondField'),
                          );
                    },
                  ),
                  validator: (value) => confirmPassValidator(
                    value,
                    passwordController.text.trim(),
                  ),
                ),
                const SizedBox(height: 35),
                CustomAccesButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<SignUpBloc>().add(
                            SignUpRequestedEvent(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            ),
                          );
                    }
                  },text: 'Sign up',
                ),
                const SizedboxOne(),
                RowOne(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/signIn', (context) => false);
                    },
                    text: 'Sign in',
                    textTwo: 'Already  have an account ?  ')
              ],
            ),
          );
        },
      ),
    );
  }
}
