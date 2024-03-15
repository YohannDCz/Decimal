import 'package:decimal/config/theme.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
    required this.onPressed,
  });
  
  final VoidCallback onPressed;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
            },
            child: Text(
              'Pass',
              style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: AppColors.white, decoration: TextDecoration.underline),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(99.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Continue',
                style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: AppColors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
