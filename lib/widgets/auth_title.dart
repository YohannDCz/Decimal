import 'package:flutter/material.dart';

import '../utils/theme.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(label, style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600, color: AppColors.white)),
      ),
    );
  }
}
