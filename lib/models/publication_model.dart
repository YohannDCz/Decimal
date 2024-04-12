// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:decimal/config/constants.dart';
import 'package:equatable/equatable.dart';

class PublicationModel extends Equatable {
  const PublicationModel({
    this.id,
    required this.type,
    this.date_of_publication,
    this.location,
    this.user_uuid,
    this.user_uuid_original_publication,
    required this.is_repost,
  });

  final int? id;
  final String type;
  final DateTime? date_of_publication;
  final String? location;
  final String? user_uuid;
  final String? user_uuid_original_publication;
  final bool is_repost;

  factory PublicationModel.fromMap(Map<String, dynamic> map) {
    return PublicationModel(
      id: map["id"] != null ? map['id'] as int : 0,
      type: map['type'] != null ? map['type'] as String : "",
      date_of_publication: map['date_of_publication'] != null ? DateTime.parse(map['date_of_publication'] as String) : DateTime(2029),
      location: map["location"] != null ? map['location'] as String : "",
      user_uuid: map['user_uuid'] != null ? map['user_uuid'] as String : "",
      user_uuid_original_publication: map['user_uuid_original_publication'] != null ? map['user_uuid_original_publication'] as String : null,
      is_repost: map['is_repost'] != null ? map['is_repost'] as bool : false,
    );
  }

  factory PublicationModel.fromJson(String source) => PublicationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': supabaseUser!.id,
      'type': type,
      'date_of_publication': date_of_publication,
      'location': location,
      'user_uuid': user_uuid,
      'user_uuid_original_publication': user_uuid_original_publication,
      'is_repost': is_repost,
    };
  }

  String toJson() => json.encode(toMap());

  PublicationModel copyWith({
    int? id,
    String? type,
    DateTime? date_of_publication,
    String? location,
    String? user_uuid,
    String? user_uuid_original_publication,
    bool? is_repost,
  }) {
    return PublicationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      date_of_publication: date_of_publication ?? this.date_of_publication,
      location: location ?? this.location,
      user_uuid: user_uuid ?? this.user_uuid,
      user_uuid_original_publication: user_uuid_original_publication ?? this.user_uuid_original_publication,
      is_repost: is_repost ?? this.is_repost,
    );
  }

  @override
  List<Object?> get props => [id, type, date_of_publication, location, user_uuid, user_uuid_original_publication, is_repost];
}
