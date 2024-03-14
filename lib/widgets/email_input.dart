import 'package:flutter/material.dart';

import '../config/theme.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key, required this.hint, required this.controller});

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.0,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: const Padding(
            padding: EdgeInsets.only(left: 20.0, right: 16.0),
            child: Icon(Icons.email),
          ),
          prefixIconColor: AppColors.secondaryText,
          hintText: hint,
          hintStyle: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(color: AppColors.secondaryText),
          filled: true,
          fillColor: AppColors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(99.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.all(4.0),
        ),
      ),
    );
  }
}
