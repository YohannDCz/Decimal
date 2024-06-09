import 'dart:async';

import 'package:decimal/bloc/authentication/authentication_bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config/theme.dart';
import 'widgets/auth_title.dart';
import 'widgets/email_input.dart';
import 'widgets/password_input.dart';

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({super.key});

  @override
  State<SignUpEmail> createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  StreamSubscription<AuthState>? _authSubscription;

  @override
  initState() {
    super.initState();
    _authSubscription = supabaseAuth.onAuthStateChange.listen((auth) {
      if (auth.session != null && ModalRoute.of(context)?.settings.name != '/home') {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    });
  }

  @override
  dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bodySmall = Theme.of(context).primaryTextTheme.bodySmall;

    return Scaffold(
      body: _form(context, bodySmall),
    );
  }

  Container _form(BuildContext context, TextStyle? bodySmall) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.gradient),
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              if (state.userExist!) {
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
              } else {
                Navigator.of(context).pushNamedAndRemoveUntil('/profile_content', (route) => false);
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const AuthTitle(label: "Sign up with email"),
              height16,
              EmailInput(hint: "Enter email address", controller: emailController),
              height12,
              PasswordInput(hint: "Enter password", controller: passwordController),
              height12,
              PasswordInput(hint: "Confirm password", controller: confirmPasswordController),
              height24,
              SizedBox(
                width: 280.0,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context).add(SignUpWithEmail(user: AppUser(email: emailController.text, password: passwordController.text)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(99.0),
                    ),
                  ),
                  child: Text("Sign In", style: TextStyle(color: AppColors.white)),
                ),
              ),
              height32,
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
                  },
                  child: Text("Sign in with social network", style: bodySmall!.copyWith(color: Colors.white, decoration: TextDecoration.underline))),
            ],
          ),
        ));
  }
}
