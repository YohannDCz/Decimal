// ignore_for_file: non_constant_identifier_names

import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/screens/auth/profile_content.dart';
import 'package:decimal/screens/auth/signin_.dart';
import 'package:decimal/screens/auth/signin_email.dart';
import 'package:decimal/screens/auth/signup_email.dart';
import 'package:decimal/screens/home/home.dart';
import 'package:decimal/screens/home/profile/profile.dart';
import 'package:decimal/screens/home/widgets/cover_pic_widget.dart';
import 'package:decimal/screens/home/widgets/pic_widget.dart';
import 'package:decimal/screens/home/widgets/profile_pics_widget.dart';
import 'package:decimal/screens/home/widgets/story_widget.dart';
import 'package:decimal/screens/publication.dart';
import 'package:decimal/screens/publication_story.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> appRoutes = {
  "/home": (context) => const Home(),
  "/signin": (context) => const SignIn(),
  "/signin_email": (context) => const SignInEmail(),
  "/signup_email": (context) => const SignUpEmail(),
  "/profile_content": (context) => const ProfileContent(),
  "/publication": (context) => const Publication(),
  "/publication_story": (context) => const PublicationStory(),
};

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/profile':
      final userUuid = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => Profile(user_uuid: userUuid));

    case '/profile_pic_widget':
      final user_uuid = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => ProfilePicWidget(user_uuid: user_uuid));

    case '/cover_pic_widget':
      final user_uuid = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => CoverPicWidget(user_uuid: user_uuid));

    case '/story_widget':
      final args = settings.arguments as Map;
      final publication = args["publication"] as PublicationModel;
      final publicationItem = args["publicationItem"] as PublicationItemModel;
      final user = args["user"] as CustomUser;
      return MaterialPageRoute(builder: (context) => StoryWidget(publication: publication, publicationItem: publicationItem, user: user));

    case '/pic_widget':
      final args = settings.arguments as Map;
      final publication = args["publication"] as PublicationModel;
      final publicationItem = args["publicationItem"] as PublicationItemModel;
      final user = args["user"] as CustomUser;
      return MaterialPageRoute(builder: (context) => PicWidget(publication: publication, publicationItem: publicationItem, user: user));

    default:
      return MaterialPageRoute(builder: (context) => const SignIn());
  }
}
