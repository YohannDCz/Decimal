import 'package:decimal/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  try {
    // await dotenv.load();
    await Supabase.initialize(
      url: "https://hxlaujiaybgubdzzkoxu.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imh4bGF1amlheWJndWJkenprb3h1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTc3MDgxMzksImV4cCI6MjAxMzI4NDEzOX0.il1HcIVUBZvy66iyBfcsWAwf5HNp7ly5F4KVnZKd8AQ",
      debug: true,
    );
  } catch (e) {
    rethrow;
  }
  runApp(const DecimalApp());
}
