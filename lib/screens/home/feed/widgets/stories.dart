import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:video_player/video_player.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  late List<PublicationModel> publications;
  late List<PublicationItemModel> publicationItems;
  late List<CustomUser> users;

  @override
  initState() {
    super.initState();
    publications = [];
    publicationItems = [];
    users = [];
    BlocProvider.of<FeedBloc>(context).add(FetchStories());
  }

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width;

    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FetchStoriesSuccess) {
          setState(() {
            publications = state.publications;
            publicationItems = state.publicationItem;
            users = state.users;
          });
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<FeedBloc>(context).add(FetchStories());
          },
          child: Skeletonizer(
            enabled: state is FetchLoading,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is FetchStoriesLoading) LinearProgressIndicator(color: AppColors.primary, minHeight: 1),
                  Padding(
                    padding: mediaQuery > 1000 ? const EdgeInsets.only(top: 4.0, left: 300.0, right: 300.0) : const EdgeInsets.all(4.0),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.625368731563422,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      shrinkWrap: true,
                      itemCount: state is FetchLoading ? 6 : publicationItems.length,
                      itemBuilder: (context, index) {
                        if (publicationItems.isNotEmpty && index < publicationItems.length) {
                          return Hero(
                            tag: 'MyHero${publicationItems[index].id}',
                            child: Material(
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed('/story_widget', arguments: {'publication': publications[index], 'publicationItem': publicationItems[index], 'user': users[index]}),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: VideoPlayer(
                                      VideoPlayerController.networkUrl(Uri.parse(publicationItems[index].url ?? "https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/stories/placeholder.mp4"))..initialize(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.asset("assets/images/placeholder.png", fit: BoxFit.cover),
                              ));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
