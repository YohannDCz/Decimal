// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:decimal/config/constants.dart';
import 'package:decimal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationService {
  AuthenticationService({required SupabaseClient supabaseClient})
      : supabase = supabaseClient,
        supabaseAuth = supabaseClient.auth,
        supabaseUser = supabaseClient.auth.currentUser;

  late final SupabaseClient supabase;
  late final GoTrueClient supabaseAuth;
  late final User? supabaseUser;

  Future createTableEntry(email) async {
    if (supabaseAuth.currentSession != null) {
      var userToInsert = {
        'uiid': supabaseUser!.id,
        'email': email,
      };
      // Perform the insert query
      var response = await supabaseClient.from('users').upsert([userToInsert]);
      print(response);
      return response;
    }
    return null;
  }

  Future signInWithEmail(AppUser user) async {
    try {
      await supabase.auth.signInWithPassword(
        email: user.email,
        password: user.password,
      );
    } catch (e) {
      throw "Erreur lors de la connexion avec email : $e";
    }
  }

  Future signUpWithEmail(AppUser user) async {
    try {
      await supabaseAuth.signUp(
        email: user.email,
        password: user.password,
      );
      await createTableEntry(user.email);
      return 'User signed up successfully';
    } catch (e) {
      throw "Erreur lors de l'inscription avec email : $e";
    }
  }

  Future logOut() async {
    try {
      await supabaseAuth.signOut();
      debugPrint("Utilisateur déconnecté");
    } catch (e) {
      throw "Erreur lors de la déconnexion : $e";
    }
  }

  Future signInWithGoogle() async {
    FlutterAppAuth appAuth = const FlutterAppAuth();

    /// Function to generate a random 16 character string.
    String generateRandomString() {
      var random = Random.secure();
      return base64Url.encode(List<int>.generate(16, (_) => random.nextInt(256)));
    }

    // Just a random string
    var rawNonce = generateRandomString();
    var hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
    late String clientId;

    // Set the client id based on the platform
    if (Platform.isAndroid) {
      clientId = "959308871265-7qc198u051dnipuoa4h5ij8l7t2k1hnk.apps.googleusercontent.com";
    } else {
      clientId = "959308871265-0lo4k01j3fd0rfpp7v4mumv84jirh0qf.apps.googleusercontent.com";
    }
    // Set the redirect url and the discovery url
    const applicationId = 'com.mycompany.decimal';
    const redirectUrl = '$applicationId:/google_auth';
    const discoveryUrl = 'https://accounts.google.com/.well-known/openid-configuration';

    late dynamic result;
    late String? idToken;
    late AuthResponse response;

    try {
      result = await appAuth.authorize(
        AuthorizationRequest(
          clientId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          scopes: ['openid', 'email'],
          loginHint: null,
          nonce: hashedNonce,
        ),
      );
    } catch (e) {
      throw 'Erreur lors de la connexion avec Google : $e';
    }

    // Request the access and id token to google
    try {
      var tokenResult = await appAuth.token(
        TokenRequest(
          clientId,
          redirectUrl,
          authorizationCode: result.authorizationCode,
          discoveryUrl: discoveryUrl,
          codeVerifier: result.codeVerifier,
          nonce: result.nonce,
          scopes: [
            'openid',
            'email',
          ],
        ),
      );

      idToken = tokenResult?.idToken;
    } catch (e) {
      throw 'Erreur lors de la récupération du token : $e';
    }

    try {
      response = await supabaseAuth.signInWithIdToken(
        provider: Provider.google,
        idToken: idToken!,
        nonce: rawNonce,
      );
    } catch (e) {
      throw 'Erreur lors de la connexion avec Google : $e';
    }

    try {
      if (supabaseUser != null) {
        await createTableEntry(response.user!.email);
      }
    } catch (e) {
      throw 'Erreur lors de l\'entrée de la table : $e';
    }
  }

  Future signInWithFacebook() async {
    try {
      await supabaseAuth.signInWithOAuth(
        redirectTo: 'https://hxlaujiaybgubdzzkoxu.supabase.co/auth/v1/callback',
        Provider.facebook,
      );
      await createTableEntry(supabaseUser!.email);
      debugPrint('Email de l\'utilisateur: ${supabaseUser!.email}');
    } catch (e) {
      throw "Erreur lors de la connexion avec Facebook : $e";
    }
  }

  Future signInWithTwitter() async {
    final response = await supabaseAuth.signInWithOAuth(
      redirectTo: 'https://hxlaujiaybgubdzzkoxu.supabase.co/auth/v1/callback',
      Provider.twitter,
    );

    if (response) {
      final user = supabaseUser;
      if (user != null) {
        // L'email peut être null si l'utilisateur n'a pas autorisé l'accès à son email
        final email = user.email;
        await createTableEntry(email);
        debugPrint('Email de l\'utilisateur: $email');
      } else {
        throw 'Erreur: Aucun utilisateur connecté';
      }
    } else {
      throw 'Erreur de connexion';
    }
  }

  Future<dynamic> getUser(BuildContext context) async {
    try {
      final response = await supabaseClient.from('user').select().eq('id', supabaseUser!.id).single();
      if (response.data != null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil('/profile_content', (route) => false);
      }
    } catch (e) {
      throw Exception('Unable to get profile: $e');
    }
  }

  Future deleteUser() async {
    var user = supabaseUser;
    var client = supabaseClient;
    try {
      await client.rpc('delete_user_account', params: {'user_id1': user!.id});
      debugPrint("Compte supprimé");
    } catch (e) {
      throw "Erreur lors de la suppression du compte : $e";
    }
  }
}
