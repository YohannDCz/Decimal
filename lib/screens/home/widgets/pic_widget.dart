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
  String? _description;
  bool _isGenerating = false;
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
                    backgroundColor: WidgetStateProperty.all(Colors.black.withOpacity(0.25)),
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
              Positioned(
                bottom: 150.0,
                right: 8,
                child: Reactions(
                  publication_id: widget._publication.id!,
                  vertical: true,
                ),
              ),
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
                left: 8,
                child: !_isGenerating
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 56.0),
                              child: Text(widget._publicationItem.content ?? '[publication_content]', style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(color: AppColors.white), overflow: TextOverflow.ellipsis, maxLines: 3),
                            ),
                          ),
                        ],
                      )
                    : Skeletonizer(
                        enabled: _description == null || _description!.isEmpty,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 56.0),
                            child: Text(_description ?? lorem(), style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(color: AppColors.white), overflow: TextOverflow.ellipsis, maxLines: 3),
                          ),
                        ),
                      ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_isGenerating) {
                      setState(() {
                        _description = null;
                        _isGenerating = false;
                      });
                    } else {
                      setState(() {
                        _isGenerating = true;
                      });
                      var description = await context.read<VisionService>().generateDescription(widget._publicationItem.url!);
                      setState(() {
                        _description = description;
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                  ),
                  child: Text(!_isGenerating ? 'Generate description' : "Back to description", style: TextStyle(color: AppColors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
