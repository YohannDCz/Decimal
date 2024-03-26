import 'package:decimal/bloc/profile/profile_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/publication_items_model.dart';
import 'package:decimal/models/publication_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfilePics extends StatefulWidget {
  const ProfilePics({
    super.key,
  });

  @override
  State<ProfilePics> createState() => _ProfilePicsState();
}

class _ProfilePicsState extends State<ProfilePics> {
  late List<PublicationModel> publications;
  late List<PublicationItemModel> pics;

  @override
  initState() {
    super.initState();
    publications = [];
    pics = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is FetchProfileSuccess) {
          setState(
            () {
              publications = state.fetchPicsSuccess['publications'];
              pics = state.fetchPicsSuccess['pics'];
            },
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Skeletonizer(
            enabled: pics.isEmpty,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text('Pics', style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0)),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                      ),
                      shrinkWrap: true,
                      itemCount: pics.isNotEmpty ? pics.length : 6,
                      itemBuilder: (context, index) {
                        if (index < pics.length) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed('/pic_widget', arguments: {'publication': publications[index], 'publicationItem': pics[index]});
                            },
                            child: Image.network(pics[index].url ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z', fit: BoxFit.cover),
                          );
                        } else {
                          return Image.asset('assets/images/white_background.png', fit: BoxFit.cover); // Image placeholder
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
