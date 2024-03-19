import 'package:decimal/bloc/profile_content/profile_content_bloc.dart';
import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ProfileForm extends StatelessWidget {
  ProfileForm({
    super.key,
    this.profilePictureUrl,
    this.coverPictureUrl,
    this.firstNameController,
    this.lastNameController,
    this.pseudoController,
  });

  String? profilePictureUrl;
  String? coverPictureUrl;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? pseudoController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                    child: Text(
                      'Profile picture',
                      style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<ProfileContentBloc>(context).add(UploadProfilePicture());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99.0),
                      ),
                    ),
                    child: Text(
                      'Upload profile picture',
                      style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                    child: Text(
                      'Cover picture',
                      style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<ProfileContentBloc>(context).add(UploadCoverPicture());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tertiary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(99.0),
                      ),
                    ),
                    child: Text(
                      'Upload cover picture',
                      style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                    child: Text(
                      'First and last name',
                      style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: firstNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(99.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                            hintText: 'John',
                            hintStyle: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: AppColors.secondaryText),
                          ),
                        ),
                      ),
                      width8,
                      Flexible(
                        child: TextFormField(
                          controller: lastNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(99.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                            hintText: 'Doe',
                            hintStyle: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: AppColors.secondaryText),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                    child: Text(
                      'Pseudo',
                      style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: pseudoController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(99.0),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
                            hintText: 'johndoe',
                            hintStyle: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: AppColors.secondaryText),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
