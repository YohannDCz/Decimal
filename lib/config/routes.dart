import 'package:decimal/screens/home.dart';
import 'package:decimal/screens/signin_.dart';
import 'package:decimal/screens/signin_email.dart';
import 'package:decimal/screens/signup_email.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> appRoutes = {
  "/home": (context) => const Home(),
  "/signin": (context) => const SignIn(),
  "/signin_email": (context) => const SignInEmail(),
  "/signup_email": (context) => const SignUpEmail(),
};
