// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rst/modules/cash/collections/models/collections.model.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

class Settlement {
  final int? id;
  final int number;
  final bool isValidated;
  final Card card;
  final Collection? collection;
  final Agent agent;
  final DateTime createdAt;
  final DateTime updatedAt;
  Settlement({
    this.id,
    required this.number,
    required this.isValidated,
    required this.card,
    this.collection,
    required this.agent,
    required this.createdAt,
    required this.updatedAt,
  });

  Settlement copyWith({
    int? id,
    int? number,
    bool? isValidated,
    Card? card,
    Collection? collection,
    Agent? agent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Settlement(
      id: id ?? this.id,
      number: number ?? this.number,
      isValidated: isValidated ?? this.isValidated,
      card: card ?? this.card,
      collection: collection ?? this.collection,
      agent: agent ?? this.agent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
      'isValidated': isValidated,
      'cardId': card.id,
      'collectionId': collection!.id,
      'agentId': agent.id,
    };
  }

  factory Settlement.fromMap(Map<String, dynamic> map) {
    // clear all type products for improving speed and performance (display)
    map['card']?['type']?['typeProducts'] = [];

    return Settlement(
      id: map['id'] != null ? map['id'] as int : null,
      number: map['number'] as int,
      isValidated: map['isValidated'] as bool,
      card: Card.fromMap(map['card'] as Map<String, dynamic>),
      collection: map['collection'] != null
          ? Collection.fromMap(map['collection'] as Map<String, dynamic>)
          : null,
      agent: Agent.fromMap(map['agent'] as Map<String, dynamic>),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Settlement.fromJson(String source) =>
      Settlement.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Settlement(id: $id, number: $number, isValidated: $isValidated, card: $card, collection: $collection, agent: $agent, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Settlement other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.number == number &&
        other.isValidated == isValidated &&
        other.card == card &&
        other.collection == collection &&
        other.agent == agent &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        number.hashCode ^
        isValidated.hashCode ^
        card.hashCode ^
        collection.hashCode ^
        agent.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
