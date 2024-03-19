// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:decimal/config/constants.dart';
import 'package:equatable/equatable.dart';

class PublicationModel extends Equatable {
  const PublicationModel({
    required this.id,
    required this.type,
    required this.date_of_publication,
    required this.location,
    required this.user_uuid,
  });

  final int id;
  final String type;
  final DateTime date_of_publication;
  final String location;
  final String user_uuid;

  factory PublicationModel.fromMap(Map<String, dynamic> map) {
    return PublicationModel(
      id: map["id"] != null ? map['id'] as int : 0,
      type: map['type'] != null ? map['type'] as String : "",
      date_of_publication: map['date_of_publication'] != null ? DateTime.parse(map['date_of_publication'] as String) : DateTime.now(),
      location: map["location"] != null ? map['location'] as String : "",
      user_uuid: map['user_uuid'] != null ? map['user_uuid'] as String : "",
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
    };
  }

  String toJson() => json.encode(toMap());

  PublicationModel copyWith({
    int? id,
    String? type,
    DateTime? date_of_publication,
    String? location,
    String? user_uuid,
  }) {
    return PublicationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      date_of_publication: date_of_publication ?? this.date_of_publication,
      location: location ?? this.location,
      user_uuid: user_uuid ?? this.user_uuid,
    );
  }

  @override
  List<Object?> get props => [id, type, date_of_publication, location, user_uuid];
}
