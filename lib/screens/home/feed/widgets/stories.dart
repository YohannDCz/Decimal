import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<PublicationModel> publication;
  late List<PublicationItemModel> publicationItem;

  @override
  initState() {
    super.initState();
    publication = [];
    publicationItem = [];
    BlocProvider.of<FeedBloc>(context).add(FetchStories());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FetchStoriesSuccess) {
          print("FetchStoriesSuccess");
          setState(() {
            publication = state.publications;
            publicationItem = state.publicationItem;
          });
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 50.0, bottom: 4.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.625368731563422,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  shrinkWrap: true,
                  itemCount: publicationItem.length,
                  itemBuilder: (context, index) {
                    return AspectRatio(
                      aspectRatio: 0.625368731563422,
                      child: VideoPlayer(
                        VideoPlayerController.networkUrl(Uri.parse(publicationItem[index].url ?? "https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/stories/placeholder.mp4?t=2024-03-19T14%3A15%3A20.129Z"))..initialize(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
