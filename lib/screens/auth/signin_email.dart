import 'package:decimal/bloc/authentication/authentication_bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/theme.dart';
import 'widgets/auth_title.dart';
import 'widgets/email_input.dart';
import 'widgets/password_input.dart';

class SignInEmail extends StatefulWidget {
  const SignInEmail({super.key});

  @override
  State<SignInEmail> createState() => _SignInEmailState();
}

class _SignInEmailState extends State<SignInEmail> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var bodySmall = Theme.of(context).primaryTextTheme.bodySmall;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.gradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AuthTitle(label: "Sign in with email"),
            height16,
            EmailInput(hint: "Enter email address", controller: emailController),
            height12,
            PasswordInput(hint: "Enter password", controller: passwordController),
            height24,
            _submitButton(context),
            height32,
            _goToNetworksLogin(context, bodySmall),
          ],
        ),
      ),
    );
  }

  InkWell _goToNetworksLogin(BuildContext context, TextStyle? bodySmall) {
    return InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
              },
              child: Text("Sign in with social network", style: bodySmall!.copyWith(color: Colors.white, decoration: TextDecoration.underline)));
  }

  SizedBox _submitButton(BuildContext context) {
    return SizedBox(
            width: 280.0,
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(SignInWithEmail(
                  user: AppUser(email: emailController.text, password: passwordController.text),
                ));
                if (supabaseSession != null) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(99.0),
                ),
              ),
              child: Text("Sign In", style: TextStyle(color: AppColors.white)),
            ),
          );
  }
}
