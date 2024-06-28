// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductForecastPerCollector {
  final int productId;
  final String productName;
  final int forecastNumber;
  final num forecastAmount;
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
  final List<dynamic> forecastsNumbers;
  final List<dynamic> forecastsAmounts;
  ProductForecastPerCollector({
    required this.productId,
    required this.productName,
    required this.forecastNumber,
    required this.forecastAmount,
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
    required this.forecastsNumbers,
    required this.forecastsAmounts,
  });

  ProductForecastPerCollector copyWith({
    int? productId,
    String? productName,
    int? forecastNumber,
    num? forecastAmount,
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
    List<dynamic>? forecastsNumbers,
    List<dynamic>? forecastsAmounts,
  }) {
    return ProductForecastPerCollector(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      forecastNumber: forecastNumber ?? this.forecastNumber,
      forecastAmount: forecastAmount ?? this.forecastAmount,
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
      totalsSettlementsNumbers:
          totalsSettlementsNumbers ?? this.totalsSettlementsNumbers,
      totalsSettlementsAmounts:
          totalsSettlementsAmounts ?? this.totalsSettlementsAmounts,
      forecastsNumbers: forecastsNumbers ?? this.forecastsNumbers,
      forecastsAmounts: forecastsAmounts ?? this.forecastsAmounts,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'forecastNumber': forecastNumber,
      'forecastAmount': forecastAmount,
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
      'forecastsNumbers': forecastsNumbers,
      'forecastsAmounts': forecastsAmounts,
    };
  }

  factory ProductForecastPerCollector.fromMap(Map<String, dynamic> map) {
    return ProductForecastPerCollector(
      productId: map['productId']?.toInt() ?? 0,
      productName: map['productName'] ?? '',
      forecastNumber: map['forecastNumber']?.toInt() ?? 0,
      forecastAmount: map['forecastAmount'] ?? 0,
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
      totalsSettlementsNumbers:
          List<dynamic>.from(map['totalsSettlementsNumbers']),
      totalsSettlementsAmounts:
          List<dynamic>.from(map['totalsSettlementsAmounts']),
      forecastsNumbers: List<dynamic>.from(map['forecastsNumbers']),
      forecastsAmounts: List<dynamic>.from(map['forecastsAmounts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductForecastPerCollector.fromJson(String source) =>
      ProductForecastPerCollector.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductForecastPerCollector(productId: $productId, productName: $productName, forecastNumber: $forecastNumber, forecastAmount: $forecastAmount, collectorId: $collectorId, collectorName: $collectorName, collectorFirstnames: $collectorFirstnames, customersIds: $customersIds, customersNames: $customersNames, customersFirstnames: $customersFirstnames, cardsIds: $cardsIds, cardsLabels: $cardsLabels, cardsTypesNumbers: $cardsTypesNumbers, typesIds: $typesIds, typesNames: $typesNames, totalsSettlementsNumbers: $totalsSettlementsNumbers, totalsSettlementsAmounts: $totalsSettlementsAmounts, forecastsNumbers: $forecastsNumbers, forecastsAmounts: $forecastsAmounts)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductForecastPerCollector &&
        other.productId == productId &&
        other.productName == productName &&
        other.forecastNumber == forecastNumber &&
        other.forecastAmount == forecastAmount &&
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
        listEquals(other.forecastsNumbers, forecastsNumbers) &&
        listEquals(other.forecastsAmounts, forecastsAmounts);
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        forecastNumber.hashCode ^
        forecastAmount.hashCode ^
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
        forecastsNumbers.hashCode ^
        forecastsAmounts.hashCode;
  }
}
