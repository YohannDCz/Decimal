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
  });

  final int id;
  final int publication_id;
  final String user_uuid;
  final DateTime date_of_reaction;

  factory ReactionModel.fromMap(Map<String, dynamic> map) {
    return ReactionModel(
      id: map["id"] != null ? map['id'] as int : 0,
      publication_id: map["publication_id"] != null ? map['publication_id'] as int : 0,
      user_uuid: map['user_uuid'] != null ? map['user_uuid'] as String : "",
      date_of_reaction: map['date_of_reaction'] != null ? DateTime.parse(map['date_of_reaction'].toString()) : DateTime.now(),
    );
  }

  factory ReactionModel.fromJson(String source) => ReactionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': supabaseUser!.id,
      'publication_id': publication_id,
      'user_uuid': user_uuid,
      'date_of_reaction': date_of_reaction,
    };
  }

  String toJson() => json.encode(toMap());

  ReactionModel copyWith({
    int? id,
    int? publication_id,
    String? user_uuid,
    String? content,
    DateTime? date_of_reaction,
  }) {
    return ReactionModel(
      id: id ?? this.id,
      publication_id: publication_id ?? this.publication_id,
      user_uuid: user_uuid ?? this.user_uuid,
      date_of_reaction: date_of_reaction ?? this.date_of_reaction,
    );
  }

  @override
  List<Object?> get props => [id, publication_id, user_uuid, date_of_reaction];
}
