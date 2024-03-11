import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/theme.dart';
import '../widgets/divider_sign_in.dart';
import '../widgets/sign_in_button.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var bodySmall = Theme.of(context).primaryTextTheme.bodySmall;

    return Scaffold(
      body: _signInForm(context, bodySmall),
    );
  }

  Container _signInForm(BuildContext context, TextStyle? bodySmall) {
    return Container(
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
          SignInButton(icon: FontAwesomeIcons.apple, label: "Sign in with Apple", onPressed: () {}),
          SignInButton(icon: FontAwesomeIcons.google, label: "Sign in with Google", onPressed: () {}),
          SignInButton(icon: FontAwesomeIcons.facebookF, label: "Sign in with Facebook", onPressed: () {}, padding: 6.0),
          const DividerSignIn(),
          SignInButton(
              icon: Icons.email,
              label: "Sign up with email",
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/signup', (route) => false);
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
    );
  }
}
