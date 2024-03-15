import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/home/feed.dart';
import 'package:decimal/screens/home/widgets/reactions.dart';
import 'package:flutter/material.dart';

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
