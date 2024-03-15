import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';

class ProfileDescription extends StatelessWidget {
  const ProfileDescription({
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
                    image: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/cover_picture.png?t=2023-11-19T17%3A13%3A21.274Z'),
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
                      image: NetworkImage('https://hxlaujiaybgubdzzkoxu.supabase.co/storage/v1/object/public/Assets/image/amanda_wilson/amanda1.png'),
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
              Text('Amanda Wilson', style: Theme.of(context).primaryTextTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
              height4,
              Text.rich(
                TextSpan(
                  text: '@',
                  style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText),
                  children: [
                    TextSpan(text: 'Amanda Wilson'.toLowerCase().replaceAll(' ', '_'), style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
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
                      Text('12', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Contacts', style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                      Text('12', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Following', style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(fontWeight: FontWeight.bold)),
                      Text('12', style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(color: AppColors.secondaryText)),
                    ],
                  ),
                ],
              ),
              height16,
              Padding(
                padding: const EdgeInsets.only(top: 6.0, right: 12.0, bottom: 16.0, left: 12.0),
                child: Text('Amanda Wilson is a professional photographer based in New York City. She specializes in portrait and fashion photography.', style: Theme.of(context).primaryTextTheme.bodyMedium),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
