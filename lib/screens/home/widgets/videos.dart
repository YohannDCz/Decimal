import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/home/widgets/reactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FeedBloc>(context).add(FetchVideos());
    });
  }

  String _extractId(String url) {
    String videoId = url.split('?')[0].substring('https://youtu.be/'.length);
    return videoId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            color: AppColors.primaryBackground,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(6.0),
                                                child: Image.network(
                                                  'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png',
                                                  width: 48.0,
                                                  height: 48.0,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('Amanda Wilson', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                                Text('2h ago', style: Theme.of(context).primaryTextTheme.labelMedium),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Icon(Icons.more_vert),
                                      ],
                                    ),
                                  ),
                                  if (state is FetchVideosSuccess)
                                  YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: _extractId(state.publicationItem[index].url ?? "https://youtu.be/dQw4w9WgXcQ?si=C1RoFT6luIcZHlN-"), // Add videoID.
                                      flags: const YoutubePlayerFlags(
                                        autoPlay: false,
                                        mute: false,
                                      ),
                                    ),
                                    showVideoProgressIndicator: true,
                                    onReady: () {
                                      print('Player is ready.');
                                    },
                                  )
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                child: Reactions(container: false),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text.rich(
                                    TextSpan(
                                      text: 'Amanda Wilson'.toLowerCase().replaceAll(' ', ''),
                                      style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                      children: [
                                        const TextSpan(text: ' '),
                                        TextSpan(text: 'With my family!', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
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
