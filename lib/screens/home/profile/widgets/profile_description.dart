import 'package:decimal/bloc/bloc/profile_bloc.dart';
import 'package:decimal/bloc/profile_content/profile_content_bloc.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileDescription extends StatefulWidget {
  const ProfileDescription({super.key});

  @override
  State<ProfileDescription> createState() => _ProfileDescriptionState();
}

class _ProfileDescriptionState extends State<ProfileDescription> {
  late CustomUser? user;
  late List<CustomUser>? contacts;
  late List<CustomUser>? followers;
  late List<CustomUser>? followings;

  bool isEditing = false;
  TextEditingController biographyController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController pseudoController = TextEditingController();

  @override
  initState() {
    super.initState();
    user = const CustomUser(
      id: "1",
    );
    contacts = [];
    followers = [];
    followings = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is FetchProfileSuccess) {
          setState(() {
            user = state.fetchDescriptionSuccess;
            contacts = state.fetchContactSuccess["contacts"];
            followers = state.fetchContactSuccess["followers"];
            followings = state.fetchContactSuccess["followings"];
            nameController.text = user?.name ?? '';
            pseudoController.text = user?.pseudo ?? '';
            biographyController.text = user?.biography ?? '';
          });
        }
      },
      builder: (context, state) {
        debugPrint('Followers: ${user?.followers?.length}');
        return Skeletonizer(
          enabled: user!.id == "1",
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 276.0,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/cover_pic_widget', arguments: user?.id);
                      },
                      child: Container(
                        height: 276.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(user?.cover_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/profile_pic_widget', arguments: user?.id);
                        },
                        child: Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                            border: const Border.fromBorderSide(BorderSide(color: Colors.white, width: 2.0)),
                            image: DecorationImage(
                              image: NetworkImage(user?.profile_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24.0), bottomRight: Radius.circular(24.0)),
                    ),
                    child: Column(
                      children: [
                        const Gap(8),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0, right: 12.0, bottom: 4.0, left: 12.0),
                          child: TextField(
                            readOnly: !isEditing,
                            controller: nameController,
                            style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            autofocus: true,
                            
                            decoration: InputDecoration(
                              isDense: true,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: user?.name != null
                                  ? user!.name!.isEmpty
                                      ? isEditing
                                          ? 'Add a name'
                                          : ''
                                      : ''
                                  : '',
                              hintStyle: Theme.of(context).primaryTextTheme.bodyMedium,
                            ),
                          ),
                        ),
                        TextField(
                          readOnly: !isEditing,
                          controller: pseudoController,
                          style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            isDense: true,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            hintText: user?.pseudo != null
                                ? user!.pseudo!.isEmpty
                                    ? isEditing
                                        ? 'Add a pseudo'
                                        : ''
                                    : ''
                                : '',
                            hintStyle: Theme.of(context).primaryTextTheme.bodyMedium,
                          ),
                        ),
                        const Gap(24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('Posts'.toUpperCase(), style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 9.0, fontWeight: FontWeight.bold)),
                                Text('0', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Followers'.toUpperCase(), style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 9.0, fontWeight: FontWeight.bold)),
                                Text(followers?.length.toString() ?? '0', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Contacts'.toUpperCase(), style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 9.0, fontWeight: FontWeight.bold)),
                                Text(contacts?.length.toString() ?? '0', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                              ],
                            ),
                            Column(
                              children: [
                                Text('Following'.toUpperCase(), style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontSize: 9.0, fontWeight: FontWeight.bold)),
                                Text(followings?.length.toString() ?? '0', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                              ],
                            ),
                          ],
                        ),
                        const Gap(16),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6.0, right: 12.0, bottom: 16.0, left: 12.0),
                            child: TextField(
                              readOnly: !isEditing,
                              controller: biographyController,
                              style: Theme.of(context).primaryTextTheme.bodyMedium,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: user?.biography != null
                                    ? user!.biography!.isEmpty
                                        ? isEditing
                                            ? 'Add a biography'
                                            : ''
                                        : ''
                                    : '',
                                hintStyle: Theme.of(context).primaryTextTheme.bodyMedium,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 8.0,
                    top: 8.0,
                    child: Material(
                      elevation: 4.0,
                      shape: const CircleBorder(),
                      clipBehavior: Clip.antiAlias,
                      color: AppColors.black,
                      child: CircleAvatar(
                        radius: 16.0,
                        backgroundColor: AppColors.white,
                        child: IconButton(
                          onPressed: () {
                            if (isEditing) {
                              BlocProvider.of<ProfileContentBloc>(context).add(UpdateProfile(CustomUser(id: supabaseUser!.id, name: nameController.text, pseudo: pseudoController.text, biography: biographyController.text)));
                            }
                            setState(() {
                              isEditing = !isEditing;
                            });
                          },
                          icon: const Icon(Icons.edit, size: 16),
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
