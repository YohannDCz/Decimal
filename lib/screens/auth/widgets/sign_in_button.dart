import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../config/theme.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({super.key, required this.icon, required this.label, required this.onPressed, this.padding});

  final IconData icon;
  final String label;
  final void Function() onPressed;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    var bodyMedium = Theme.of(context).primaryTextTheme.bodyLarge;

    return Container(
      margin: const EdgeInsets.all(8.0),
      width: 275.0,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding == null ? 16.0 : padding!),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                icon,
                color: AppColors.primaryText,
              ),
              const Gap(8),
              width8,
              Expanded(child: SizedBox(child: Text(label, style: bodyMedium))),
            ],
          ),
        ),
      ),
    );
  }
}
