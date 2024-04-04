import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:decimal/screens/home/widgets/reactions.dart';
import 'package:decimal/service/feed_service.dart';
import 'package:decimal/service/vision_gpt_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PicWidget extends StatefulWidget {
  const PicWidget({super.key, required PublicationModel publication, required PublicationItemModel publicationItem, required CustomUser user})
      : _publication = publication,
        _publicationItem = publicationItem,
        _user = user;

  final PublicationModel _publication;
  final PublicationItemModel _publicationItem;
  final CustomUser _user;

  @override
  State<PicWidget> createState() => _PicWidgetState();
}

class _PicWidgetState extends State<PicWidget> {
  late bool isGenerated;
  late String description;
  late String textButton;

  @override
  initState() {
    super.initState();
    isGenerated = false;
    description = '';
    textButton = 'Generate description';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.black,
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 0,
                child: Hero(
                  tag: 'MyHero${widget._publicationItem.id}',
                  child: Image.network(
                    widget._publicationItem.url ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-22T15%3A47%3A36.888Z',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                top: 16.0,
                left: 16.0,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black.withOpacity(0.25)),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.white,
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              !isGenerated
                  ? Positioned(
                      bottom: 150.0,
                      right: 8,
                      child: Reactions(
                        publication_id: widget._publication.id,
                        vertical: true,
                      ),
                    )
                  : const SizedBox.shrink(),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppColors.black.withOpacity(0.5),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !isGenerated
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(widget._user.profile_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-22T15%3A47%3A36.888Z'),
                                radius: 24.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(widget._user.pseudo ?? (widget._user.name ?? '[user_pseudo]').split(" ").join("").toLowerCase(), style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: AppColors.white)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text('${context.read<FeedService>().getDuration(widget._publication.date_of_publication)?.toString()} ago', style: Theme.of(context).primaryTextTheme.labelMedium!.copyWith(color: AppColors.white)),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    !isGenerated
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 48,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 56.0),
                              child: Text(widget._publicationItem.content ?? '[publication_content]', style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(color: AppColors.white), overflow: TextOverflow.ellipsis, maxLines: 3),
                            ),
                          )
                        : const SizedBox.shrink(),
                    isGenerated
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 114,
                            child: description.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                    child: Skeletonizer(
                                      child: Text(lorem(), style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: AppColors.white), overflow: TextOverflow.ellipsis, maxLines: 6),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(description, style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(color: AppColors.white), overflow: TextOverflow.ellipsis, maxLines: 6),
                                  ),
                          )
                        : const SizedBox.shrink(),
                    const Gap(8),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(AppColors.white),
                          backgroundColor: MaterialStateProperty.all(AppColors.primary),
                        ),
                        onPressed: () async {
                          if (!isGenerated) {
                            setState(() {
                              isGenerated = true;
                              textButton = 'Back';
                            });
                            String newDescription = await context.read<VisionService>().generateDescription(widget._publicationItem.url ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-22T15%3A47%3A36.888Z');
                            setState(() {
                              description = newDescription;
                            });
                          } else {
                            setState(() {
                              description = '';
                              isGenerated = false;
                              textButton = 'Generate description';
                            });
                          }
                        },
                        child: Text(textButton),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
