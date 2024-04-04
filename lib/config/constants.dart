import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Getter pour supabaseClient
SupabaseClient get supabaseClient => Supabase.instance.client;

// Getter pour supabaseAuth
GoTrueClient get supabaseAuth => Supabase.instance.client.auth;

// Getter pour supabaseUser
User? get supabaseUser => Supabase.instance.client.auth.currentUser;

// Getter pour supabaseSession
Session? get supabaseSession => Supabase.instance.client.auth.currentSession;
