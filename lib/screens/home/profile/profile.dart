// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:decimal/bloc/authentication/authentication_bloc.dart';
import 'package:decimal/bloc/profile/profile_bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/home/profile/widgets/profile_contacts.dart';
import 'package:decimal/screens/home/profile/widgets/profile_description.dart';
import 'package:decimal/screens/home/profile/widgets/profile_pics.dart';
import 'package:decimal/screens/home/profile/widgets/profile_publications.dart';
import 'package:decimal/screens/home/profile/widgets/profile_stories.dart';
import 'package:decimal/screens/home/profile/widgets/profile_user_contacts.dart';
import 'package:decimal/screens/home/profile/widgets/profile_user_description.dart';
import 'package:decimal/screens/home/profile/widgets/profile_user_pics.dart';
import 'package:decimal/screens/home/profile/widgets/profile_user_publications.dart';
import 'package:decimal/screens/home/profile/widgets/profile_user_stories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.user_uuid});

  final String user_uuid;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  initState() {
    super.initState();
    if (widget.user_uuid != supabaseUser!.id) {
      BlocProvider.of<ProfileBloc>(context).add(FetchProfileUserContent(widget.user_uuid));
    } else {
      BlocProvider.of<ProfileBloc>(context).add(FetchProfileContent(supabaseUser!.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.user_uuid != supabaseUser!.id
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  color: AppColors.primaryBackground,
                  child: const Column(
                    children: [
                      ProfileUserDescription(),
                      ProfileUserStories(),
                      ProfileUserPics(),
                      ProfileUserContacts(),
                      ProfileUserPublications(),
                    ],
                  ),
                ),
              ),
            ),
          )
        : SingleChildScrollView(
            child: Container(
              color: AppColors.primaryBackground,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(SignOut());
                      Navigator.of(context).pushNamed('/signin');
                    },
                    child: const Text('Sign Out'),
                  ),
                  const ProfileDescription(),
                  const ProfileStories(),
                  const ProfilePics(),
                  const ProfileContacts(),
                  const ProfilePublications(),
                ],
              ),
            ),
          );
  }
}
