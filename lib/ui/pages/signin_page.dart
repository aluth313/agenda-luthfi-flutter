import 'package:agenda_luthfi/bloc/user_bloc.dart';
import 'package:agenda_luthfi/data/models/user_model.dart';
import 'package:agenda_luthfi/ui/widgets/custom_button.dart';
import 'package:agenda_luthfi/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_airplane/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/theme.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserInit());
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 30.0),
        child: Text(
          'Sign In with your\nexisting account',
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
        ),
      );
    }

    Widget inputSection() {
      Widget emailInput() {
        return CustomTextFormField(
            controller: emailController,
            title: 'Email Address',
            hintText: 'Your Email');
      }

      Widget passwordInput() {
        return CustomTextFormField(
          controller: passwordController,
          title: 'Password',
          hintText: 'Your Password',
          obsecure: true,
        );
      }

      Widget submitButton() {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              EasyLoading.show(status: 'loading...');
            } else if (state is UserFound) {
              userGlobal = state.user;
              // print(userGlobal);
              // print(userGlobal);
              EasyLoading.showSuccess('Login success!');
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/home', (route) => false);
              });
            } else if (state is UserNotFound) {
              EasyLoading.showError('User not found!');
            }

            return CustomButtom(
              title: 'Sign In',
              onPressed: () async {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  context.read<UserBloc>().add(
                      CheckUser(emailController.text, passwordController.text));
                } else {
                  EasyLoading.showError('Please fill email & password!');
                }
              },
            );
          },
        );

        // return BlocConsumer<AuthCubit, AuthState>(
        //   listener: (context, state) {
        //     // if (state is AuthSuccess) {
        //     //   Navigator.pushNamedAndRemoveUntil(
        //     //       context, '/main', (route) => false);
        //     // } else if (state is AuthFailed) {
        //     //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //     //       backgroundColor: kRedColor, content: Text(state.error)));
        //     // }
        //   },
        //   builder: (context, state) {
        //     // if (state is AuthLoading) {
        //     //   return Center(
        //     //     child: CircularProgressIndicator(),
        //     //   );
        //     // }

        //     return CustomButtom(
        //       title: 'Sign In',
        //       onPressed: () {
        //         // context.read<AuthCubit>().signIn(
        //         //     email: emailController.text,
        //         //     password: passwordController.text);
        //       },
        //     );
        //   },
        // );
      }

      return Container(
        margin: EdgeInsets.only(top: 30.0),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(defaultRadius)),
        child: Column(
          children: [
            emailInput(),
            passwordInput(),
            submitButton(),
          ],
        ),
      );
    }

    Widget tacButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/sign-up');
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50, bottom: 75),
          child: Text(
            'Don\'t have an account? Sign Up',
            style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
                decoration: TextDecoration.underline),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            title(),
            inputSection(),
            tacButton(),
          ],
        ),
      ),
    );
  }
}
