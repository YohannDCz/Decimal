import 'package:decimal/bloc/profile_content/profile_content_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileDescription extends StatefulWidget {
  const ProfileDescription({
    super.key,
  });

  @override
  State<ProfileDescription> createState() => _ProfileDescriptionState();
}

class _ProfileDescriptionState extends State<ProfileDescription> {
  late CustomUser? user;

  @override
  initState() {
    super.initState();
    // BlocProvider.of<ProfileContentBloc>(context).add(GetProfile());
    // BlocProvider.of<ProfileContentBloc>(context).add(GetContacts());
    // BlocProvider.of<ProfileContentBloc>(context).add(GetFollowers());
    // BlocProvider.of<ProfileContentBloc>(context).add(GetFollowings());
    user = const CustomUser(
      id: '1',
      name: '[user_name]',
      pseudo: '[user_pseudo]',
      profile_picture: '[https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z',
      cover_picture: 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z',
      biography: '[user_biography]',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileContentBloc, ProfileContentState>(
      listener: (context, state) {
        if (state is ProfileContentSuccess) {
          setState(() {
            user = state.user;
          });
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 276.0,
              child: Stack(
                children: [
                  Container(
                    height: 276.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(user?.cover_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration:  BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2.0)),
                        image: DecorationImage(
                          image: NetworkImage(user?.profile_picture ?? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.png?t=2024-03-21T09%3A42%3A52.755Z'),
                          fit: BoxFit.cover,
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
                  height8,
                  Text(user?.name ?? '[user_name]', style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
                  height4,
                  Text.rich(
                    TextSpan(
                      text: '@',
                      style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText),
                      children: [
                        TextSpan(text: user?.pseudo ?? (user?.name ?? 'John Doe').toLowerCase().replaceAll(' ', ''), style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                      ],
                    ),
                  ),
                  height16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text('Posts', style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                          Text('12', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Followers', style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                          Text(user?.followers?.length.toString() ?? '[num]', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Contacts', style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                          Text(user?.contacts?.length.toString() ?? '[num]', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                        ],
                      ),
                      Column(
                        children: [
                          Text('Following', style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                          Text(user?.followings?.length.toString() ?? '[num]', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                        ],
                      ),
                    ],
                  ),
                  height16,
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, right: 12.0, bottom: 16.0, left: 12.0),
                    child: Text(user?.biography ?? '[user_biography]', style: Theme.of(context).primaryTextTheme.bodyMedium),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
