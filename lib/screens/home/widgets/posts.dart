import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/screens/home/widgets/reactions.dart';
import 'package:decimal/service/feed_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  late final List<CustomUser> users;
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<FeedBloc>(context).add(FetchPosts());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 64,
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            color: AppColors.primaryBackground,
            child: Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  if (state is FetchPostsSuccess) { 
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
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
                                            state.users[index].profile_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png',
                                            width: 48.0,
                                            height: 48.0,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(state.users[index].name ?? 'Amanda Wilson', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                          Text(context.read<FeedService>().getDuration(state.publications[index].date_of_publication).toString(), style: Theme.of(context).primaryTextTheme.labelMedium),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Icon(Icons.more_vert),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              color: AppColors.primaryBackground,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(state.publicationItem[index].content ?? 'This is a post', style: Theme.of(context).primaryTextTheme.bodyMedium),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Reactions(container: false),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
