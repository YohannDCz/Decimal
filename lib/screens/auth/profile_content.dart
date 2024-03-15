import 'package:decimal/config/theme.dart';
import 'package:decimal/screens/auth/widgets/buttons.dart';
import 'package:decimal/screens/auth/widgets/profile_form.dart';
import 'package:decimal/screens/auth/widgets/profile_header.dart';
import 'package:flutter/material.dart';

class ProfileContent1 extends StatefulWidget {
  const ProfileContent1({super.key});

  @override
  State<ProfileContent1> createState() => _ProfileContent1State();
}

class _ProfileContent1State extends State<ProfileContent1> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final pseudoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.gradient),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const ProfileHeader(),
              ProfileForm(firstNameController: firstNameController, lastNameController: lastNameController, pseudoController: pseudoController),
              const Buttons(),
              height4,
            ],
          ),
        ),
      ),
    );
  }
}