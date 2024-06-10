// ignore_for_file: non_constant_identifier_names

import 'dart:math';

import 'package:decimal/bloc/profile/profile_bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/comment_model.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';

class ProfileStories extends StatefulWidget {
  const ProfileStories(this.user_uuid, {super.key});

  final String user_uuid;

  @override
  State<ProfileStories> createState() => _ProfileStoriesState();
}

class _ProfileStoriesState extends State<ProfileStories> {
  late List<PublicationModel> publications;
  late List<CustomUser> users;
  late List<PublicationItemModel> stories;
  late List<List<CommentModel>> commentsAll;
  late List<List<CustomUser>> commentsUsers;

  @override
  initState() {
    super.initState();
    publications = [];
    users = [];
    stories = [];
    commentsAll = [];
    commentsUsers = [];
  }

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width;

    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (widget.user_uuid != supabaseUser!.id) {
          if (state is FetchProfileUserSuccess) {
            publications = state.fetchStoriesSuccess['publications'];
            users = state.fetchStoriesSuccess['users'];
            stories = state.fetchStoriesSuccess['stories'];
          }
        } else {
          if (state is FetchProfileSuccess) {
            publications = state.fetchStoriesSuccess['publications'];
            users = state.fetchStoriesSuccess['users'];
            stories = state.fetchStoriesSuccess['stories'];
          }
        }
      },
      builder: (context, state) {
        return Padding(
          padding: mediaQuery > 1000 ? const EdgeInsets.symmetric(vertical: 8.0, horizontal: 300.0) : const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.white,
            ),
            height: 180.0,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8.0),
              child: Skeletonizer(
                enabled: state is FetchLoading,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 72.0,
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: AspectRatio(
                                  aspectRatio: 9 / 16,
                                  child: Stack(
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
                                  ),
                                ),
                              ),
                              const Gap(4),
                              Text(
                                "add story",
                                style: Theme.of(context).primaryTextTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: stories.isNotEmpty ? stories.length : min(stories.length, 5),
                      itemBuilder: (BuildContext context, int index) {
                        if (publications.isNotEmpty && users.isNotEmpty && stories.isNotEmpty && index < stories.length) {
                          final PublicationModel publication = publications[index];
                          final CustomUser user = users[index];
                          final PublicationItemModel story = stories[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SizedBox(
                              width: 72.0,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, '/story_widget', arguments: {'publication': publication, 'publicationItem': story, 'user': user});
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: AspectRatio(
                                        aspectRatio: 9 / 16,
                                        child: VideoPlayer(
                                          VideoPlayerController.networkUrl(Uri.parse(story.url ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/stories/1.mp4?t=2023-11-19T07%3A21%3A29.624Z'))..initialize(),
                                        ),
                                      ),
                                    ),
                                    const Gap(4),
                                    Text(
                                      story.title == null
                                          ? '[story_title]'
                                          : story.title!.isEmpty
                                              ? '[story_title]'
                                              : story.title!,
                                      style: Theme.of(context).primaryTextTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SizedBox(
                              width: 72.0,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: AspectRatio(
                                      aspectRatio: 9 / 16,
                                      child: Image.network(
                                        'https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const Gap(4),
                                  Text(
                                    '[story_title]',
                                    style: Theme.of(context).primaryTextTheme.bodySmall,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
