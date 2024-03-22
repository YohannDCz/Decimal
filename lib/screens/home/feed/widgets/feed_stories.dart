import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedStories extends StatefulWidget {
  const FeedStories({
    super.key,
  });

  @override
  State<FeedStories> createState() => _FeedStoriesState();
}

class _FeedStoriesState extends State<FeedStories> {
  @override
  initState() {
    super.initState();
  }

  String _extractPseudo(String pseudo) {
    return pseudo.toLowerCase().replaceAll(' ', '');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: SizedBox(
            width: double.infinity,
            height: 140.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                if (state is FetchAllSuccess) {
                  PublicationModel publication = state.fetchStoriesSuccess['publications'][index];
                  CustomUser user = state.fetchStoriesSuccess['users'][index];
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 4.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/stories', arguments: publication.id);
                        },
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
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/stories', arguments: publication.id);
                        },
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
                    );
                  }
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primary, width: 4.0),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: 72.0,
                              height: 72.0,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                        Text("pseudo", style: Theme.of(context).primaryTextTheme.bodySmall),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
