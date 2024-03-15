import 'dart:convert';

import 'package:decimal/config/constants.dart';

class AppUser {
  AppUser({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class CustomUser {
  CustomUser({
    this.id,
    this.profile_picture,
    this.cover_picture,
    required this.name,
    required this.pseudo,
  });

  final String? id;
  final String? profile_picture;
  final String? cover_picture;
  final String name;
  final String pseudo;

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    return CustomUser(
      id: map["id"] != null ? map['id'] as String : "",
      profile_picture: map['profile_picture'] != null ? map['profile_picture'] as String : "",
      cover_picture: map['cover_picture'] != null ? map['cover_picture'] as String : "",
      name: map["name"] != null ? map['name'] as String : "",
      pseudo: map['pseudo'] != null ? map['pseudo'] as String : "",
    );
  }

  factory CustomUser.fromJson(String source) => CustomUser.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': supabaseUser!.id,
      'profile_picture': profile_picture,
      'cover_picture': cover_picture,
      'name': name,
      'pseudo': pseudo,
    };
  }

  String toJson() => json.encode(toMap());

  CustomUser copyWith({
    String? id,
    String? profile_picture,
    String? cover_picture,
    String? name,
    String? pseudo,
  }) {
    return CustomUser(
      id: id ?? this.id,
      profile_picture: profile_picture ?? this.profile_picture,
      cover_picture: cover_picture ?? this.cover_picture,
      name: name ?? this.name,
      pseudo: pseudo ?? this.pseudo,
    );
  }
}
