// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:decimal/config/constants.dart';
import 'package:equatable/equatable.dart';

class PublicationItemModel extends Equatable {
  const PublicationItemModel({
    this.id,
    this.publication_id,
    this.url,
    this.title,
    this.content,
    this.tags,
    this.duration,
  });

  final int? id;
  final int? publication_id;
  final String? url;
  final String? title;
  final String? content;
  final List<String>? tags;
  final int? duration;

  factory PublicationItemModel.fromMap(Map<String, dynamic> map) {
    return PublicationItemModel(
      id: map["id"] != null ? map['id'] as int : 0,
      publication_id: map["publication_id"] != null ? map['publication_id'] as int : 0,
      url: map['url'] != null ? map['url'] as String : null,
      title: map['title'] != null ? map['title'] as String : "",
      content: map["content"] != null ? map['content'] as String : "",
      tags: map['tags'] != null ? List<String>.from(map['tags'].map((e) => e.toString())) : [],
      duration: map['duration'] != null ? map['duration'] as int : 0,
    );
  }

  factory PublicationItemModel.fromJson(String source) => PublicationItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': supabaseUser!.id,
      'publication_id': publication_id,
      'url': url,
      'title': title,
      'content': content,
      'tags': tags,
      'duration': duration,
    };
  }

  String toJson() => json.encode(toMap());

  PublicationItemModel copyWith({
    int? id,
    int? publication_id,
    String? url,
    String? title,
    String? content,
    List<String>? tags,
    int? duration,
  }) {
    return PublicationItemModel(
      id: id ?? this.id,
      publication_id: publication_id ?? this.publication_id,
      url: url ?? this.url,
      title: title ?? this.title,
      content: content ?? this.content,
      tags: tags ?? this.tags,
      duration: duration ?? this.duration,
    );
  }

  @override
  List<Object?> get props => [id, publication_id, url, content, tags, title, duration];
}
