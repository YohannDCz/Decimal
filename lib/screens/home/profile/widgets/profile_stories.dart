import 'package:decimal/bloc/bloc/profile_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/comment_model.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';

class ProfileStories extends StatefulWidget {
  const ProfileStories({
    super.key,
  });

  @override
  State<ProfileStories> createState() => _ProfileStoriesState();
}

class _ProfileStoriesState extends State<ProfileStories> {
  late List<PublicationModel> publications;
  late List<CustomUser> users;
  late List<PublicationItemModel>? stories;
  late List<List<CommentModel>> comments;
  late List<List<CustomUser>> commentsUsers;

  @override
  initState() {
    super.initState();
    publications = [];
    users = [];
    stories = [];
    comments = [];
    commentsUsers = [];
  }

  String _extractPseudo(String pseudo) {
    return pseudo.toLowerCase().replaceAll(' ', '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is FetchProfileSuccess) {
          publications = state.fetchStoriesSuccess['publications'];
          users = state.fetchStoriesSuccess['users'];
          stories = state.fetchStoriesSuccess['stories'];
          comments = state.fetchStoriesSuccess['comments'];
          commentsUsers = state.fetchStoriesSuccess['commentsUsers'];
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.white,
            ),
            height: 160.0,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8.0),
              child: Skeletonizer(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    if (stories != null && index < stories!.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 72.0,
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: VideoPlayer(
                                    VideoPlayerController.networkUrl(Uri.parse(stories![index].url ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/stories/1.mp4?t=2023-11-19T07%3A21%3A29.624Z'))..initialize(),
                                  ),
                                ),
                              ),
                              height4,
                              Text(
                                stories![index].title == null
                                    ? '[story_title]'
                                    : stories![index].title!.isEmpty
                                        ? '[story_title]'
                                        : stories![index].title!,
                                style: Theme.of(context).primaryTextTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
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
                                  aspectRatio: 16 / 9,
                                  child: Image.network(
                                    'https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              height4,
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
              ),
            ),
          ),
        );
      },
    );
  }
}
