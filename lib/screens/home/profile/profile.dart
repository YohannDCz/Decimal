import 'package:decimal/bloc/authentication/authentication_bloc.dart';
import 'package:decimal/bloc/bloc/profile_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/home/profile/widgets/profile_contacts.dart';
import 'package:decimal/screens/home/profile/widgets/profile_description.dart';
import 'package:decimal/screens/home/profile/widgets/profile_pics.dart';
import 'package:decimal/screens/home/profile/widgets/profile_publications.dart';
import 'package:decimal/screens/home/profile/widgets/profile_stories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  @override
  initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(FetchProfileContent());
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.primaryBackground,
        child:  Column(
          children: [
            ElevatedButton(
              onPressed: () {
               BlocProvider.of<AuthenticationBloc>(context).add(SignOut());
               Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
              },
              child: const Text('Sign Out'),
            ),
            ProfileDescription(),
            ProfileStories(),
            ProfilePics(),
            ProfileContacts(),
            ProfilePublications(),
          ],
        ),
      ),
    );
  }
}
