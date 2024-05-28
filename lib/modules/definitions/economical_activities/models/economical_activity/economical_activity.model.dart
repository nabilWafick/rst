// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class EconomicalActivity {
  final int? id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  EconomicalActivity({
    this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  EconomicalActivity copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EconomicalActivity(
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

  factory EconomicalActivity.fromMap(Map<String, dynamic> map) {
    return EconomicalActivity(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory EconomicalActivity.fromJson(String source) =>
      EconomicalActivity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'EconomicalActivity(id: $id, name: $name, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant EconomicalActivity other) {
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
