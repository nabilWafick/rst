// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';
import 'package:rst/modules/definitions/types/models/type/type.model.dart';

class Card {
  final int? id;
  final String label;
  final Type type;
  final int typesNumber;
  final Customer customer;
  final DateTime? satisfiedAt;
  final DateTime? repaidAt;
  final DateTime? transferredAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  Card({
    this.id,
    required this.label,
    required this.type,
    required this.typesNumber,
    required this.customer,
    this.satisfiedAt,
    this.repaidAt,
    this.transferredAt,
    required this.createdAt,
    required this.updatedAt,
  });

  Card copyWith({
    int? id,
    String? label,
    Type? type,
    int? typesNumber,
    Customer? customer,
    DateTime? satisfiedAt,
    DateTime? repaidAt,
    DateTime? transferredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Card(
      id: id ?? this.id,
      label: label ?? this.label,
      type: type ?? this.type,
      typesNumber: typesNumber ?? this.typesNumber,
      customer: customer ?? this.customer,
      satisfiedAt: satisfiedAt ?? this.satisfiedAt,
      repaidAt: repaidAt ?? this.repaidAt,
      transferredAt: transferredAt ?? this.transferredAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'label': label,
      'typeId': type.id,
      'typesNumber': typesNumber,
      'customerId': customer.id,
      'satisfiedAt': satisfiedAt != null
          ? FunctionsController.getTimestamptzDateString(
              dateTime: satisfiedAt!,
            )
          : null,
      'repaidAt': repaidAt != null
          ? FunctionsController.getTimestamptzDateString(
              dateTime: repaidAt!,
            )
          : null,
      'transferredAt': repaidAt != null
          ? FunctionsController.getTimestamptzDateString(
              dateTime: repaidAt!,
            )
          : null,
    };
  }

  factory Card.fromMap(Map<String, dynamic> map) {
    // clear all type products for improving speed and performance (display)
    map['type']['typeProducts'] = [];

    return Card(
      id: map['id'] != null ? map['id'] as int : null,
      label: map['label'] as String,
      type: Type.fromMap(map['type'] as Map<String, dynamic>),
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
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Card.fromJson(String source) =>
      Card.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Card(id: $id, label: $label, type: $type, typesNumber: $typesNumber, customer: $customer, satisfiedAt: $satisfiedAt, repaidAt: $repaidAt, transferredAt: $transferredAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Card other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.label == label &&
        other.type == type &&
        other.typesNumber == typesNumber &&
        other.customer == customer &&
        other.satisfiedAt == satisfiedAt &&
        other.repaidAt == repaidAt &&
        other.transferredAt == transferredAt &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        label.hashCode ^
        type.hashCode ^
        typesNumber.hashCode ^
        customer.hashCode ^
        satisfiedAt.hashCode ^
        repaidAt.hashCode ^
        transferredAt.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
