import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';

import 'publications.dart';

class MainFeed extends StatefulWidget {
  const MainFeed({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<MainFeed> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeed> {
  String type = 'videos';

  void _scrollToPosition() {
    widget.scrollController.animateTo(
      238.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
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
            child: Publications(type: type),
          ),
        ],
      ),
    );
  }
}
