import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> with SingleTickerProviderStateMixin {
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
    return Stack(
      children: [
        TabBarView(
          controller: _tabController,
          children: [
            MainFeed(scrollController: _scrollController, type: type),
            Stories(scrollController: _scrollController),
            Videos(scrollController: _scrollController),
            Pics(scrollController: _scrollController),
            Posts(scrollController: _scrollController),
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

class SearchTabBar extends StatelessWidget {
  const SearchTabBar({
    super.key,
    required bool afficherTabBar,
    required TabController tabController,
  })  : _displayTabBar = afficherTabBar,
        _tabController = tabController;

  final bool _displayTabBar;
  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500), // Durée de l'animation
      curve: Curves.easeInOut, // Type d'animation, ajustez selon vos préférences
      top: _displayTabBar ? 0 : -50, // Changez -50 à la hauteur négative de votre TabBar pour la cacher
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white, // Ajustez selon votre thème
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "What's new with you ? ...",
                hintStyle: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.accent3),
                alignLabelWithHint: true,
                prefixIcon: IconButton(splashColor: AppColors.alternate, icon: Icon(Icons.arrow_downward, color: AppColors.accent3), onPressed: () {}),
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
            TabBar(
              controller: _tabController,
              indicatorColor: AppColors.black,
              labelColor: AppColors.black,
              unselectedLabelColor: AppColors.accent3,
              tabs: const [
                Tab(icon: Icon(Icons.feed, size: 20.0)),
                Tab(icon: Icon(Icons.play_circle, size: 20.0)),
                Tab(icon: Icon(FontAwesomeIcons.youtube, size: 20.0)),
                Tab(icon: Icon(Icons.image, size: 20.0)),
                Tab(icon: Icon(Icons.email, size: 20.0)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MainFeed extends StatelessWidget {
  const MainFeed({
    super.key,
    required ScrollController scrollController,
    required this.type,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final String type;

  void _scrollToPosition() {
    _scrollController.animateTo(
      238.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  String _extractId(String url) {
    String videoId = url.split('?')[0].substring('https://youtu.be/'.length);
    return videoId;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 66.0, right: 16.0),
              child: Icon(Icons.photo_camera, size: 24.0, color: AppColors.accent3),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 56.0),
              child: Image.asset('assets/images/logotype.png', width: 189.0, height: 46.0),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 345.0,
              height: 48.0,
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  labelText: "What's new with you ? ...",
                  labelStyle: TextStyle(color: AppColors.accent3),
                  prefixIcon: Icon(Icons.arrow_downward, color: AppColors.accent3, size: 24.0),
                  suffixIcon: Icon(Icons.search, color: AppColors.accent3, size: 24.0),
                  filled: true,
                  fillColor: AppColors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(99.0),
                    borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(99.0),
                    borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(99.0),
                    borderSide: BorderSide(color: AppColors.accent3, width: 4.0, style: BorderStyle.solid),
                  ),
                ),
                onTap: () {
                  _scrollToPosition();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 140.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 4.0),
                      child: Column(
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
                                backgroundImage: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png'),
                              ),
                            ),
                          ),
                          Text('amandaw', style: Theme.of(context).primaryTextTheme.bodySmall),
                        ],
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
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
                              backgroundImage: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png'),
                            ),
                          ),
                        ),
                        Text('amandaw', style: Theme.of(context).primaryTextTheme.bodySmall),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            color: AppColors.primaryBackground,
            width: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 4.0, right: 4.0, left: 4.0),
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
                                            'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png',
                                            width: 48.0,
                                            height: 48.0,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Amanda Wilson', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                          Text('2h ago', style: Theme.of(context).primaryTextTheme.labelMedium),
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
                                if (type == 'posts')
                                  Container(
                                    width: double.infinity,
                                    color: AppColors.primaryBackground,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text('This is a post', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                    ),
                                  )
                                else if (type == 'pics')
                                  Stack(
                                    children: [
                                      Image.network(
                                        'https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg',
                                        width: double.infinity,
                                        height: 200.0,
                                        fit: BoxFit.cover,
                                      ),
                                      const Positioned(
                                        bottom: 8.0,
                                        left: 8.0,
                                        child: Reactions(),
                                      ),
                                    ],
                                  )
                                else if (type == 'videos')
                                  YoutubePlayer(
                                    controller: YoutubePlayerController(
                                      initialVideoId: _extractId('https://youtu.be/zqXohGL36cw?si=9L3i-CjiMXNloIfh'), // Add videoID.
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
                        if (type != 'pics')
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Reactions(container: false),
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
                                      text: 'Amanda Wilson'.toLowerCase().replaceAll(' ', ''),
                                      style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                      children: [
                                        const TextSpan(text: ' '),
                                        TextSpan(text: 'With my family!', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text.rich(
                                    TextSpan(
                                      text: '12',
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: Text.rich(
                                          TextSpan(
                                            text: 'Amanda Wilson'.toLowerCase().replaceAll(' ', ''),
                                            style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                            children: [
                                              const TextSpan(text: ' '),
                                              TextSpan(
                                                text: 'With my family!',
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
                            padding: const EdgeInsets.all(8.0),
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
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Stories extends StatelessWidget {
  const Stories({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          height54,
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.infinity,
              height: 140.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 4.0),
                      child: Column(
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
                                backgroundImage: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png'),
                              ),
                            ),
                          ),
                          Text('amandaw', style: Theme.of(context).primaryTextTheme.bodySmall),
                        ],
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
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
                              backgroundImage: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png'),
                            ),
                          ),
                        ),
                        Text('amandaw', style: Theme.of(context).primaryTextTheme.bodySmall),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.625368731563422,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return AspectRatio(
                    aspectRatio: 0.625368731563422,
                    child: VideoPlayer(
                      VideoPlayerController.networkUrl(Uri.parse('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/stories/1.mp4?t=2023-11-19T07%3A21%3A29.624Z'))..initialize(),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}

class Videos extends StatelessWidget {
  const Videos({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  String _extractId(String url) {
    String videoId = url.split('?')[0].substring('https://youtu.be/'.length);
    return videoId;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        color: AppColors.primaryBackground,
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
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
                                              'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png',
                                              width: 48.0,
                                              height: 48.0,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Amanda Wilson', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                            Text('2h ago', style: Theme.of(context).primaryTextTheme.labelMedium),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Icon(Icons.more_vert),
                                  ],
                                ),
                              ),
                              YoutubePlayer(
                                controller: YoutubePlayerController(
                                  initialVideoId: _extractId('https://youtu.be/zqXohGL36cw?si=9L3i-CjiMXNloIfh'), // Add videoID.
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Reactions(container: false),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: 'Amanda Wilson'.toLowerCase().replaceAll(' ', ''),
                                  style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                                  children: [
                                    const TextSpan(text: ' '),
                                    TextSpan(text: 'With my family!', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Pics extends StatelessWidget {
  const Pics({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: SizedBox(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - kToolbarHeight - kBottomNavigationBarHeight,
        child: Column(
          children: [
            height48,
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 2.0,
              ),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Image.network('https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg', fit: BoxFit.cover);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Posts extends StatelessWidget {
  const Posts({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 64,
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        color: AppColors.primaryBackground,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
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
                                    'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png',
                                    width: 48.0,
                                    height: 48.0,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Amanda Wilson', style: Theme.of(context).primaryTextTheme.bodyMedium),
                                  Text('2h ago', style: Theme.of(context).primaryTextTheme.labelMedium),
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
                        child: Text('This is a post', style: Theme.of(context).primaryTextTheme.bodyMedium),
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
          },
        ),
      ),
    );
  }
}

class Reactions extends StatelessWidget {
  const Reactions({super.key, this.container = true});

  final bool container;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: container ? AppColors.black.withOpacity(0.5) : Colors.transparent,
        borderRadius: BorderRadius.circular(99.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Icon(Icons.thumb_up, color: AppColors.customColor1, size: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: SizedBox(
                      width: 36.0,
                      child: Text(
                        '1.2k',
                        style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Icon(Icons.favorite, color: AppColors.customColor2, size: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: SizedBox(
                      width: 36.0,
                      child: Text('1.2k', style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Icon(Icons.mode_comment, color: AppColors.customColor3, size: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: SizedBox(
                      width: 36.0,
                      child: Text('1.2k', style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Icon(Icons.repeat, color: AppColors.customColor4, size: 20.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: SizedBox(
                      width: 36.0,
                      child: Text('1.2k', style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
