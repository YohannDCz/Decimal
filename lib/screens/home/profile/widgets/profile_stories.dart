import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ProfileStories extends StatelessWidget {
  const ProfileStories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: AppColors.white,
        ),
        height: 160.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 8.0),
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 12,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: 72.0,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: AspectRatio(
                          aspectRatio: 0.625368731563422,
                          child: VideoPlayer(
                            VideoPlayerController.networkUrl(Uri.parse('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/stories/1.mp4?t=2023-11-19T07%3A21%3A29.624Z'))..initialize(),
                          ),
                        ),
                      ),
                      height4,
                      Text(
                        'title'.toLowerCase().replaceAll(' ', '_'),
                        style: Theme.of(context).primaryTextTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
