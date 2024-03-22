// ignore_for_file: non_constant_identifier_names

import 'package:decimal/config/app_providers.dart' as bloc;
import 'package:decimal/config/routes.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/screens/auth/signin_.dart';
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
          if (settings.name == '/story_widget') {
            final publication = (settings.arguments as Map)["publication"] as PublicationModel;
            final publicationItem = (settings.arguments as Map)["publicationItem"] as PublicationItemModel;
            final user = (settings.arguments as Map)["user"] as CustomUser;

            return MaterialPageRoute(
              builder: (context) => StoryWidget(publication: publication, publicationItem: publicationItem, user: user),
            );
          } else if (settings.name == '/pic_widget') {
            final publication = (settings.arguments as Map)["publication"] as PublicationModel;
            final publicationItem = (settings.arguments as Map)["publicationItem"] as PublicationItemModel;
            final user = (settings.arguments as Map)["user"] as CustomUser;

            return MaterialPageRoute(
              builder: (context) => PicWidget(publication: publication, publicationItem: publicationItem, user: user),
            );
          }
          return null;
        },
        home: const SignIn(),
      ),
    );
  }
}
