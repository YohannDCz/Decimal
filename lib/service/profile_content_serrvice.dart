import 'dart:io';

import 'package:decimal/config/constants.dart';
import 'package:decimal/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ProfileContentService {
  // CRUD pour le profil utlisateur
  Future<CustomUser> getProfile() async {
    try {
      final response = await supabaseClient.from('user').select().eq('id', supabaseUser!.id).single();
      final CustomUser user = CustomUser.fromMap(response);
      return user;
    } catch (e) {
      throw Exception('Unable to get profile: $e');
    }
  }

  Future<void> updateProfile(CustomUser user) async {
    try {
      var userToInsert = {
        'id': supabaseUser!.id,
        'profile_picture': user.profile_picture,
        'cover_picture': user.cover_picture,
        'name': user.name,
        'pseudo': user.pseudo,
      };
      await supabaseClient.from('user').upsert([userToInsert]);
    } catch (e) {
      throw Exception('Unable to update profile: $e');
    }
  }

  Future<void> deleteProfile() async {
    try {
      await supabaseClient.from('user').delete().eq('id', supabaseUser!.id);
    } catch (e) {
      throw Exception('Unable to delete profile: $e');
    }
  }
  //#####################################################################

  // Fonction pour la gestion des images sur l'appareil de l'utilisateur
  Future<String> uploadPicture() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      const uuid = Uuid();

      if (image != null) {
        final imageBytes = await image.readAsBytes();
        final uuidString = uuid.v4();
        final imagePath = 'profile/$uuidString.png';
        await supabaseClient.storage.from('profiles').uploadBinary(
              imagePath,
              imageBytes,
              fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
            );

        final imageUrl = supabaseClient.storage.from('profiles').getPublicUrl(imagePath);
        return imageUrl;
      } else {
        throw Exception('No image selected');
      }
    } catch (e) {
      throw Exception('Unable to upload picture on the device: $e');
    }
  }
}
