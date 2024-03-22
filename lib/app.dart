// ignore_for_file: non_constant_identifier_names

import 'package:decimal/config/app_providers.dart' as bloc;
import 'package:decimal/config/routes.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/auth/signin_.dart';
import 'package:decimal/screens/home/home.dart';
import 'package:decimal/screens/home/widgets/pic_widget.dart';
import 'package:decimal/screens/home/widgets/story_widget.dart';
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
        onGenerateRoute: (settings) {
          if (settings.name == '/story') {
            final publication_id = settings.arguments as String;

            return MaterialPageRoute(
              builder: (context) => StoryWidget(publication_id: publication_id),
            );
          } else if (settings.name == '/pic') {
            final publication_id = settings.arguments as String;

            return MaterialPageRoute(
              builder: (context) => PicWidget(publication_id: publication_id),
            );
          }
          return null;
        },
        home: const SignIn(),
      ),
    );
  }
}
