import 'package:decimal/config/app_providers.dart' as bloc;
import 'package:decimal/config/routes.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/feed_.dart';
import 'package:decimal/screens/home.dart';
import 'package:flutter/material.dart';

class DecimalApp extends StatelessWidget {
  const DecimalApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return bloc.Bloc(
      child: MaterialApp(
        theme: appTheme,
        routes: appRoutes,
        home: const Home(),
      ),
    );
  }
}
