// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:decimal/bloc/profile/profile_bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePics extends StatefulWidget {
  const ProfilePics(this.user_uuid, {super.key});

  final String user_uuid;

  @override
  State<ProfilePics> createState() => _ProfilePicsState();
}

class _ProfilePicsState extends State<ProfilePics> {
  late List<PublicationModel> publications;
  late List<PublicationItemModel> pics;
  late CustomUser user;

  @override
  initState() {
    super.initState();
    user = const CustomUser(id: "");
    publications = [];
    pics = [];
  }

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (widget.user_uuid != supabaseUser!.id) {
          if (state is FetchProfileUserSuccess) {
            setState(
              () {
                user = state.fetchDescriptionSuccess;
                publications = state.fetchPicsSuccess['publications'];
                pics = state.fetchPicsSuccess['pics'];
              },
            );
          }
        } else {
          if (state is FetchProfileSuccess) {
            setState(
              () {
                user = state.fetchDescriptionSuccess;
                publications = state.fetchPicsSuccess['publications'];
                pics = state.fetchPicsSuccess['pics'];
              },
            );
          }
        }
      },
      builder: (context, state) {
        return Padding(
          padding: mediaQuery > 1000 ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 300.0) : const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Skeletonizer(
            enabled: pics.isEmpty,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('Pics', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0)),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                      ),
                      shrinkWrap: true,
                      itemCount: pics.isNotEmpty ? max(pics.length + 1, 1) : 6,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              ColorFiltered(
                                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                                child: Image.asset(
                                  'assets/images/placeholder.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.add_circle,
                                  color: AppColors.white,
                                  size: 32.0,
                                ),
                              ),
                            ],
                          );
                        }
                        if (index < pics.length + 1) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/pic_widget', arguments: {'publication': publications[index - 1], 'publicationItem': pics[index - 1], 'user': user});
                            },
                            child: Image.network(pics[index - 1].url ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z', fit: BoxFit.cover),
                          );
                        } else {
                          return Image.asset('assets/images/white_background.png', fit: BoxFit.cover); // Image placeholder
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
