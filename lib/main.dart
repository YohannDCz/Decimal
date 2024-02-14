import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/home.dart';
import 'screens/signin.dart';
import 'screens/signin_email.dart';
import 'screens/signup_email.dart';
import 'utils/theme.dart';

void main() async {
  try {
    await dotenv.load();
    await Supabase.initialize(
      url: dotenv.env["API_URL"]!,
      anonKey: dotenv.env["API_KEY"]!,
      debug: true,
    );
  } catch (e) {
    rethrow;
  }
  runApp(const Decimal());
}

class Decimal extends StatelessWidget {
  const Decimal({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const Home(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const Home(),
        "/signin": (context) => const SignIn(),
        "/signin_email": (context) => const SignInEmail(),
        "/signup": (context) => const SignUp(),
        // "/signin_email": (context) => const SignInEmail(),
      },
    );
  }
}
