import 'package:decimal/bloc/bloc/profile_bloc.dart';
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
                        Navigator.of(context).pushNamed('/profile_pics_widget', arguments: user?.cover_picture);
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
                          Navigator.of(context).pushNamed('/profile_pics_widget', arguments: user?.profile_picture);
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
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24.0), bottomRight: Radius.circular(24.0)),
                ),
                child: Column(
                  children: [
                    const Gap(8),
                    Text(user?.name ?? '[user_name]', style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
                    const Gap(4),
                    Text.rich(
                      TextSpan(
                        text: '@',
                        style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText),
                        children: [
                          TextSpan(text: user?.pseudo ?? (user?.name ?? '[user_pseudo]').toLowerCase().replaceAll(' ', ''), style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                        ],
                      ),
                    ),
                    const Gap(16),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, right: 12.0, bottom: 16.0, left: 12.0),
                      child: Text(user?.biography ?? '[user_biography]', style: Theme.of(context).primaryTextTheme.bodyMedium),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
