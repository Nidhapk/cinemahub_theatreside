import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebooking_theatreside/data/validation_methods.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signin/bloc/bloc_bloc.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signin/bloc/bloc_event.dart';
import 'package:onlinebooking_theatreside/presentation/screens/signin/bloc/bloc_state.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_colors.dart';
import 'package:onlinebooking_theatreside/presentation/theme/app_textstyles.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_divider.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_snackbox.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/custom_textform.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/customforgetpass.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/google_button.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/rowone.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/sizedbox_one.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/userauth/custom_elevatedbutton.dart';
import 'package:onlinebooking_theatreside/presentation/widgets/userauth/obscure_button.dart';

class SiginScreen extends StatelessWidget {
  const SiginScreen({super.key});
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: BlocConsumer<SignInBloc, SigInState>(
        listener: (context, state) {
          if (state is SigInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  text: 'Successfully loged in',
                  icon: Icons.check_circle_outline,
                  iconColor: green,
                  borderColor: green,
                  backgroundColor: paleGreen),
            );
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/splash', (context) => false);
          } else if (state is SigInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                  text: state.message,
                  icon: Icons.error_outline,
                  iconColor: red,
                  borderColor: red,
                  backgroundColor: paleRed),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(height: 100),
                const Center(
                  child: Text(
                    'Sign In',
                    style: AppTextStyles.mainHeadingStyle,
                  ),
                ),
                const SizedboxOne(),
                CustomTextForm(
                  controller: emailController,
                  labelText: 'email',
                  validator: (value) => emailValidator(value),
                ),
                const SizedboxOne(),
                CustomTextForm(
                  controller: passwordController,
                  labelText: 'password',
                  obscureText: state.isObscure,
                  suffixIcon: CustomObscureButton(
                    isObscure: state.isObscure,
                    onPressed: () {
                      context.read<SignInBloc>().add(
                            ToggleObscureText(),
                          );
                    },
                  ),
                  validator: passwordValidator,
                ),
                CustomForgetPassTextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/forgetPass');
                  },
                ),
                const SizedBox(
                  height: 33,
                ),
                CustomAccesButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<SignInBloc>().add(
                            SignInRequested(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            ),
                          );
                    }
                  },text: 'Sign in',
                ),
                const SizedboxOne(),
                const CustomDivider(),
                const SizedboxOne(),
                CustomGoogleButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(
                          GoogleSiginEvent(),
                        );
                  },
                ),
                const SizedboxOne(),
                RowOne(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/signUp', (context) => false);
                    },
                    text: 'Sign up',
                    textTwo: 'Don\'t have an account ?  ')
              ],
            ),
          );
        },
      ),
    );
  }
}
