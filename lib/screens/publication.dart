import 'package:decimal/bloc/profile/profile_bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Publication extends StatefulWidget {
  const Publication({super.key});

  @override
  State<Publication> createState() => _PublicationState();
}

class _PublicationState extends State<Publication> {
  late bool isVideoURL;
  late bool isImageURL;
  late String imageURL;
  late bool iconImagePressed;
  late bool iconVideoPressed;
  late bool iconPlayPressed;
  late bool iconPostPressed;

  final publicationController = TextEditingController();
  final tagController = TextEditingController();
  final videoController = TextEditingController();
  final videoTitleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isVideoURL = false;
    isImageURL = false;
    imageURL = '';
    iconImagePressed = false;
    iconVideoPressed = false;
    iconPlayPressed = false;
    iconPostPressed = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Publication'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is UploadPicSuccess) {
                if (iconImagePressed) {
                  setState(() {
                    isImageURL = true;
                    imageURL = state.imageUrl;
                  });
                } else {
                  setState(() {
                    isImageURL = false;
                    imageURL = '';
                  });
                }
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextField(
                  controller: publicationController,
                  cursorColor: AppColors.black,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    border: InputBorder.none,
                    hintText: 'What\'s on your mind? ...',
                  ),
                  maxLines: 5,
                ),
                isImageURL
                    ? SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: Image.network(imageURL, fit: BoxFit.contain),
                      )
                    : const SizedBox.shrink(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Divider(thickness: 1, height: 1, color: Colors.black),
                    isVideoURL
                        ? Column(
                            children: [
                              TextField(
                                controller: videoTitleController,
                                cursorColor: AppColors.black,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(14.0),
                                  border: InputBorder.none,
                                  hintText: 'Title',
                                ),
                              ),
                              const Divider(thickness: 1, height: 1, color: Colors.black),
                              TextField(
                                controller: videoController,
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(14.0),
                                  border: InputBorder.none,
                                  hintText: 'https://www.youtube.com/watch?v=...',
                                ),
                              ),
                              const Divider(thickness: 1, height: 1, color: Colors.black),
                            ],
                          )
                        : const SizedBox.shrink(),
                    TextField(
                      controller: tagController,
                      cursorColor: AppColors.black,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(14.0),
                        border: InputBorder.none,
                        hintText: '#tag1 #tag2 #tag3',
                      ),
                    ),
                    const Divider(thickness: 1, height: 1, color: Colors.black),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                              child: IconButton(
                                  icon: Icon(Icons.play_circle, color: iconPlayPressed ? AppColors.black : AppColors.secondaryText),
                                  onPressed: () {
                                    if (iconPlayPressed) {
                                      setState(() {
                                        iconPlayPressed = false;
                                      });
                                    } else {
                                      setState(() {
                                        iconPlayPressed = true;
                                        iconImagePressed = false;
                                        iconVideoPressed = false;
                                        iconPostPressed = false;
                                        isVideoURL = false;
                                        imageURL = '';
                                        isImageURL = false;
                                      });
                                    }
                                  }),
                            ),
                            IconButton(
                              icon: Icon(FontAwesomeIcons.youtube, color: iconVideoPressed ? AppColors.black : AppColors.secondaryText),
                              onPressed: () {
                                if (iconVideoPressed) {
                                  setState(() {
                                    iconVideoPressed = false;
                                    isVideoURL = false;
                                  });
                                } else {
                                  setState(() {
                                    iconVideoPressed = true;
                                    iconImagePressed = false;
                                    iconPlayPressed = false;
                                    iconPostPressed = false;
                                    isVideoURL = true;
                                    imageURL = '';
                                    isImageURL = false;
                                  });
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.image, color: iconImagePressed ? AppColors.black : AppColors.secondaryText),
                              onPressed: () {
                                if (iconImagePressed) {
                                  setState(() {
                                    iconImagePressed = false;
                                    imageURL = '';
                                    isImageURL = false;
                                  });
                                } else {
                                  setState(() {
                                    iconImagePressed = true;
                                    iconVideoPressed = false;
                                    iconPlayPressed = false;
                                    iconPostPressed = false;
                                    isVideoURL = false;
                                  });
                                  BlocProvider.of<ProfileBloc>(context).add(UploadPic());
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.local_post_office, color: iconPostPressed ? AppColors.black : AppColors.secondaryText),
                              onPressed: () {
                                if (iconPostPressed) {
                                  setState(() {
                                    iconPostPressed = false;
                                  });
                                } else {
                                  setState(() {
                                    iconImagePressed = false;
                                    iconVideoPressed = false;
                                    iconPlayPressed = false;
                                    iconPostPressed = true;
                                    isVideoURL = false;
                                    isImageURL = false;
                                    imageURL = '';
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            var tagsList = tagController.text.split(' ');
                            BlocProvider.of<ProfileBloc>(context).add(
                              PublishPublication(
                                PublicationModel(
                                  type: isVideoURL
                                      ? "videos"
                                      : isImageURL
                                          ? "pics"
                                          : "posts",
                                  is_repost: false,
                                ),
                                PublicationItemModel(
                                  tags: tagsList,
                                  content: publicationController.text,
                                  url: isVideoURL
                                      ? videoController.text
                                      : isImageURL
                                          ? imageURL
                                          : null,
                                  title: isVideoURL ? videoTitleController.text : null,
                                ),
                              ),
                            );
                            BlocProvider.of<ProfileBloc>(context).add(FetchProfileContent(supabaseUser!.id));
                          },
                        ),
                      ],
                    ),
                    const Divider(thickness: 1, height: 1, color: Colors.black),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
