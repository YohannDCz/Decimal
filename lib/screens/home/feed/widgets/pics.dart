import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Pics extends StatefulWidget {
  const Pics({super.key});

  @override
  State<Pics> createState() => _PicsState();
}

class _PicsState extends State<Pics> {
  late List<PublicationItemModel> publicationItems;
  late List<PublicationModel> publications;
  late List<CustomUser> users;

  @override
  initState() {
    super.initState();
    publicationItems = [];
    publications = [];
    users = [];
    BlocProvider.of<FeedBloc>(context).add(FetchPics());
  }

  @override
  Widget build(BuildContext context) {
    double mediaQuery = MediaQuery.of(context).size.width;
    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FetchPicsSuccess) {
          setState(() {
            publications = state.publications;
            publicationItems = state.publicationItem;
            users = state.users;
          });
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<FeedBloc>(context).add(FetchPics());
          },
          child: Skeletonizer(
            enabled: publications.isEmpty,
            containersColor: AppColors.accent3,
            child: SizedBox(
              height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (state is FetchPicsLoading) LinearProgressIndicator(color: AppColors.primary, minHeight: 1),
                    Padding(
                      padding: mediaQuery > 1000 ? const EdgeInsets.only(top: 4.0, left: 300.0, right:300.0) : const EdgeInsets.only(top: 4.0),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0,
                        ),
                        shrinkWrap: true,
                        itemCount: state is FetchLoading ? 18 : publicationItems.length,
                        itemBuilder: (context, index) {
                          if (publicationItems.isNotEmpty && index < publicationItems.length) {
                            return Hero(
                              tag: 'MyHero${publicationItems[index].id}',
                              child: Material(
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pushNamed('/pic_widget', arguments: {'publication': publications[index], 'publicationItem': publicationItems[index], 'user': users[index]}),
                                  child: Image.network(
                                    publicationItems[index].url ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-22T15%3A47%3A36.888Z',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Image.asset('assets/images/placeholder.png', fit: BoxFit.cover);
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
