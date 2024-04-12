import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/home/feed/widgets/main_feed.dart';
import 'package:decimal/screens/home/feed/widgets/pics.dart';
import 'package:decimal/screens/home/feed/widgets/posts.dart';
import 'package:decimal/screens/home/feed/widgets/stories.dart';
import 'package:decimal/screens/home/feed/widgets/videos.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final FocusNode _searchBarFocusNode;
  late final TabController _tabController;
  bool _displayTabBar = false;
  int _selectedIndex = 0;

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
    if (_scrollController.position.pixels >= positionTabBar) {
      setState(() => _displayTabBar = true);
    } else if (_scrollController.position.pixels < positionTabBar) {
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
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: _displayTabBar ? 94 : 46, // Ajustez la hauteur si nécessaire
                color: Colors.white, // Ajustez selon votre thème
                child: Column(
                  children: [
                    Visibility(
                      visible: _displayTabBar,
                      child: TextField(
                        focusNode: _searchBarFocusNode,
                        decoration: InputDecoration(
                          hintText: "What's new with you ? ...",
                          hintStyle: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.accent3),
                          alignLabelWithHint: true,
                          prefixIcon: IconButton(splashColor: AppColors.alternate, icon: Icon(Icons.arrow_downward, color: AppColors.accent3), onPressed: () {
                            Navigator.of(context).pushNamed('/publication');
                          }),
                          suffixIcon: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.white, width: 4),
                              color: AppColors.primary,
                            ),
                            child: Icon(
                              Icons.search,
                              color: AppColors.white,
                            ),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    _buildTabBarWithIndicator(),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  // Remplacez par vos Widgets : MainFeed, Stories, Posts, Pics, Videos
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBarWithIndicator() {
    return Container(
      color: AppColors.white,
      child: Stack(
        children: [
          SizedBox(
            height: 46, // Hauteur ajustée pour inclure l'indicateur
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(5, (index) => _buildTabIcon(index)),
            ),
          ),
          Positioned(
            bottom: 0,
            left: MediaQuery.of(context).size.width * _selectedIndex / 5,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: MediaQuery.of(context).size.width / 5,
              height: 2,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabIcon(int index) {
    List<IconData> icons = [
      Icons.feed,
      Icons.play_circle,
      FontAwesomeIcons.youtube,
      Icons.image,
      Icons.email,
    ];

    return GestureDetector(
      onTap: () => setState(() {
        _selectedIndex = index;
      }),
      child: Icon(icons[index], size: 20.0, color: index == _selectedIndex ? Colors.black : Colors.grey),
    );
  }
}
