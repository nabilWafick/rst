// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SettlementStat {
  final int? id;
  final int number;
  final DateTime createdAt;
  final DateTime updatedAt;
  SettlementStat({
    this.id,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
  });

  SettlementStat copyWith({
    int? id,
    int? number,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SettlementStat(
      id: id ?? this.id,
      number: number ?? this.number,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
    };
  }

  factory SettlementStat.fromMap(Map<String, dynamic> map) {
    return SettlementStat(
      id: map['id'] != null ? map['id'] as int : null,
      number: map['number'] as int,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SettlementStat.fromJson(String source) =>
      SettlementStat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SettlementStat(id: $id, number: $number, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant SettlementStat other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.number == number &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        number.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
