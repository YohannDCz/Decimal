import 'package:decimal/screens/home/widgets/main_feed.dart';
import 'package:decimal/screens/home/widgets/pics.dart';
import 'package:decimal/screens/home/widgets/posts.dart';
import 'package:decimal/screens/home/widgets/search_tab_bar.dart';
import 'package:decimal/screens/home/widgets/stories.dart';
import 'package:decimal/screens/home/widgets/videos.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String type = 'videos';

  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  bool _displayTabBar = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    const positionTabBar = 238.0; // Position en pixels à laquelle afficher la TabBar
    if (_scrollController.position.pixels >= positionTabBar && !_displayTabBar) {
      setState(() => _displayTabBar = true);
    } else if (_scrollController.position.pixels < positionTabBar && _displayTabBar) {
      setState(() => _displayTabBar = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: [
        TabBarView(
          controller: _tabController,
          children: [
            MainFeed(scrollController: _scrollController),
            const Stories(),
            const Videos(),
            const Pics(),
            const Posts(),
          ],
        ),
        SearchTabBar(
          afficherTabBar: _displayTabBar,
          tabController: _tabController,
        ),
      ],
    );
  }
}
