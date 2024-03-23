import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/screens/home/widgets/reactions.dart';
import 'package:decimal/service/feed_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Videos extends StatefulWidget {
  const Videos({super.key});

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> with AutomaticKeepAliveClientMixin {
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FeedBloc>(context).add(FetchVideos());
    });
  }

  String _extractId(String url) {
    String videoId = url.split('?')[0].substring('https://youtu.be/'.length);
    return videoId;
  }

  String _extractPseudo(String pseudo) {
    return pseudo.toLowerCase().replaceAll(' ', '');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FetchVideosSuccess) {
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
            child: Container(
              color: AppColors.primaryBackground,
              width: double.infinity,
              child: Column(
                children: [
                  const Gap(46),
                  if (state is FetchLoading) LinearProgressIndicator(color: AppColors.secondary, minHeight: 1),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state is FetchLoading ? 3 : 18,
                      itemBuilder: (context, index) {
                        if (publications.isNotEmpty && index < publications.length) {
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
                                                      users[index].profile_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.dart.jpeg?t=2024-03-21T08%3A31%3A52.510Z',
                                                      width: 48.0,
                                                      height: 48.0,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(users[index].name ?? '[user_name]', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                                    Text('${context.read<FeedService>().getDuration(publications[index].date_of_publication)?.toString()} ago', style: Theme.of(context).primaryTextTheme.labelMedium),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Icon(Icons.more_vert),
                                          ],
                                        ),
                                      ),
                                      YoutubePlayer(
                                        controller: YoutubePlayerController(
                                          initialVideoId: _extractId(publicationItems[index].url ?? "https://youtu.be/dQw4w9WgXcQ?si=C1RoFT6luIcZHlN-"), // Add videoID.
                                          flags: const YoutubePlayerFlags(
                                            autoPlay: false,
                                            mute: false,
                                          ),
                                        ),
                                        showVideoProgressIndicator: true,
                                        onReady: () {
                                          debugPrint('Player is ready.');
                                        },
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                    child: Reactions(container: false, publication_id: publications[index].id),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text.rich(
                                        TextSpan(
                                          text: users[index].pseudo ?? _extractPseudo(users[index].name ?? '[user_pseudo]'),
                                          style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                          children: [
                                            const TextSpan(text: ' '),
                                            TextSpan(text: publicationItems[index].title ?? '[Publication content]', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
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
                                                      'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.dart.jpeg?t=2024-03-21T08%3A31%3A52.510Z',
                                                      width: 48.0,
                                                      height: 48.0,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('[user_name]', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                                    Text("2h", style: Theme.of(context).primaryTextTheme.labelMedium),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const Icon(Icons.more_vert),
                                          ],
                                        ),
                                      ),
                                      AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Image.asset("assets/images/placeholder.png", fit: BoxFit.cover, width: double.infinity),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8.0, left: 8.0),
                                    child: Reactions(container: false, publication_id: 1),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text.rich(
                                        TextSpan(
                                          text: '[user_pseudo]',
                                          style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                          children: [
                                            const TextSpan(text: ' '),
                                            TextSpan(text: '[Publication content]', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
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
