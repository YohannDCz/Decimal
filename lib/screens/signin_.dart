import 'package:decimal/bloc/authentication/authentication_bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/service/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../config/theme.dart';
import '../widgets/divider_sign_in.dart';
import '../widgets/sign_in_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key, this.authService});

  final AuthenticationService? authService;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  @override
  initState() {
    super.initState();
    supabaseAuth.onAuthStateChange.listen((auth) {
      if (auth.session != null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    });
  }

  @override
  dispose() {
    super.dispose();
  }

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
            SignInButton(
                icon: Icons.email,
                label: "Sign in with email",
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/signin_email', (route) => false);
                }),
            SignInButton(
                icon: FontAwesomeIcons.twitter,
                label: "Sign in with Twitter",
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(TwitterLogin());
                }),
            SignInButton(
                icon: FontAwesomeIcons.google,
                label: "Sign in with Google",
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(GoogleLogin());
                }),
            SignInButton(
                icon: FontAwesomeIcons.facebookF,
                label: "Sign in with Facebook",
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(FacebookLogin());
                },
                padding: 6.0),
            const DividerSignIn(),
            SignInButton(
                icon: Icons.email,
                label: "Sign up with email",
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil('/signup_email', (route) => false);
                }),
            height16,
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
              },
              child: Text("Continue as guest", style: bodySmall!.copyWith(color: Colors.white, decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ),
    );
  }
}
