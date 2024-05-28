// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rst/modules/definitions/agents/models/agents.model.dart';
import 'package:rst/modules/definitions/collectors/models/collectors.model.dart';

class Collection {
  final int? id;
  final double amount;
  final double rest;
  final DateTime collectedAt;
  final Collector collector;
  final Agent agent;
  final DateTime createdAt;
  final DateTime updatedAt;

  Collection({
    this.id,
    required this.amount,
    required this.rest,
    required this.collectedAt,
    required this.collector,
    required this.agent,
    required this.createdAt,
    required this.updatedAt,
  });

  Collection copyWith({
    int? id,
    double? amount,
    double? rest,
    DateTime? collectedAt,
    Collector? collector,
    Agent? agent,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Collection(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      rest: rest ?? this.rest,
      collectedAt: collectedAt ?? this.collectedAt,
      collector: collector ?? this.collector,
      agent: agent ?? this.agent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'rest': rest,
      'collectedAt': '${collectedAt.toIso8601String()}Z',
      'collectorId': collector.id,
      'agentId': agent.id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Collection.fromMap(Map<String, dynamic> map) {
    return Collection(
      id: map['id'] != null ? map['id'] as int : null,
      amount: map['amount'] as double,
      rest: map['rest'] as double,
      collectedAt:
          DateTime.fromMillisecondsSinceEpoch(map['collectedAt'] as int),
      collector: Collector.fromMap(map['collector'] as Map<String, dynamic>),
      agent: Agent.fromMap(map['agent'] as Map<String, dynamic>),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Collection.fromJson(String source) =>
      Collection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Collection(id: $id, amount: $amount, rest: $rest, collectedAt: $collectedAt, collector: $collector, agent: $agent, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Collection other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.rest == rest &&
        other.collectedAt == collectedAt &&
        other.collector == collector &&
        other.agent == agent &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        rest.hashCode ^
        collectedAt.hashCode ^
        collector.hashCode ^
        agent.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
