import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/comment_model.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/screens/home/widgets/reactions.dart';
import 'package:decimal/service/feed_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FeedPublications extends StatefulWidget {
  const FeedPublications({
    super.key,
  });

  @override
  State<FeedPublications> createState() => _FeedPublicationsState();
}

class _FeedPublicationsState extends State<FeedPublications> {
  late List<PublicationModel> publications;
  late List<PublicationItemModel> publicationItems;
  late List<CustomUser> users;
  late List<List<CommentModel>> commentsAll;
  late List<List<CustomUser>> commentsUsers;

  String _extractId(String url) {
    String videoId = url.split('?')[0].substring('https://youtu.be/'.length);
    return videoId;
  }

  String _extractPseudo(String pseudo) {
    return pseudo.toLowerCase().replaceAll(' ', '');
  }

  @override
  initState() {
    super.initState();

    publications = [];
    publicationItems = [];
    users = [];
    commentsAll = [];
    commentsUsers = [];

    BlocProvider.of<FeedBloc>(context).add(FetchAllPublications());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FetchAllSuccess) {
          publications = state.fetchAllSuccess['publications'];
          publicationItems = state.fetchAllSuccess['publicationItems'];
          users = state.fetchAllSuccess['users'];
          commentsAll = state.fetchAllSuccess['comments'];
          commentsUsers = state.fetchAllSuccess['commentsUsers'];
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is FetchLoading,
          child: Container(
            color: AppColors.primaryBackground,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:  state is FetchLoading ? 1 : 18,
                itemBuilder: (context, index) {
                  if (publications.isNotEmpty && index < publications.length) {
                    late final PublicationModel publication = publications[index];
                    late final PublicationItemModel publicationItem = publicationItems[index];
                    late final CustomUser user = users[index];
                    late final List<CommentModel> comments = commentsAll[index];
                    late final List<CustomUser> commentUsers = commentsUsers[index];
          
                    final bool isNotDirty = publication.type != "songs" && publication.type != "articles" && publication.type != "pictures" && publication.type != "vids";
          
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
                                                user.profile_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.dart.jpeg?t=2024-03-20T07%3A27%3A00.569Z',
                                                width: 48.0,
                                                height: 48.0,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(user.name ?? 'John Doe', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                              Text(context.read<FeedService>().getDuration(publication.date_of_publication).toString(), style: Theme.of(context).primaryTextTheme.labelMedium),
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
                                    if (publication.type == 'posts')
                                      Container(
                                        width: double.infinity,
                                        color: AppColors.primaryBackground,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(publicationItem.content ?? 'This is a post', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                        ),
                                      )
                                    else if (publication.type == 'pics')
                                      Stack(
                                        children: [
                                          Image.network(
                                            publicationItem.url ?? 'https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg',
                                            width: double.infinity,
                                            height: 200.0,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            bottom: 8.0,
                                            left: 8.0,
                                            child: Reactions(publication_id: publication.id),
                                          ),
                                        ],
                                      )
                                    else if (publication.type == 'videos')
                                      YoutubePlayer(
                                        controller: YoutubePlayerController(
                                          initialVideoId: _extractId(publicationItem.url ?? 'https://youtu.be/zqXohGL36cw?si=9L3i-CjiMXNloIfh'), // Add videoID.
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
                            if (publication.type != 'pics' && isNotDirty)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                                child: Reactions(container: false, publication_id: publication.id),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Column(
                                children: [
                                  if (publication.type != "posts" && isNotDirty)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text.rich(
                                          TextSpan(
                                            text: user.pseudo ?? _extractPseudo(user.name ?? 'John Doe'),
                                            style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                            children: [
                                              const TextSpan(text: ' '),
                                              TextSpan(text: publicationItem.content ?? 'Content of the description', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                                      child: Text.rich(
                                        TextSpan(
                                          text: comments.length.toString(),
                                          style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: AppColors.accent3),
                                          children: [
                                            const TextSpan(text: ' '),
                                            TextSpan(text: 'COMMENTS', style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: AppColors.accent3)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (comments.isNotEmpty)
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: comments.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(bottom: 8.0),
                                              child: Text.rich(
                                                TextSpan(
                                                  text: commentUsers[index].pseudo ?? _extractPseudo(commentUsers[index].name ?? 'John Doe'),
                                                  style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                                  children: [
                                                    const TextSpan(text: ' '),
                                                    TextSpan(
                                                      text: comments[index].content,
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
                                padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
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
                  } else {
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
                                                'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.dart.jpeg?t=2024-03-20T07%3A27%3A00.569Z',
                                                width: 48.0,
                                                height: 48.0,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('John Doe', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                              Text('2h', style: Theme.of(context).primaryTextTheme.labelMedium),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Icon(Icons.more_vert),
                                    ],
                                  ),
                                ),
                                Image.network(
                                  'https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg',
                                  width: double.infinity,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                              child: Reactions(container: false, publication_id: 1),
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
                                          text: _extractPseudo('John Doe'),
                                          style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                          children: [
                                            const TextSpan(text: ' '),
                                            TextSpan(text: 'Content of the description', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                                      child: Text.rich(
                                        TextSpan(
                                          text: "12",
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
                                      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(bottom: 8.0),
                                            child: Text.rich(
                                              TextSpan(
                                                text: _extractPseudo('John Doe'),
                                                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                                children: [
                                                  const TextSpan(text: ' '),
                                                  TextSpan(
                                                    text: "This is a skeleton comment",
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
                                padding: const EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
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
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
