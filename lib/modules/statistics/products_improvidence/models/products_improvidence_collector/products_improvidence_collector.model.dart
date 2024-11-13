// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductImprovidencePerCollector {
  final int productId;
  final String productName;
  final int improvidenceNumber;
  final num improvidenceAmount;
  final dynamic collectorId;
  final dynamic collectorName;
  final dynamic collectorFirstnames;
  final List<dynamic> customersIds;
  final List<dynamic> customersNames;
  final List<dynamic> customersFirstnames;
  final List<dynamic> cardsIds;
  final List<dynamic> cardsLabels;
  final List<dynamic> cardsTypesNumbers;
  final List<dynamic> typesIds;
  final List<dynamic> typesNames;
  final List<dynamic> totalsSettlementsNumbers;
  final List<dynamic> totalsSettlementsAmounts;
  final List<dynamic> improvidenceNumbers;
  final List<dynamic> improvidenceAmounts;
  ProductImprovidencePerCollector({
    required this.productId,
    required this.productName,
    required this.improvidenceNumber,
    required this.improvidenceAmount,
    required this.collectorId,
    required this.collectorName,
    required this.collectorFirstnames,
    required this.customersIds,
    required this.customersNames,
    required this.customersFirstnames,
    required this.cardsIds,
    required this.cardsLabels,
    required this.cardsTypesNumbers,
    required this.typesIds,
    required this.typesNames,
    required this.totalsSettlementsNumbers,
    required this.totalsSettlementsAmounts,
    required this.improvidenceNumbers,
    required this.improvidenceAmounts,
  });

  ProductImprovidencePerCollector copyWith({
    int? productId,
    String? productName,
    int? improvidenceNumber,
    num? improvidenceAmount,
    int? collectorId,
    String? collectorName,
    String? collectorFirstnames,
    List<dynamic>? customersIds,
    List<dynamic>? customersNames,
    List<dynamic>? customersFirstnames,
    List<dynamic>? cardsIds,
    List<dynamic>? cardsLabels,
    List<dynamic>? cardsTypesNumbers,
    List<dynamic>? typesIds,
    List<dynamic>? typesNames,
    List<dynamic>? totalsSettlementsNumbers,
    List<dynamic>? totalsSettlementsAmounts,
    List<dynamic>? improvidenceNumbers,
    List<dynamic>? improvidenceAmounts,
  }) {
    return ProductImprovidencePerCollector(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      improvidenceNumber: improvidenceNumber ?? this.improvidenceNumber,
      improvidenceAmount: improvidenceAmount ?? this.improvidenceAmount,
      collectorId: collectorId ?? this.collectorId,
      collectorName: collectorName ?? this.collectorName,
      collectorFirstnames: collectorFirstnames ?? this.collectorFirstnames,
      customersIds: customersIds ?? this.customersIds,
      customersNames: customersNames ?? this.customersNames,
      customersFirstnames: customersFirstnames ?? this.customersFirstnames,
      cardsIds: cardsIds ?? this.cardsIds,
      cardsLabels: cardsLabels ?? this.cardsLabels,
      cardsTypesNumbers: cardsTypesNumbers ?? this.cardsTypesNumbers,
      typesIds: typesIds ?? this.typesIds,
      typesNames: typesNames ?? this.typesNames,
      totalsSettlementsNumbers: totalsSettlementsNumbers ?? this.totalsSettlementsNumbers,
      totalsSettlementsAmounts: totalsSettlementsAmounts ?? this.totalsSettlementsAmounts,
      improvidenceNumbers: improvidenceNumbers ?? this.improvidenceNumbers,
      improvidenceAmounts: improvidenceAmounts ?? this.improvidenceAmounts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'improvidenceNumber': improvidenceNumber,
      'improvidenceAmount': improvidenceAmount,
      'collectorId': collectorId,
      'collectorName': collectorName,
      'collectorFirstnames': collectorFirstnames,
      'customersIds': customersIds,
      'customersNames': customersNames,
      'customersFirstnames': customersFirstnames,
      'cardsIds': cardsIds,
      'cardsLabels': cardsLabels,
      'cardsTypesNumbers': cardsTypesNumbers,
      'typesIds': typesIds,
      'typesNames': typesNames,
      'totalsSettlementsNumbers': totalsSettlementsNumbers,
      'totalsSettlementsAmounts': totalsSettlementsAmounts,
      'improvidenceNumbers': improvidenceNumbers,
      'improvidenceAmounts': improvidenceAmounts,
    };
  }

  factory ProductImprovidencePerCollector.fromMap(Map<String, dynamic> map) {
    return ProductImprovidencePerCollector(
      productId: map['productId']?.toInt() ?? 0,
      productName: map['productName'] ?? '',
      improvidenceNumber: map['improvidenceNumber']?.toInt() ?? 0,
      improvidenceAmount: map['improvidenceAmount'] ?? 0,
      collectorId: map['collectorId']?.toInt() ?? 0,
      collectorName: map['collectorName'] ?? '',
      collectorFirstnames: map['collectorFirstnames'] ?? '',
      customersIds: List<dynamic>.from(map['customersIds']),
      customersNames: List<dynamic>.from(map['customersNames']),
      customersFirstnames: List<dynamic>.from(map['customersFirstnames']),
      cardsIds: List<dynamic>.from(map['cardsIds']),
      cardsLabels: List<dynamic>.from(map['cardsLabels']),
      cardsTypesNumbers: List<dynamic>.from(map['cardsTypesNumbers']),
      typesIds: List<dynamic>.from(map['typesIds']),
      typesNames: List<dynamic>.from(map['typesNames']),
      totalsSettlementsNumbers: List<dynamic>.from(map['totalsSettlementsNumbers']),
      totalsSettlementsAmounts: List<dynamic>.from(map['totalsSettlementsAmounts']),
      improvidenceNumbers: List<dynamic>.from(map['improvidenceNumbers']),
      improvidenceAmounts: List<dynamic>.from(map['improvidenceAmounts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductImprovidencePerCollector.fromJson(String source) =>
      ProductImprovidencePerCollector.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductImprovidencePerCollector(productId: $productId, productName: $productName, improvidenceNumber: $improvidenceNumber, improvidenceAmount: $improvidenceAmount, collectorId: $collectorId, collectorName: $collectorName, collectorFirstnames: $collectorFirstnames, customersIds: $customersIds, customersNames: $customersNames, customersFirstnames: $customersFirstnames, cardsIds: $cardsIds, cardsLabels: $cardsLabels, cardsTypesNumbers: $cardsTypesNumbers, typesIds: $typesIds, typesNames: $typesNames, totalsSettlementsNumbers: $totalsSettlementsNumbers, totalsSettlementsAmounts: $totalsSettlementsAmounts, improvidenceNumbers: $improvidenceNumbers, improvidenceAmounts: $improvidenceAmounts)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductImprovidencePerCollector &&
        other.productId == productId &&
        other.productName == productName &&
        other.improvidenceNumber == improvidenceNumber &&
        other.improvidenceAmount == improvidenceAmount &&
        other.collectorId == collectorId &&
        other.collectorName == collectorName &&
        other.collectorFirstnames == collectorFirstnames &&
        listEquals(other.customersIds, customersIds) &&
        listEquals(other.customersNames, customersNames) &&
        listEquals(other.customersFirstnames, customersFirstnames) &&
        listEquals(other.cardsIds, cardsIds) &&
        listEquals(other.cardsLabels, cardsLabels) &&
        listEquals(other.cardsTypesNumbers, cardsTypesNumbers) &&
        listEquals(other.typesIds, typesIds) &&
        listEquals(other.typesNames, typesNames) &&
        listEquals(other.totalsSettlementsNumbers, totalsSettlementsNumbers) &&
        listEquals(other.totalsSettlementsAmounts, totalsSettlementsAmounts) &&
        listEquals(other.improvidenceNumbers, improvidenceNumbers) &&
        listEquals(other.improvidenceAmounts, improvidenceAmounts);
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        improvidenceNumber.hashCode ^
        improvidenceAmount.hashCode ^
        collectorId.hashCode ^
        collectorName.hashCode ^
        collectorFirstnames.hashCode ^
        customersIds.hashCode ^
        customersNames.hashCode ^
        customersFirstnames.hashCode ^
        cardsIds.hashCode ^
        cardsLabels.hashCode ^
        cardsTypesNumbers.hashCode ^
        typesIds.hashCode ^
        typesNames.hashCode ^
        totalsSettlementsNumbers.hashCode ^
        totalsSettlementsAmounts.hashCode ^
        improvidenceNumbers.hashCode ^
        improvidenceAmounts.hashCode;
  }
}
