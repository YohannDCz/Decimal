import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

SupabaseClient supabaseClient = Supabase.instance.client;
GoTrueClient supabaseAuth = Supabase.instance.client.auth;
User? supabaseUser = Supabase.instance.client.auth.currentUser;
Session? supabaseSession = Supabase.instance.client.auth.currentSession;

ValueNotifier<Session?> sessionNotifier = ValueNotifier<Session?>(supabaseSession);