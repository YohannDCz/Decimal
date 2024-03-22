import 'dart:io';

import 'package:decimal/config/constants.dart';
import 'package:decimal/models/contact_model.dart';
import 'package:decimal/models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class ProfileContentService {
  // CRUD pour le profil utlisateur
  Future<CustomUser> getProfile() async {
    try {
      final response = await supabaseClient.from('users').select().eq('uuid', supabaseUser!.id).single();
      final CustomUser user = CustomUser.fromMap(response);
      print('User: $user');
      return user;
    } catch (e) {
      print('Unable to get profile: $e');
      throw Exception('Unable to get profile: $e');
    }
  }

  Future<void> updateProfile(CustomUser user) async {
    try {
      var userToInsert = {
        'uuid': supabaseUser!.id,
        'email': supabaseUser!.email,
        'profile_picture': user.profile_picture,
        'cover_picture': user.cover_picture,
        'name': user.name,
        'pseudo': user.pseudo,
        'biography': user.biography,
      };
      await supabaseClient.from('users').upsert([userToInsert]);
    } catch (e) {
      print('Unable to update profile: $e');
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

  Future<XFile?> selectImage() async {
    final XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile;
    }
    return null;
  }

  Future<String> uploadPicture(String type, XFile image) async {
    try {
      final imageBytes = await image.readAsBytes();

      const uuid = Uuid();
      final uuidString = uuid.v4();
      final imagePath = '$uuidString.png';

      await supabaseClient.storage.from('Assets/image/other_user/$type').uploadBinary(
            imagePath,
            imageBytes,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      final imageUrl = supabaseClient.storage.from('Assets/image/other_user/$type').getPublicUrl(imagePath);
      return imageUrl;
    } catch (e) {
      throw Exception('Unable to read the image as bytes: $e');
    }
  }
}
