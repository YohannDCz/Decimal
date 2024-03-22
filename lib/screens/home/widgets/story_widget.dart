import 'package:flutter/material.dart';

class StoryWidget extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const StoryWidget({super.key, required String publication_id}) : _publication_id = publication_id;

  final String _publication_id;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}