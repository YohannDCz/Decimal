import 'package:decimal/bloc/feed/feed_bloc.dart';
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

class _StoriesState extends State<Stories> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
    super.build(context);
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
        return Skeletonizer(
          enabled: publications.isEmpty,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 48.0, bottom: 4.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.625368731563422,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    shrinkWrap: true,
                    itemCount: state is FetchLoading ? 6 : 18,
                    itemBuilder: (context, index) {
                      if (publications.isNotEmpty && index < publications.length) {
                        return Hero(
                            tag: 'MyHero${publicationItems[index].id}',
                            child: Material(
                                child: InkWell(
                              onTap: () => Navigator.of(context).pushNamed('/story_widget', arguments: {'publication': publications[index], 'publicationItem': publicationItems[index], 'user': users[index]}),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: VideoPlayer(
                                    VideoPlayerController.networkUrl(Uri.parse(publicationItems[index].url ?? "https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/stories/placeholder.mp4?t=2024-03-19T14%3A15%3A20.129Z"))..initialize(),
                                  ),
                                ),
                              ),
                            )));
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
        );
      },
    );
  }
}
