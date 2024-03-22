// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:decimal/config/constants.dart';
import 'package:equatable/equatable.dart';

class CommentModel extends Equatable {
  const CommentModel({
    required this.id,
    required this.publication_id,
    required this.user_uuid,
    required this.content,
    required this.date_of_comment,
  });

  final int id;
  final int publication_id;
  final String user_uuid;
  final String content;
  final DateTime date_of_comment;

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      id: map["id"] != null ? map['id'] as int : 0,
      publication_id: map["publication_id"] != null ? map['publication_id'] as int : 0,
      user_uuid: map['user_uuid'] != null ? map['user_uuid'] as String : "",
      content: map["content"] != null ? map['content'] as String : "",
      date_of_comment: map['date_of_comment'] != null ? DateTime.parse(map['date_of_comment'].toString()) : DateTime.now(),
    );
  }

  factory CommentModel.fromJson(String source) => CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': supabaseUser!.id,
      'publication_id': publication_id,
      'user_uuid': user_uuid,
      'content': content,
      'date_of_comment': date_of_comment,
    };
  }

  String toJson() => json.encode(toMap());

  CommentModel copyWith({
    int? id,
    int? publication_id,
    String? user_uuid,
    String? content,
    DateTime? date_of_comment,
  }) {
    return CommentModel(
      id: id ?? this.id,
      publication_id: publication_id ?? this.publication_id,
      user_uuid: user_uuid ?? this.user_uuid,
      content: content ?? this.content,
      date_of_comment: date_of_comment ?? this.date_of_comment,
    );
  }

  @override
  List<Object?> get props => [id, publication_id, user_uuid, content, date_of_comment];
}
