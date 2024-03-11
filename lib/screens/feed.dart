import 'package:decimal/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  String type = 'stories';

  String _extractId(String url) {
    String videoId = url.split('?')[0].substring('https://youtu.be/'.length);
    print(videoId);
    return videoId;
  }

  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with a network URL to your MP4 video
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
          'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/vids/1.mp4?t=2024-03-11T15%3A55%3A24.522Z'),
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(Icons.photo_camera, size: 24.0, color: AppColors.accent3),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0, bottom: 56.0),
                child: Image.asset('assets/images/logotype.png', width: 189.0, height: 46.0),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 345.0,
                height: 48.0,
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: "What's new with you ? ...",
                    labelStyle: TextStyle(color: AppColors.accent3),
                    prefixIcon: Icon(Icons.arrow_downward, color: AppColors.accent3, size: 24.0),
                    suffixIcon: Icon(Icons.search, color: AppColors.accent3, size: 24.0),
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(99.0),
                      borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(99.0),
                      borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(99.0),
                      borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamedAndRemoveUntil('/feed_expanded', (route) => false);
                  },
                ),
              ),
            ),
            _stories(),
            Container(
              color: AppColors.primaryBackground,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
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
                                            borderRadius: BorderRadius.circular(8.0),
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
                                            Text('2 hours ago', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.more_vert),
                                  ],
                                ),
                              ),
                              if (type == 'posts')
                                Container(
                                  width: double.infinity,
                                  color: AppColors.primaryBackground,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text('This is a post', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                  ),
                                )
                              else if (type == 'pics')
                                Stack(
                                  children: [
                                    Image.network(
                                      'https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg',
                                      width: double.infinity,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    ),
                                    const Positioned(
                                      bottom: 8.0,
                                      left: 8.0,
                                      child: Reactions(),
                                    ),
                                  ],
                                )
                              else if (type == 'videos')
                                YoutubePlayer(
                                  controller: YoutubePlayerController(
                                    initialVideoId:
                                        _extractId('https://youtu.be/zqXohGL36cw?si=9L3i-CjiMXNloIfh'), // Add videoID.
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
                          if (type != 'pics')
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
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .bodyMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                  children: [
                                    const TextSpan(text: ' '),
                                    TextSpan(
                                        text: 'With my family!', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: '12',
                                  style:
                                      Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: AppColors.accent3),
                                  children: [
                                    const TextSpan(text: ' '),
                                    TextSpan(
                                        text: 'COMMENTS',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyMedium!
                                            .copyWith(color: AppColors.accent3)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text.rich(
                                      TextSpan(
                                        text: 'Amanda Wilson'.toLowerCase().replaceAll(' ', ''),
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .bodyMedium!
                                            .copyWith(fontWeight: FontWeight.bold),
                                        children: [
                                          const TextSpan(text: ' '),
                                          TextSpan(
                                            text: 'With my family!',
                                            style: Theme.of(context).primaryTextTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  TextField(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      filled: true,
                                      fillColor: AppColors.primaryBackground,
                                      hintText: 'Write a comment...',
                                      hintStyle: Theme.of(context).primaryTextTheme.bodyMedium,
                                      suffixIcon: IconButton(
                                          icon: Icon(Icons.arrow_upward, color: AppColors.black, size: 24.0),
                                          onPressed: () {}),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(99.0),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(99.0),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(99.0),
                                        borderSide: const BorderSide(color: Colors.transparent),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.only(left: 48.0, top: 8.0, right: 4.0, bottom: 8.0),
                                    ),
                                  ),
                                  const Positioned(
                                    top: 10.0,
                                    left: 8.0,
                                    child: CircleAvatar(
                                      radius: 14.0,
                                      backgroundImage: NetworkImage(
                                        'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png',
                                      ),
                                    ),
                                  ),
                                ],
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
      ],
    ));
  }

  Padding _stories() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 140.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          reverse: true,
          itemCount: 10,
          itemBuilder: (context, index) {
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
                        backgroundImage: NetworkImage(
                            'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png'),
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
    );
  }
}

class Reactions extends StatelessWidget {
  const Reactions({super.key, this.container = true});

  final bool container;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: container ? AppColors.black.withOpacity(0.5) : Colors.transparent,
        borderRadius: BorderRadius.circular(99.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Icon(Icons.thumb_up, color: AppColors.customColor1, size: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: SizedBox(
                      width: 30.0,
                      child: Text(
                        '1.2k',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium!
                            .copyWith(color: container ? AppColors.white : AppColors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Icon(Icons.favorite, color: AppColors.customColor2, size: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: SizedBox(
                      width: 30.0,
                      child: Text('1.2k',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyMedium!
                              .copyWith(color: container ? AppColors.white : AppColors.black)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Icon(Icons.mode_comment, color: AppColors.customColor3, size: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: SizedBox(
                      width: 30.0,
                      child: Text('1.2k',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyMedium!
                              .copyWith(color: container ? AppColors.white : AppColors.black)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Icon(Icons.repeat, color: AppColors.customColor4, size: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: SizedBox(
                      width: 30.0,
                      child: Text('1.2k',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyMedium!
                              .copyWith(color: container ? AppColors.white : AppColors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
