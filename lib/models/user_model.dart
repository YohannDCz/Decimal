// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:decimal/config/constants.dart';
import 'package:equatable/equatable.dart';

class AppUser {
  AppUser({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class CustomUser extends Equatable {
  const CustomUser({required this.id, this.profile_picture, this.cover_picture, this.name, this.pseudo, this.biography, this.contacts, this.followers, this.followings});

  final String id;
  final String? profile_picture;
  final String? cover_picture;
  final String? name;
  final String? pseudo;
  final String? biography;
  final List<CustomUser>? contacts;
  final List<CustomUser>? followers;
  final List<CustomUser>? followings;

  factory CustomUser.fromMap(Map<String, dynamic> map) {
    return CustomUser(
      id: map["uuid"] != null ? map['uuid'] as String : "",
      profile_picture: map['profile_picture'] != null ? map['profile_picture'] as String : "",
      cover_picture: map['cover_picture'] != null ? map['cover_picture'] as String : "",
      name: map["name"] != null ? map['name'] as String : "",
      pseudo: map['pseudo'] != null ? map['pseudo'] as String : null,
      biography: map['biography'] != null ? map['biography'] as String : null,
      contacts: map['contacts'] != null ? (map['contacts'] as List).map((e) => CustomUser.fromMap(e as Map<String, dynamic>)).toList() : null,
      followers: map['followers'] != null ? (map['followers'] as List).map((e) => CustomUser.fromMap(e as Map<String, dynamic>)).toList() : null,
      followings: map['followings'] != null ? (map['followings'] as List).map((e) => CustomUser.fromMap(e as Map<String, dynamic>)).toList() : null,
    );
  }

  factory CustomUser.fromJson(String source) => CustomUser.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': supabaseUser!.id,
      'profile_picture': profile_picture,
      'cover_picture': cover_picture,
      'name': name,
      'pseudo': pseudo,
      'biography': biography,
      'contacts': contacts?.map((e) => e.toMap()).toList(),
      'followers': followers?.map((e) => e.toMap()).toList(),
      'followings': followings?.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  CustomUser copyWith({String? id, String? profile_picture, String? cover_picture, String? name, String? pseudo, String? biography, List<CustomUser>? contacts, List<CustomUser>? followers, List<CustomUser>? followings}) {
    return CustomUser(
      id: id ?? this.id,
      profile_picture: profile_picture ?? this.profile_picture,
      cover_picture: cover_picture ?? this.cover_picture,
      name: name ?? this.name,
      pseudo: pseudo ?? this.pseudo,
      biography: biography ?? this.biography,
      contacts: contacts ?? this.contacts,
      followers: followers ?? this.followers,
      followings: followings ?? this.followings,
    );
  }

  @override
  List<Object?> get props => [id, profile_picture, cover_picture, name, pseudo, biography, contacts, followers, followings];
}
