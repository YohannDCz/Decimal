// ignore_for_file: non_constant_identifier_names

import 'package:decimal/bloc/profile/profile_bloc.dart';
import 'package:decimal/bloc/reaction/reaction_bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/reaction_model.dart';
import 'package:decimal/service/reaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Reactions extends StatefulWidget {
  const Reactions({super.key, this.container = true, this.vertical = false, this.publication_id, this.commentFocusNode});

  final bool container;
  final int? publication_id;
  final bool vertical;
  final FocusNode? commentFocusNode;

  @override
  State<Reactions> createState() => _ReactionsState();
}

class _ReactionsState extends State<Reactions> {
  bool addedLike = false;
  bool addedLove = false;
  bool isReposted = false;
  @override
  Widget build(BuildContext context) {
    Future<List<ReactionModel>>? reactionsCount(String reactionType) async {
      return await context.read<ReactionService>().getReactions(reactionType, widget.publication_id);
    }

    Future<int>? repostsCount() async {
      return await context.read<ReactionService>().getReposts(widget.publication_id);
    }

    return Container(
      decoration: BoxDecoration(
        color: widget.container ? AppColors.black.withOpacity(0.5) : Colors.transparent,
        borderRadius: BorderRadius.circular(99.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: !widget.vertical
            ? Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (!addedLike) {
                            setState(() {
                              addedLike = true;
                            });
                            BlocProvider.of<ReactionBloc>(context).add(AddReaction('likes', widget.publication_id!));
                          } else {
                            BlocProvider.of<ReactionBloc>(context).add(RemoveReaction('likes', widget.publication_id!));
                            setState(() {
                              addedLike = false;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.thumb_up,
                          color: addedLike ? AppColors.customColor1 : AppColors.customColor1.withOpacity(0.5),
                          size: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: SizedBox(
                          width: 24.0,
                          child: FutureBuilder<List<ReactionModel>>(
                            future: reactionsCount('likes'),
                            builder: (BuildContext context, AsyncSnapshot<List<ReactionModel>> snapshot) {
                              return Text(
                                snapshot.hasData ? snapshot.data!.length.toString() : "0",
                                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: widget.container ? AppColors.white : AppColors.black),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (!addedLove) {
                            setState(() {
                              addedLove = true;
                            });
                            BlocProvider.of<ReactionBloc>(context).add(AddReaction('loves', widget.publication_id!));
                          } else {
                            BlocProvider.of<ReactionBloc>(context).add(RemoveReaction('loves', widget.publication_id!));
                            setState(() {
                              addedLove = false;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: addedLove ? AppColors.customColor2 : AppColors.customColor2.withOpacity(0.5),
                          size: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: SizedBox(
                          width: 24.0,
                          child: FutureBuilder<List<ReactionModel>>(
                            future: reactionsCount('loves'),
                            builder: (BuildContext context, AsyncSnapshot<List<ReactionModel>> snapshot) {
                              return Text(
                                snapshot.hasData ? snapshot.data!.length.toString() : "0",
                                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: widget.container ? AppColors.white : AppColors.black),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (widget.commentFocusNode != null) {
                            FocusScope.of(context).requestFocus(widget.commentFocusNode);
                          }
                        },
                        icon: Icon(
                          Icons.mode_comment,
                          color: AppColors.customColor3,
                          size: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: SizedBox(
                          width: 24.0,
                          child: FutureBuilder<List<ReactionModel>>(
                            future: reactionsCount('comments'),
                            builder: (BuildContext context, AsyncSnapshot<List<ReactionModel>> snapshot) {
                              return Text(
                                snapshot.hasData ? snapshot.data!.length.toString() : "0",
                                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: widget.container ? AppColors.white : AppColors.black),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (!isReposted) {
                            BlocProvider.of<ReactionBloc>(context).add(AddRepost(widget.publication_id!));
                            BlocProvider.of<ProfileBloc>(context).add(FetchProfileContent(supabaseUser!.id));
                            setState(() {
                              isReposted = true;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.repeat,
                          color: isReposted ? AppColors.customColor4 : AppColors.customColor4.withOpacity(0.5),
                          size: 20.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: SizedBox(
                          width: 24.0,
                          child: FutureBuilder<int>(
                            future: repostsCount(),
                            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                              return Text(
                                snapshot.hasData ? snapshot.data.toString() : "0",
                                style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: widget.container ? AppColors.white : AppColors.black),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (!addedLike) {
                              setState(() {
                                addedLike = true;
                              });
                              BlocProvider.of<ReactionBloc>(context).add(AddReaction('likes', widget.publication_id!));
                            } else {
                              BlocProvider.of<ReactionBloc>(context).add(RemoveReaction('likes', widget.publication_id!));
                              setState(() {
                                addedLike = false;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.thumb_up,
                            color: addedLike ? AppColors.customColor1 : AppColors.customColor1.withOpacity(0.5),
                            size: 20.0,
                          ),
                        ),
                        FutureBuilder<List<ReactionModel>>(
                          future: reactionsCount('likes'),
                          builder: (BuildContext context, AsyncSnapshot<List<ReactionModel>> snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data!.length.toString() : "0",
                              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: widget.container ? AppColors.white : AppColors.black),
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
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (!addedLove) {
                              setState(() {
                                addedLove = true;
                              });
                              BlocProvider.of<ReactionBloc>(context).add(AddReaction('loves', widget.publication_id!));
                            } else {
                              BlocProvider.of<ReactionBloc>(context).add(RemoveReaction('loves', widget.publication_id!));
                              setState(() {
                                addedLove = false;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: addedLove ? AppColors.customColor2 : AppColors.customColor2.withOpacity(0.5),
                            size: 20.0,
                          ),
                        ),
                        FutureBuilder<List<ReactionModel>>(
                          future: reactionsCount('loves'),
                          builder: (BuildContext context, AsyncSnapshot<List<ReactionModel>> snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data!.length.toString() : "0",
                              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: widget.container ? AppColors.white : AppColors.black),
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
                        FutureBuilder<List<ReactionModel>>(
                          future: reactionsCount('comments'),
                          builder: (BuildContext context, AsyncSnapshot<List<ReactionModel>> snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data!.length.toString() : "0",
                              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: widget.container ? AppColors.white : AppColors.black),
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
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (!isReposted) {
                              BlocProvider.of<ReactionBloc>(context).add(AddRepost(widget.publication_id!));
                              BlocProvider.of<ProfileBloc>(context).add(FetchProfileContent(supabaseUser!.id));
                              setState(() {
                                isReposted = true;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.repeat,
                            color: isReposted ? AppColors.customColor4 : AppColors.customColor4.withOpacity(0.5),
                            size: 20.0,
                          ),
                        ),
                        FutureBuilder<int>(
                          future: repostsCount(),
                          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                            return Text(
                              snapshot.hasData ? snapshot.data.toString() : "0",
                              style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: widget.container ? AppColors.white : AppColors.black),
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
