import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppUser {
  AppUser({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class SupabaseInitialization {
  static final SupabaseClient supabase = Supabase.instance.client;
}

class SupabaseAuth {
  static final User? user = Supabase.instance.client.auth.currentUser;
}

class AuthenticationService {
  dynamic accessToken;

  Future emailAndPasswordLogin(AppUser user) async {
    await SupabaseInitialization.supabase.auth.signInWithPassword(
      email: user.email,
      password: user.password,
    );
  }

  Future logout() async {
    try {
      // Déconnectez-vous de Supabase
      await SupabaseInitialization.supabase.auth.signOut();
      debugPrint("Utilisateur déconnecté");
    } catch (e) {
      // Gérez les erreurs de déconnexion ici
      rethrow; // Vous pouvez gérer l'erreur ou la propager pour la gérer dans le bloc
    }
  }

  Future<AuthResponse> emailAndPasswordSignUp(AppUser user) async {
    AuthResponse authResponse = await SupabaseInitialization.supabase.auth.signUp(
      email: user.email,
      password: user.password,
    );
    if (authResponse.session != null) {
      // await createTableEntry();
    }
    return authResponse;
  }

  Future createTableEntry() async {
    if (SupabaseAuth.user != null) {
      var user = {
        'id': SupabaseAuth.user!.id,
        'total_scanned': 0,
        'total': 0,
        'barcode_scanned': 0,
        'recyclable_scanned': 0,
      };

      // Perform the insert query
      var response = await SupabaseInitialization.supabase.rest.from('users').upsert([user]);
      return response;
    }
    return null;
  }

  String _generateRandomString() {
    var random = Random.secure();
    return base64Url.encode(List<int>.generate(16, (_) => random.nextInt(256)));
  }

  Future googleLogin() async {
    FlutterAppAuth appAuth = const FlutterAppAuth();

    /// Function to generate a random 16 character string.

    // Just a random string
    var rawNonce = _generateRandomString();
    var hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();
    late String clientId;

    ///
    /// Client ID that you registered with Google Cloud.
    /// You will have two different values for iOS and Android.
    if (Platform.isAndroid) {
      clientId = "959308871265-7qc198u051dnipuoa4h5ij8l7t2k1hnk.apps.googleusercontent.com";
    } else if (Platform.isIOS) {
      clientId = "959308871265-0lo4k01j3fd0rfpp7v4mumv84jirh0qf.apps.googleusercontent.com";
    }
    const applicationId = 'com.mycompany.decimal';

    /// Fixed value for google login
    const redirectUrl = '$applicationId:/google_auth';

    /// Fixed value for google login
    const discoveryUrl = 'https://accounts.google.com/.well-known/openid-configuration';

    // authorize the user by opening the concent page
    var result = await appAuth.authorize(
      AuthorizationRequest(
        clientId,
        redirectUrl,
        discoveryUrl: discoveryUrl,
        nonce: hashedNonce,
        scopes: [
          'openid',
          'email',
        ],
      ),
    );

    if (result == null) {
      throw 'No result';
    }

    // Request the access and id token to google
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

    var idToken = tokenResult?.idToken;
    accessToken = tokenResult?.accessToken;
    if (idToken == null) {
      throw 'No idToken';
    }

    await SupabaseInitialization.supabase.auth.signInWithIdToken(
      provider: Provider.google,
      idToken: idToken,
      nonce: rawNonce,
    );
    if (SupabaseAuth.user != null) {
      // await createTableEntry();
    }
  }

  Future facebookLogin() async {
    await SupabaseInitialization.supabase.auth.signInWithOAuth(
      redirectTo: 'https://hxlaujiaybgubdzzkoxu.supabase.co/auth/v1/callback',
      Provider.facebook,
    );

    // await createTableEntry();
  }

  // Stream<AuthState> authChanges() {
  //   return SupabaseInitialization.supabase.auth.onAuthStateChange;
  // }

  // Future resetPassword(String email) async {
  //   await SupabaseInitialization.supabase.auth.resetPasswordForEmail(email);
  // }

  // Future updatePassword(String newPassword) async {
  //   await SupabaseInitialization.supabase.auth.updateUser(UserAttributes(password: newPassword));
  // }

  Future<void> deleteUser() async {
    var user = Supabase.instance.client.auth.currentUser;
    var client = Supabase.instance.client;
    try {
      await client.rpc('delete_user_account', params: {'user_id1': user!.id});
      debugPrint("Compte supprimé");
    } catch (e) {
      debugPrint("Erreur lors de la suppression du compte : $e");
    }
  }
}
