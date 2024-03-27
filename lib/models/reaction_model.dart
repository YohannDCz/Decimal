// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:decimal/config/constants.dart';
import 'package:equatable/equatable.dart';

class ReactionModel extends Equatable {
  const ReactionModel({
    required this.id,
    required this.publication_id,
    required this.user_uuid,
    required this.date_of_reaction,
    this.content,
    this.publication_id_original
  });

  final int id;
  final int publication_id;
  final String user_uuid;
  final DateTime date_of_reaction;
  final String? content;
  final int? publication_id_original;

  factory ReactionModel.fromMap(Map<String, dynamic> map) {
    return ReactionModel(
      id: map["id"] != null ? map['id'] as int : 0,
      publication_id: map["publication_id"] != null ? map['publication_id'] as int : 0,
      user_uuid: map['user_uuid'] != null ? map['user_uuid'] as String : "",
      date_of_reaction: map['date_of_reaction'] != null ? DateTime.parse(map['date_of_reaction'].toString()) : DateTime.now(),
      content: map['content'] != null ? map['content'] as String : "",
      publication_id_original: map['publication_id_original'] != null ? map['publication_id_original'] as int : 0,
    );
  }

  factory ReactionModel.fromJson(String source) => ReactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': supabaseUser!.id,
      'publication_id': publication_id,
      'user_uuid': user_uuid,
      'date_of_reaction': date_of_reaction,
      'content': content,
      'publication_id_original': publication_id_original,
    };
  }

  String toJson() => json.encode(toMap());

  ReactionModel copyWith({
    int? id,
    int? publication_id,
    String? user_uuid,
    String? content,
    DateTime? date_of_reaction,
    int? publication_id_original,
  }) {
    return ReactionModel(
      id: id ?? this.id,
      publication_id: publication_id ?? this.publication_id,
      user_uuid: user_uuid ?? this.user_uuid,
      date_of_reaction: date_of_reaction ?? this.date_of_reaction,
      content: content ?? this.content,
      publication_id_original: publication_id_original ?? this.publication_id_original,
    );
  }

  @override
  List<Object?> get props => [id, publication_id, user_uuid, date_of_reaction, publication_id_original, content];
}
