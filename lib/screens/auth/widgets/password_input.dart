import 'package:flutter/material.dart';

import '../../../config/theme.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key, required this.hint, required this.controller});

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    bool visible = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return SizedBox(
          width: 280.0,
          child: TextFormField(
            controller: controller,
            obscureText: !visible,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(left: 20.0, right: 16.0),
                child: Icon(Icons.lock),
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
              suffixIcon: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 12.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      visible = !visible;
                    });
                  },
                  icon: visible
                      ? const Icon(Icons.visibility)
                      : const Icon(
                          Icons.visibility_off,
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
