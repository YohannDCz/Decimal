import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/home/widgets/reactions.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Publications extends StatelessWidget {
  const Publications({
    super.key,
    required this.type,
  });

  final String type;

  String _extractId(String url) {
    String videoId = url.split('?')[0].substring('https://youtu.be/'.length);
    return videoId;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, right: 8.0, left: 8.0),
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
                    Column(
                      children: [
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
                              initialVideoId: _extractId('https://youtu.be/zqXohGL36cw?si=9L3i-CjiMXNloIfh'), // Add videoID.
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
                  ],
                ),
                if (type != 'pics')
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Reactions(container: false),
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Column(
                    children: [
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text.rich(
                            TextSpan(
                              text: '12',
                              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: AppColors.accent3),
                              children: [
                                const TextSpan(text: ' '),
                                TextSpan(text: 'COMMENTS', style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: AppColors.accent3)),
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
                                    style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
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
                    ],
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
                            suffixIcon: IconButton(icon: Icon(Icons.arrow_upward, color: AppColors.black, size: 24.0), onPressed: () {}),
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
                            contentPadding: const EdgeInsets.only(left: 48.0, top: 8.0, right: 4.0, bottom: 8.0),
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
    );
  }
}
