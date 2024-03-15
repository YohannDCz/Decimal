import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

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
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/cover_placeholder.jpeg?t=2024-03-15T09%3A44%3A56.150Z'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    border: Border.fromBorderSide(BorderSide(color: Colors.white, width: 2.0)),
                    image: DecorationImage(
                      image: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/placeholders/profile_placeholder.dart.jpeg?t=2024-03-15T09%3A45%3A10.012Z'),
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
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'John', style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(color: AppColors.white)),
                TextSpan(text: ' ', style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(color: AppColors.white)),
                TextSpan(text: 'Doe', style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(color: AppColors.white)),
              ],
            ),
          ),
        ),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '@', style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(color: AppColors.white)),
              TextSpan(text: 'johndoe', style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(color: AppColors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
