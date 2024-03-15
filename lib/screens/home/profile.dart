import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/home/feed.dart';
import 'package:decimal/screens/home/widgets/contacts.dart';
import 'package:decimal/screens/home/widgets/profile_description.dart';
import 'package:decimal/screens/home/widgets/profile_pics.dart';
import 'package:decimal/screens/home/widgets/publications.dart';
import 'package:decimal/screens/home/widgets/reactions.dart';
import 'package:decimal/screens/home/widgets/stories_profile.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String type = 'posts';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.primaryBackground,
        child: Column(
          children: [
            const ProfileDescription(),
            const StoriesProfile(),
            const ProfilePics(),
            const Contacts(),
            Publications(type: type),
          ],
        ),
      ),
    );
  }
}