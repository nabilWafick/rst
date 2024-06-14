// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SettlementStat {
  final int? id;
  final int number;
  SettlementStat({
    this.id,
    required this.number,
  });

  SettlementStat copyWith({
    int? id,
    int? number,
  }) {
    return SettlementStat(
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

  factory SettlementStat.fromMap(Map<String, dynamic> map) {
    return SettlementStat(
      id: map['id'] != null ? map['id'] as int : null,
      number: map['number'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettlementStat.fromJson(String source) =>
      SettlementStat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SettlementStat(id: $id, number: $number)';

  @override
  bool operator ==(covariant SettlementStat other) {
    if (identical(this, other)) return true;

    return other.id == id && other.number == number;
  }

  @override
  int get hashCode => id.hashCode ^ number.hashCode;
}
