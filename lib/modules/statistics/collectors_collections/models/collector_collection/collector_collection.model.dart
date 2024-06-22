import 'dart:convert';

import 'package:rst/common/functions/practical/pratical.function.dart';

class CollectorCollection {
  final int? id;
  final String name;
  final String firstnames;
  final String phoneNumber;
  final int totalCollections;
  final num totalAmount;
  final DateTime collectedAt;

  const CollectorCollection({
    this.id,
    required this.name,
    required this.firstnames,
    required this.phoneNumber,
    required this.totalCollections,
    required this.totalAmount,
    required this.collectedAt,
  });

  CollectorCollection copyWith({
    int? id,
    String? name,
    String? firstnames,
    String? phoneNumber,
    int? totalCollections,
    num? totalAmount,
    DateTime? collectedAt,
  }) {
    return CollectorCollection(
      id: id ?? this.id,
      name: name ?? this.name,
      firstnames: firstnames ?? this.firstnames,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      totalCollections: totalCollections ?? this.totalCollections,
      totalAmount: totalAmount ?? this.totalAmount,
      collectedAt: collectedAt ?? this.collectedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    result.addAll({'name': name});
    result.addAll({'firstnames': firstnames});
    result.addAll({'phoneNumber': phoneNumber});
    result.addAll({'totalCollections': totalCollections});
    result.addAll({'totalAmount': totalAmount});
    result.addAll(
      {
        'collectedAt': FunctionsController.getTimestamptzDateString(
          dateTime: collectedAt,
        )
      },
    );

    return result;
  }

  factory CollectorCollection.fromMap(Map<String, dynamic> map) {
    return CollectorCollection(
        id: map['id']?.toInt(),
        name: map['name'] ?? '',
        firstnames: map['firstnames'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        totalCollections: map['totalCollections']?.toInt() ?? 0,
        totalAmount: map['totalAmount'] ?? 0,
        collectedAt: DateTime.parse(map['collectedAt']));
  }

  String toJson() => json.encode(toMap());

  factory CollectorCollection.fromJson(String source) =>
      CollectorCollection.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CollectorCollection(id: $id, name: $name, firstnames: $firstnames, phoneNumber: $phoneNumber, totalCollections: $totalCollections, totalAmount: $totalAmount, collectedAt: $collectedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CollectorCollection &&
        other.id == id &&
        other.name == name &&
        other.firstnames == firstnames &&
        other.phoneNumber == phoneNumber &&
        other.totalCollections == totalCollections &&
        other.totalAmount == totalAmount &&
        other.collectedAt == collectedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        firstnames.hashCode ^
        phoneNumber.hashCode ^
        totalCollections.hashCode ^
        totalAmount.hashCode ^
        collectedAt.hashCode;
  }
}
