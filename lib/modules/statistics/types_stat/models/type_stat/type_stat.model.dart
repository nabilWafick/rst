// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

import 'package:rst/modules/statistics/types_stat/models/card_stat/card_stat.model.dart';

class TypeStat {
  final int? id;
  final String name;
  final double stake;
  final List<CardStat> cards;
  final DateTime createdAt;
  final DateTime updatedAt;
  TypeStat({
    this.id,
    required this.name,
    required this.stake,
    required this.cards,
    required this.createdAt,
    required this.updatedAt,
  });

  TypeStat copyWith({
    int? id,
    String? name,
    double? stake,
    List<CardStat>? cards,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TypeStat(
      id: id ?? this.id,
      name: name ?? this.name,
      stake: stake ?? this.stake,
      cards: cards ?? this.cards,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'stake': stake,
      'cards': cards
          .map(
            (card) => card.toMap(),
          )
          .toList(),
    };
  }

  factory TypeStat.fromMap(Map<String, dynamic> map) {
    return TypeStat(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      stake: double.tryParse(map['stake']) ?? 0,
      cards: map['cards'].isNotEmpty
          ? List<CardStat>.from(
              (map['cards'] as List<dynamic>).map<CardStat>(
                (card) => CardStat.fromMap(
                  card,
                ),
              ),
            )
          : [],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeStat.fromJson(String source) =>
      TypeStat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TypeStat(id: $id, name: $name, stake: $stake, cards: $cards, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant TypeStat other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.name == name &&
        other.stake == stake &&
        listEquals(other.cards, cards) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        stake.hashCode ^
        cards.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
