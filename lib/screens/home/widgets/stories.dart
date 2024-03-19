import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/service/feed_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class Stories extends StatefulWidget {
  const Stories({super.key});

  @override
  State<Stories> createState() => _StoriesState();
}

class _StoriesState extends State<Stories> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FeedBloc>(context).add(FetchStories());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              height54,
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 140.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 4.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primary, width: 4.0),
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: CircleAvatar(
                                    radius: 36.0,
                                    backgroundImage: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png'),
                                  ),
                                ),
                              ),
                              Text('amandaw', style: Theme.of(context).primaryTextTheme.bodySmall),
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primary, width: 4.0),
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  radius: 36.0,
                                  backgroundImage: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png'),
                                ),
                              ),
                            ),
                            Text('amandaw', style: Theme.of(context).primaryTextTheme.bodySmall),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (state is FetchStoriesSuccess)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.625368731563422,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return AspectRatio(
                          aspectRatio: 0.625368731563422,
                          child: VideoPlayer(
                            VideoPlayerController.networkUrl(Uri.parse(state.publicationItem[index].url ?? "https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/stories/placeholder.mp4?t=2024-03-19T14%3A15%3A20.129Z"))..initialize(),
                          ));
                    },
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.625368731563422,
                      crossAxisSpacing: 4.0,
                      mainAxisSpacing: 4.0,
                    ),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const Center(child: CircularProgressIndicator());
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
