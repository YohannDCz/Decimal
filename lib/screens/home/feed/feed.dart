import 'package:decimal/screens/home/feed/widgets/main_feed.dart';
import 'package:decimal/screens/home/feed/widgets/pics.dart';
import 'package:decimal/screens/home/feed/widgets/posts.dart';
import 'package:decimal/screens/home/feed/widgets/stories.dart';
import 'package:decimal/screens/home/feed/widgets/videos.dart';
import 'package:decimal/screens/home/feed/widgets/search_tab_bar.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  String type = 'videos';

  late final ScrollController _scrollController;
  late final FocusNode _searchBarFocusNode;
  late TabController _tabController;
  bool _displayTabBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _searchBarFocusNode = FocusNode();
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
    return Stack(
      children: [
        TabBarView(
          controller: _tabController,
          children: [
            MainFeed(
              scrollController: _scrollController,
              searchBarfocusNode: _searchBarFocusNode,
            ),
            const Stories(),
            const Videos(),
            const Pics(),
            const Posts(),
          ],
        ),
        SearchTabBar(
          afficherTabBar: _displayTabBar,
          tabController: _tabController,
          searchBarFocusNode: _searchBarFocusNode,
        ),
      ],
    );
  }
}
