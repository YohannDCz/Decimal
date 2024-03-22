// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class ContactModel extends Equatable {
  const ContactModel({
    required this.user_uuid,
    required this.contact_uuid,
    required this.added_on,
  });

  final String user_uuid;
  final String contact_uuid;
  final DateTime added_on;

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      user_uuid: map['user_uuid'] != null ? map['user_uuid'] as String : "",
      contact_uuid: map["contact_uuid"] != null ? map['contact_uuid'] as String : "",
      added_on: map['added_on'] != null ? DateTime.parse(map['added_on'].toString()) : DateTime.now(),
    );
  }

  factory ContactModel.fromJson(String source) => ContactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_uuid': user_uuid,
      'contact_uuid': contact_uuid,
      'added_on': added_on,
    };
  }

  String toJson() => json.encode(toMap());

  ContactModel copyWith({
    String? user_uuid,
    String? contact_uuid,
    DateTime? added_on,
  }) {
    return ContactModel(
      user_uuid: user_uuid ?? this.user_uuid,
      contact_uuid: contact_uuid ?? this.contact_uuid,
      added_on: added_on ?? this.added_on,
    );
  }

  @override
  List<Object?> get props => [user_uuid, contact_uuid, added_on];
}
