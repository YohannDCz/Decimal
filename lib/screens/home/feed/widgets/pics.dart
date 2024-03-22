import 'package:decimal/bloc/feed/feed_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pics extends StatefulWidget {
  const Pics({super.key});

  @override
  State<Pics> createState() => _PicsState();
}

class _PicsState extends State<Pics> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<PublicationItemModel> publicationItems;
  @override
  initState() {
    super.initState();
    publicationItems = [];
    BlocProvider.of<FeedBloc>(context).add(FetchPics());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocConsumer<FeedBloc, FeedState>(
      listener: (context, state) {
        if (state is FetchPicsSuccess) {
          setState(() {
            publicationItems = state.publicationItem;
          });
        }
      },
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                height48,
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                  ),
                  shrinkWrap: true,
                  itemCount: publicationItems.length,
                  itemBuilder: (context, index) {
                    return Image.network(publicationItems[index].url ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/placeholder_pics.png?t=2024-03-21T08%3A33%3A54.213Z', fit: BoxFit.cover);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
