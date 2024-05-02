import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FeedStories extends StatefulWidget {
  const FeedStories({
    super.key,
  });

  @override
  State<FeedStories> createState() => _FeedStoriesState();
}

class _FeedStoriesState extends State<FeedStories> {
  late List<PublicationModel> publications;
  late List<PublicationItemModel> publicationItems;
  late List<CustomUser> users;

  @override
  initState() {
    super.initState();
    publications = [];
    publicationItems = [];
    users = [];
  }

  String _extractPseudo(String pseudo) {
    return pseudo.toLowerCase().replaceAll(' ', '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FetchAllSuccess) {
          setState(() {
            publications = state.fetchStoriesSuccess['publications'];
            publicationItems = state.fetchStoriesSuccess['publicationItems'];
            users = state.fetchStoriesSuccess['users'];
          });
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: state is FetchLoading,
          ignoreContainers: true,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 120.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  if (state is! FetchLoading) {
                    PublicationModel publication = publications[index];
                    PublicationItemModel publicationItem = publicationItems[index];
                    CustomUser user = users[index];

                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 4.0),
                        child: Material(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed('/story_widget', arguments: {'publication': publication, 'publicationItem': publicationItem, 'user': users[index]}),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primary, width: 4.0),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      radius: 36.0,
                                      backgroundImage: NetworkImage(user.profile_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.dart.jpeg?t=2024-03-20T14%3A44%3A04.325Z'),
                                    ),
                                  ),
                                ),
                                Text(user.pseudo ?? _extractPseudo(user.name ?? "John Doe"), style: Theme.of(context).primaryTextTheme.bodySmall),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Material(
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pushNamed('/story_widget', arguments: {'publication': publication, 'publicationItem': publicationItem, 'user': users[index]}),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primary, width: 4.0),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: CircleAvatar(
                                      radius: 36.0,
                                      backgroundImage: NetworkImage(user.profile_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.dart.jpeg?t=2024-03-20T14%3A44%3A04.325Z'),
                                    ),
                                  ),
                                ),
                                Text(user.pseudo ?? _extractPseudo(user.name ?? "John Doe"), style: Theme.of(context).primaryTextTheme.bodySmall),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Column(
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
                              backgroundImage: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.dart.jpeg?t=2024-03-20T14%3A44%3A04.325Z'),
                            ),
                          ),
                        ),
                        Text(_extractPseudo("John Doe"), style: Theme.of(context).primaryTextTheme.bodySmall),
                      ],
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
