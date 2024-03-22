// ignore_for_file: non_constant_identifier_names

import 'package:decimal/config/theme.dart';
import 'package:decimal/service/feed_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Reactions extends StatelessWidget {
  const Reactions({super.key, this.container = true, this.vertical = false, this.publication_id});

  final bool container;
  final int? publication_id;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    Future<int>? reactionsCount(String reactionType) async {
      return await context.read<FeedService>().getReactions(reactionType, publication_id);
    }

    return Container(
      decoration: BoxDecoration(
        color: container ? AppColors.black.withOpacity(0.5) : Colors.transparent,
        borderRadius: BorderRadius.circular(99.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: !vertical
            ? Row(
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
                            child: FutureBuilder<int>(
                              future: reactionsCount('likes'),
                              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                return Text(
                                  snapshot.hasData ? snapshot.data.toString() : "0",
                                  style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black),
                                );
                              },
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
                            child: FutureBuilder<int>(
                              future: reactionsCount('loves'),
                              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                return Text(
                                  snapshot.hasData ? snapshot.data.toString() : "0",
                                  style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black),
                                );
                              },
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
                        Icon(Icons.mode_comment, color: AppColors.customColor3, size: 20.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: SizedBox(
                            width: 36.0,
                            child: FutureBuilder<int>(
                              future: reactionsCount('comments'),
                              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                return Text(
                                  snapshot.hasData ? snapshot.data.toString() : "0",
                                  style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black),
                                );
                              },
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
                        Icon(Icons.repeat, color: AppColors.customColor4, size: 20.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: SizedBox(
                            width: 36.0,
                            child: FutureBuilder<int>(
                              future: reactionsCount('reposts'),
                              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                                return Text(
                                  snapshot.hasData ? snapshot.data.toString() : "0",
                                  style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        Icon(Icons.thumb_up, color: AppColors.customColor1, size: 20.0),
                        FutureBuilder<int>(
                          future: reactionsCount('likes'),
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data.toString() : "0",
                              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        Icon(Icons.favorite, color: AppColors.customColor2, size: 20.0),
                        FutureBuilder<int>(
                          future: reactionsCount('loves'),
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data.toString() : "0",
                              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        Icon(Icons.mode_comment, color: AppColors.customColor3, size: 20.0),
                        FutureBuilder<int>(
                          future: reactionsCount('comments'),
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data.toString() : "0",
                              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Column(
                      children: [
                        Icon(Icons.repeat, color: AppColors.customColor4, size: 20.0),
                        FutureBuilder<int>(
                          future: reactionsCount('reposts'),
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data.toString() : "0",
                              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: container ? AppColors.white : AppColors.black),
                            );
                          },
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
