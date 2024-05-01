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

  Future createTableEntry() async {
    if (supabaseAuth.currentSession != null) {
      var userToInsert = {
        'uuid': supabaseUser!.id,
        'email': supabaseUser!.email,
      };
      // Perform the insert query
      try {
        var response = await supabaseClient.from('users').upsert([userToInsert]);
        return response;
      } catch (e) {
        debugPrint("Erreur lors de la création de l'entrée dans la table : $e");
        throw "Erreur lors de la création de l'entrée dans la table : $e";
      }
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
      await supabaseAuth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken!,
        nonce: rawNonce,
      );
    } catch (e) {
      throw 'Erreur lors de la connexion avec Google : $e';
    }
  }

  Future signInWithFacebook() async {
    try {
      await supabaseAuth.signInWithOAuth(
        redirectTo: 'https://hxlaujiaybgubdzzkoxu.supabase.co/auth/v1/callback',
        OAuthProvider.facebook,
      );
    } catch (e) {
      throw "Erreur lors de la connexion avec Facebook : $e";
    }
  }

  Future signInWithTwitter() async {
    try {
      await supabaseAuth.signInWithOAuth(
        redirectTo: 'https://hxlaujiaybgubdzzkoxu.supabase.co/auth/v1/callback',
        OAuthProvider.twitter,
      );
    } catch (e) {
      throw "Erreur lors de la connexion avec Twitter : $e";
    }
  }

  Future<bool> getUser() async {
    if (supabaseUser?.id == null) {
      return false;
    }

    try {
      await supabaseClient.from('users').select().eq('uuid', supabaseUser!.id).single();
      return true;
    } catch (e) {
      return false;
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
