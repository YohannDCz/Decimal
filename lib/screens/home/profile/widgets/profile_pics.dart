import 'package:decimal/bloc/bloc/profile_bloc.dart';
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
  late List<PublicationModel>? publications;
  late List<PublicationItemModel>? pics;

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
          setState(() {
            publications = state.fetchPicsSuccess['publications'];
            pics = state.fetchPicsSuccess['pics'];
          });
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: AppColors.white,
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text('Pics'),
                ),
                ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0)),
                    child: Skeletonizer(
                      enabled: pics!.isEmpty,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0,
                        ),
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          if (pics != null && index < pics!.length) {
                            return Image.network(pics![index].url ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z', fit: BoxFit.cover);
                          } else {
                            return Image.network('https://www.referenseo.com/wp-content/uploads/2019/03/image-attractive-960x540.jpg', fit: BoxFit.cover); // Image placeholder
                          }
                        },
                      ),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
