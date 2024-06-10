// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/modules/definitions/agents/models/agent/agent.model.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

class Transfer {
  final int? id;
  final Card issuingCard;
  final Card receivingCard;
  final Agent agent;
  final DateTime? validatedAt;
  final DateTime? rejectedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  Transfer({
    this.id,
    required this.issuingCard,
    required this.receivingCard,
    required this.agent,
    this.validatedAt,
    this.rejectedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Transfer copyWith({
    int? id,
    Card? issuingCard,
    Card? receivingCard,
    Agent? agent,
    DateTime? validatedAt,
    DateTime? rejectedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Transfer(
      id: id ?? this.id,
      issuingCard: issuingCard ?? this.issuingCard,
      receivingCard: receivingCard ?? this.receivingCard,
      agent: agent ?? this.agent,
      validatedAt: validatedAt ?? this.validatedAt,
      rejectedAt: rejectedAt ?? this.rejectedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'issuingCardId': issuingCard.id,
      'receivingCardId': receivingCard.id,
      'agentId': agent.id,
      'rejectedAt': rejectedAt != null
          ? FunctionsController.getTimestamptzDateString(dateTime: rejectedAt!)
          : null,
      'validatedAt': validatedAt != null
          ? FunctionsController.getTimestamptzDateString(dateTime: validatedAt!)
          : null,
    };
  }

  factory Transfer.fromMap(Map<String, dynamic> map) {
    map['issuingCard']['type']['typeProducts'] = [];
    map['receivingCard']['type']['typeProducts'] = [];
    return Transfer(
      id: map['id'] != null ? map['id'] as int : null,
      issuingCard: Card.fromMap(map['issuingCard'] as Map<String, dynamic>),
      receivingCard: Card.fromMap(map['receivingCard'] as Map<String, dynamic>),
      agent: Agent.fromMap(map['agent'] as Map<String, dynamic>),
      validatedAt: map['validatedAt'] != null
          ? DateTime.parse(map['validatedAt'])
          : null,
      rejectedAt:
          map['rejectedAt'] != null ? DateTime.parse(map['rejectedAt']) : null,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transfer.fromJson(String source) =>
      Transfer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transfer(id: $id, issuingCard: $issuingCard, receivingCard: $receivingCard, agent: $agent, validatedAt: $validatedAt, rejectedAt: $rejectedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Transfer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.issuingCard == issuingCard &&
        other.receivingCard == receivingCard &&
        other.agent == agent &&
        other.validatedAt == validatedAt &&
        other.rejectedAt == rejectedAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        issuingCard.hashCode ^
        receivingCard.hashCode ^
        agent.hashCode ^
        validatedAt.hashCode ^
        rejectedAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
