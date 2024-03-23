import 'package:decimal/config/app_providers.dart' as bloc;
import 'package:decimal/config/routes.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/auth/signin_.dart';
import 'package:flutter/material.dart';

class DecimalApp extends StatelessWidget {
  const DecimalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return bloc.Bloc(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        routes: appRoutes,
        onGenerateRoute: generateRoute,
        home: const SignIn(),
      ),
    );
  }
}