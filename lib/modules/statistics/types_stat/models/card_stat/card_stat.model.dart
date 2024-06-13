// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';
import 'package:rst/modules/statistics/types_stat/models/settlement_stat/settlement_stat.model.dart';

class CardStat {
  final int? id;
  final String label;
  final int typesNumber;
  final Customer customer;
  final DateTime? satisfiedAt;
  final DateTime? repaidAt;
  final DateTime? transferredAt;
  final List<SettlementStat> settlements;
  final DateTime createdAt;
  final DateTime updatedAt;
  CardStat({
    this.id,
    required this.label,
    required this.typesNumber,
    required this.customer,
    this.satisfiedAt,
    this.repaidAt,
    this.transferredAt,
    required this.settlements,
    required this.createdAt,
    required this.updatedAt,
  });

  CardStat copyWith({
    int? id,
    String? label,
    int? typesNumber,
    Customer? customer,
    DateTime? satisfiedAt,
    DateTime? repaidAt,
    DateTime? transferredAt,
    List<SettlementStat>? settlements,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CardStat(
      id: id ?? this.id,
      label: label ?? this.label,
      typesNumber: typesNumber ?? this.typesNumber,
      customer: customer ?? this.customer,
      satisfiedAt: satisfiedAt ?? this.satisfiedAt,
      repaidAt: repaidAt ?? this.repaidAt,
      transferredAt: transferredAt ?? this.transferredAt,
      settlements: settlements ?? this.settlements,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'typesNumber': typesNumber,
      'customer': customer.toMap(),
      'satisfiedAt': satisfiedAt?.millisecondsSinceEpoch,
      'repaidAt': repaidAt?.millisecondsSinceEpoch,
      'transferredAt': transferredAt?.millisecondsSinceEpoch,
      'settlements':
          settlements.map((settlement) => settlement.toMap()).toList(),
    };
  }

  factory CardStat.fromMap(Map<String, dynamic> map) {
    return CardStat(
      id: map['id'] != null ? map['id'] as int : null,
      label: map['label'] as String,
      typesNumber: map['typesNumber'] as int,
      customer: Customer.fromMap(map['customer'] as Map<String, dynamic>),
      satisfiedAt: map['satisfiedAt'] != null
          ? DateTime.parse(map['satisfiedAt'])
          : null,
      repaidAt:
          map['repaidAt'] != null ? DateTime.parse(map['repaidAt']) : null,
      transferredAt: map['transferredAt'] != null
          ? DateTime.parse(map['transferredAt'])
          : null,
      settlements: List<SettlementStat>.from(
        (map['settlements'] as List<dynamic>).map<SettlementStat>(
          (settlement) => SettlementStat.fromMap(
            settlement as Map<String, dynamic>,
          ),
        ),
      ),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CardStat.fromJson(String source) =>
      CardStat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardStat(id: $id, label: $label, typesNumber: $typesNumber, customer: $customer, satisfiedAt: $satisfiedAt, repaidAt: $repaidAt, transferredAt: $transferredAt, settlements: $settlements, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant CardStat other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.label == label &&
        other.typesNumber == typesNumber &&
        other.customer == customer &&
        other.satisfiedAt == satisfiedAt &&
        other.repaidAt == repaidAt &&
        other.transferredAt == transferredAt &&
        listEquals(other.settlements, settlements) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        label.hashCode ^
        typesNumber.hashCode ^
        customer.hashCode ^
        satisfiedAt.hashCode ^
        repaidAt.hashCode ^
        transferredAt.hashCode ^
        settlements.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
