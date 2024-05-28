// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PersonalStatus {
  final int? id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  PersonalStatus({
    this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  PersonalStatus copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PersonalStatus(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory PersonalStatus.fromMap(Map<String, dynamic> map) {
    return PersonalStatus(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalStatus.fromJson(String source) =>
      PersonalStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PersonalStatus(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant PersonalStatus other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
