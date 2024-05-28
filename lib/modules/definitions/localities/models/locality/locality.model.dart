// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Locality {
  final int? id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  Locality({
    this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  Locality copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Locality(
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

  factory Locality.fromMap(Map<String, dynamic> map) {
    return Locality(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Locality.fromJson(String source) =>
      Locality.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Locality(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Locality other) {
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
