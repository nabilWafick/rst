import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rst/modules/statistics/products_improvidence/models/products_improvidence_collector/products_improvidence_collector.model.dart';

class ProductImprovidence {
  final int productId;
  final String productName;
  final int improvidenceNumber;
  final num improvidenceAmount;
  final List<dynamic> customersIds;
  final List<dynamic> customersNames;
  final List<dynamic> customersFirstnames;
  final List<dynamic> collectorsIds;
  final List<dynamic> collectorsNames;
  final List<dynamic> collectorsFirstnames;
  final List<dynamic> cardsIds;
  final List<dynamic> cardsLabels;
  final List<dynamic> cardsTypesNumbers;
  final List<dynamic> typesIds;
  final List<dynamic> typesNames;
  final List<dynamic> totalsSettlementsNumbers;
  final List<dynamic> totalsSettlementsAmounts;
  final List<dynamic> improvidencesNumbers;
  final List<dynamic> improvidencesAmounts;

  ProductImprovidence({
    required this.productId,
    required this.productName,
    required this.improvidenceNumber,
    required this.improvidenceAmount,
    required this.customersIds,
    required this.customersNames,
    required this.customersFirstnames,
    required this.collectorsIds,
    required this.collectorsNames,
    required this.collectorsFirstnames,
    required this.cardsIds,
    required this.cardsLabels,
    required this.cardsTypesNumbers,
    required this.typesIds,
    required this.typesNames,
    required this.totalsSettlementsNumbers,
    required this.totalsSettlementsAmounts,
    required this.improvidencesNumbers,
    required this.improvidencesAmounts,
  });

  ProductImprovidence copyWith({
    int? productId,
    String? productName,
    int? improvidenceNumber,
    num? improvidenceAmount,
    List<dynamic>? customersIds,
    List<dynamic>? customersNames,
    List<dynamic>? customersFirstnames,
    List<dynamic>? collectorsIds,
    List<dynamic>? collectorsNames,
    List<dynamic>? collectorsFirstnames,
    List<dynamic>? cardsIds,
    List<dynamic>? cardsLabels,
    List<dynamic>? cardsTypesNumbers,
    List<dynamic>? typesIds,
    List<dynamic>? typesNames,
    List<dynamic>? totalsSettlementsNumbers,
    List<dynamic>? totalsSettlementsAmounts,
    List<dynamic>? improvidencesNumbers,
    List<dynamic>? improvidencesAmounts,
  }) {
    return ProductImprovidence(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      improvidenceNumber: improvidenceNumber ?? this.improvidenceNumber,
      improvidenceAmount: improvidenceAmount ?? this.improvidenceAmount,
      customersIds: customersIds ?? this.customersIds,
      customersNames: customersNames ?? this.customersNames,
      customersFirstnames: customersFirstnames ?? this.customersFirstnames,
      collectorsIds: collectorsIds ?? this.collectorsIds,
      collectorsNames: collectorsNames ?? this.collectorsNames,
      collectorsFirstnames: collectorsFirstnames ?? this.collectorsFirstnames,
      cardsIds: cardsIds ?? this.cardsIds,
      cardsLabels: cardsLabels ?? this.cardsLabels,
      cardsTypesNumbers: cardsTypesNumbers ?? this.cardsTypesNumbers,
      typesIds: typesIds ?? this.typesIds,
      typesNames: typesNames ?? this.typesNames,
      totalsSettlementsNumbers: totalsSettlementsNumbers ?? this.totalsSettlementsNumbers,
      totalsSettlementsAmounts: totalsSettlementsAmounts ?? this.totalsSettlementsAmounts,
      improvidencesNumbers: improvidencesNumbers ?? this.improvidencesNumbers,
      improvidencesAmounts: improvidencesAmounts ?? this.improvidencesAmounts,
    );
  }

  List<ProductImprovidencePerCollector> getPerCollector() {
    List<ProductImprovidencePerCollector> productImprovidencePerCollectorList = [];
    if (collectorsIds.isNotEmpty) {
      for (int i = 0; i < collectorsIds.length; i++) {
        dynamic collectorId = collectorsIds[i];
        dynamic collectorName = collectorsNames[i];
        dynamic collectorFirstnames = collectorsFirstnames[i];

        dynamic productCustomersIds = [];
        dynamic productCustomersNames = [];
        dynamic productCustomersFirstnames = [];

        dynamic productCardsIds = [];
        dynamic productCardsLabels = [];
        dynamic productCardsTypesNumbers = [];

        dynamic productTypesIds = [];
        dynamic productTypesNames = [];

        dynamic productTotalsSettlementsNumbers = [];
        dynamic productTotalsSettlementsAmounts = [];

        dynamic productImprovidencesNumbers = [];
        dynamic productImprovidencesAmounts = [];
        // used for controling the loop

        int j = 0;
        while (j != customersIds.length && i != collectorsIds.length) {
          productCustomersIds.add(
            num.tryParse(customersIds[i].toString()) ?? 0,
          );
          productCustomersNames.add(customersNames[i]);
          productCustomersFirstnames.add(customersFirstnames[i]);

          productCardsIds.add(
            num.tryParse(cardsIds[i].toString()) ?? 0,
          );
          productCardsLabels.add(cardsLabels[i]);
          productCardsTypesNumbers.add(
            num.tryParse(cardsTypesNumbers[i].toString()) ?? 0,
          );

          productTypesIds.add(
            num.tryParse(typesIds[i].toString()) ?? 0,
          );
          productTypesNames.add(typesNames[i]);

          productTotalsSettlementsNumbers.add(
            num.tryParse(totalsSettlementsNumbers[i].toString()) ?? 0,
          );
          productTotalsSettlementsAmounts.add(
            num.tryParse(totalsSettlementsAmounts[i].toString()) ?? 0,
          );

          productImprovidencesNumbers.add(
            num.tryParse(improvidencesNumbers[i].toString()) ?? 0,
          );
          productImprovidencesAmounts.add(
            num.tryParse(improvidencesAmounts[i].toString()) ?? 0,
          );

          if (i != collectorsIds.length - 1 && collectorsIds[i] != collectorsIds[i + 1]) {
            // for stopping while loop
            j = collectorsIds.length;
          } else {
            // increment j for a good looping
            ++j;
            // increment i because, at this step, it still in the loop
            // and will be used to stop the loop
            ++i;
          }
        }

        final productImprovidencePerCollector = ProductImprovidencePerCollector(
          productId: productId,
          productName: productName,
          improvidenceNumber: improvidenceNumber,
          improvidenceAmount: improvidenceAmount,
          collectorId: collectorId,
          collectorName: collectorName,
          collectorFirstnames: collectorFirstnames,
          customersIds: productCustomersIds,
          customersNames: productCustomersNames,
          customersFirstnames: productCustomersFirstnames,
          cardsIds: productCardsIds,
          cardsLabels: productCardsLabels,
          cardsTypesNumbers: productCardsTypesNumbers,
          typesIds: productTypesIds,
          typesNames: productTypesNames,
          totalsSettlementsNumbers: productTotalsSettlementsNumbers,
          totalsSettlementsAmounts: productTotalsSettlementsAmounts,
          improvidenceNumbers: productImprovidencesNumbers,
          improvidenceAmounts: productImprovidencesAmounts,
        );

        productImprovidencePerCollectorList.add(
          productImprovidencePerCollector,
        );
      }
    }
    return productImprovidencePerCollectorList;
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'improvidenceNumber': improvidenceNumber,
      'improvidenceAmount': improvidenceAmount,
      'customersIds': customersIds,
      'customersNames': customersNames,
      'customersFirstnames': customersFirstnames,
      'collectorsIds': collectorsIds,
      'collectorsNames': collectorsNames,
      'collectorsFirstnames': collectorsFirstnames,
      'cardsIds': cardsIds,
      'cardsLabels': cardsLabels,
      'cardsTypesNumbers': cardsTypesNumbers,
      'typesIds': typesIds,
      'typesNames': typesNames,
      'totalsSettlementsNumbers': totalsSettlementsNumbers,
      'totalsSettlementsAmounts': totalsSettlementsAmounts,
      'improvidencesNumbers': improvidencesNumbers,
      'improvidencesAmounts': improvidencesAmounts,
    };
  }

  factory ProductImprovidence.fromMap(Map<String, dynamic> map) {
    return ProductImprovidence(
      productId: map['productId']?.toInt() ?? 0,
      productName: map['productName'] ?? '',
      improvidenceNumber: (map['improvidenceNumber'])?.toInt() ?? 0,
      improvidenceAmount: num.tryParse(map['improvidenceAmount']) ?? 0,
      customersIds: List<dynamic>.from(map['customersIds']),
      customersNames: List<dynamic>.from(map['customersNames']),
      customersFirstnames: List<dynamic>.from(map['customersFirstnames']),
      collectorsIds: List<dynamic>.from(map['collectorsIds']),
      collectorsNames: List<dynamic>.from(map['collectorsNames']),
      collectorsFirstnames: List<dynamic>.from(map['collectorsFirstnames']),
      cardsIds: List<dynamic>.from(map['cardsIds']),
      cardsLabels: List<dynamic>.from(map['cardsLabels']),
      cardsTypesNumbers: List<dynamic>.from(map['cardsTypesNumbers']),
      typesIds: List<dynamic>.from(map['typesIds']),
      typesNames: List<dynamic>.from(map['typesNames']),
      totalsSettlementsNumbers: List<dynamic>.from(map['totalsSettlementsNumbers']),
      totalsSettlementsAmounts: List<dynamic>.from(map['totalsSettlementsAmounts']),
      improvidencesNumbers: List<dynamic>.from(map['improvidencesNumbers']),
      improvidencesAmounts: List<dynamic>.from(map['improvidencesAmounts']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductImprovidence.fromJson(String source) =>
      ProductImprovidence.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductImprovidence(productId: $productId, productName: $productName, improvidenceNumber: $improvidenceNumber, improvidenceAmount: $improvidenceAmount, customersIds: $customersIds, customersNames: $customersNames, customersFirstnames: $customersFirstnames, collectorsIds: $collectorsIds, collectorsNames: $collectorsNames, collectorsFirstnames: $collectorsFirstnames, cardsIds: $cardsIds, cardsLabels: $cardsLabels, cardsTypesNumbers: $cardsTypesNumbers, typesIds: $typesIds, typesNames: $typesNames, totalsSettlementsNumbers: $totalsSettlementsNumbers, totalsSettlementsAmounts: $totalsSettlementsAmounts, improvidencesNumbers: $improvidencesNumbers, improvidencesAmounts: $improvidencesAmounts)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductImprovidence &&
        other.productId == productId &&
        other.productName == productName &&
        other.improvidenceNumber == improvidenceNumber &&
        other.improvidenceAmount == improvidenceAmount &&
        listEquals(other.customersIds, customersIds) &&
        listEquals(other.customersNames, customersNames) &&
        listEquals(other.customersFirstnames, customersFirstnames) &&
        listEquals(other.collectorsIds, collectorsIds) &&
        listEquals(other.collectorsNames, collectorsNames) &&
        listEquals(other.collectorsFirstnames, collectorsFirstnames) &&
        listEquals(other.cardsIds, cardsIds) &&
        listEquals(other.cardsLabels, cardsLabels) &&
        listEquals(other.cardsTypesNumbers, cardsTypesNumbers) &&
        listEquals(other.typesIds, typesIds) &&
        listEquals(other.typesNames, typesNames) &&
        listEquals(other.totalsSettlementsNumbers, totalsSettlementsNumbers) &&
        listEquals(other.totalsSettlementsAmounts, totalsSettlementsAmounts) &&
        listEquals(other.improvidencesNumbers, improvidencesNumbers) &&
        listEquals(other.improvidencesAmounts, improvidencesAmounts);
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        improvidenceNumber.hashCode ^
        improvidenceAmount.hashCode ^
        customersIds.hashCode ^
        customersNames.hashCode ^
        customersFirstnames.hashCode ^
        collectorsIds.hashCode ^
        collectorsNames.hashCode ^
        collectorsFirstnames.hashCode ^
        cardsIds.hashCode ^
        cardsLabels.hashCode ^
        cardsTypesNumbers.hashCode ^
        typesIds.hashCode ^
        typesNames.hashCode ^
        totalsSettlementsNumbers.hashCode ^
        totalsSettlementsAmounts.hashCode ^
        improvidencesNumbers.hashCode ^
        improvidencesAmounts.hashCode;
  }
}
