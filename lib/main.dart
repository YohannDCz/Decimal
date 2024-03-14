import 'package:decimal/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  try {
    await dotenv.load();
    await Supabase.initialize(
      url: dotenv.env["API_URL"]!,
      anonKey: dotenv.env["API_KEY"]!,
      debug: true,
    );
  } catch (e) {
    rethrow;
  }
  runApp(const DecimalApp());
}
