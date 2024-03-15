import 'package:flutter/material.dart';

class DividerSignIn extends StatelessWidget {
  const DividerSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 275.0,
      child: Divider(
        height: 16.0,
        color: Colors.white,
      ),
    );
  }
}
