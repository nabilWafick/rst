// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SettlementStatType {
  final int? id;
  final int number;
  SettlementStatType({
    this.id,
    required this.number,
  });

  SettlementStatType copyWith({
    int? id,
    int? number,
  }) {
    return SettlementStatType(
      id: id ?? this.id,
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'number': number,
    };
  }

  factory SettlementStatType.fromMap(Map<String, dynamic> map) {
    return SettlementStatType(
      id: map['id'] != null ? map['id'] as int : null,
      number: map['number'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettlementStatType.fromJson(String source) =>
      SettlementStatType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SettlementStatType(id: $id, number: $number)';

  @override
  bool operator ==(covariant SettlementStatType other) {
    if (identical(this, other)) return true;

    return other.id == id && other.number == number;
  }

  @override
  int get hashCode => id.hashCode ^ number.hashCode;
}
