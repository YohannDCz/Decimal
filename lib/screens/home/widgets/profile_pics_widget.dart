import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';

class ProfilePicsWidget extends StatelessWidget {
  const ProfilePicsWidget({super.key, required String url}) : _url = url;

  final String _url;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SizedBox(
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
                  tag: 'MyHero$_url',
                  child: Image.network(
                    _url,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
