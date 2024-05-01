import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.coverPictureUrl,
    this.profilePictureUrl,
    this.name,
    this.pseudo,
  });

  final String? coverPictureUrl;
  final String? profilePictureUrl;
  final String? name;
  final String? pseudo;

  @override
  Widget build(BuildContext context) {
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
                    image: NetworkImage(coverPictureUrl != null
                        ? coverPictureUrl!.isEmpty
                            ? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/cover_placeholder.jpeg?t=2024-03-15T09%3A44%3A56.150Z'
                            : coverPictureUrl!
                        : 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/cover_placeholder.jpeg?t=2024-03-15T09%3A44%3A56.150Z'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    border: const Border.fromBorderSide(BorderSide(color: Colors.white, width: 2.0)),
                    image: DecorationImage(
                      image: NetworkImage(profilePictureUrl != null
                          ? profilePictureUrl!.isEmpty
                              ? 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.dart.jpeg?t=2024-03-15T09%3A45%3A10.012Z'
                              : profilePictureUrl!
                          : 'https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.dart.jpeg?t=2024-03-15T09%3A45%3A10.012Z'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(name ?? '', style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(color: AppColors.white)),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: pseudo != null ? '@' : "", style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(color: AppColors.white)),
              TextSpan(text: pseudo ?? 'johndoe', style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(color: AppColors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
