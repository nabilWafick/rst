import 'dart:convert';

class ProductsImprovidenceFilter {
  int? productId;
  int? customerId;
  int? collectorId;
  int? cardId;
  int? typeId;
  int? totalSettlementNumber;
  int offset;
  int limit;
  ProductsImprovidenceFilter({
    this.productId,
    this.customerId,
    this.collectorId,
    this.cardId,
    this.typeId,
    this.totalSettlementNumber,
    required this.offset,
    required this.limit,
  });

  ProductsImprovidenceFilter copyWith({
    int? productId,
    int? customerId,
    int? collectorId,
    int? cardId,
    int? typeId,
    int? totalSettlementNumber,
    int? offset,
    int? limit,
  }) {
    return ProductsImprovidenceFilter(
      productId: productId ?? this.productId,
      customerId: customerId ?? this.customerId,
      collectorId: collectorId ?? this.collectorId,
      cardId: cardId ?? this.cardId,
      typeId: typeId ?? this.typeId,
      totalSettlementNumber: totalSettlementNumber ?? this.totalSettlementNumber,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'customerId': customerId,
      'collectorId': collectorId,
      'cardId': cardId,
      'typeId': typeId,
      'totalSettlementNumber': totalSettlementNumber,
      'offset': offset,
      'limit': limit,
    };
  }

  factory ProductsImprovidenceFilter.fromMap(Map<String, dynamic> map) {
    return ProductsImprovidenceFilter(
      productId: map['productId']?.toInt(),
      customerId: map['customerId']?.toInt(),
      collectorId: map['collectorId']?.toInt(),
      cardId: map['cardId']?.toInt(),
      typeId: map['typeId']?.toInt(),
      totalSettlementNumber: map['totalSettlementNumber']?.toInt(),
      offset: map['offset']?.toInt() ?? 0,
      limit: map['limit']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsImprovidenceFilter.fromJson(String source) =>
      ProductsImprovidenceFilter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductsImprovidenceFilter(productId: $productId, customerId: $customerId, collectorId: $collectorId, cardId: $cardId, typeId: $typeId, totalSettlementNumber: $totalSettlementNumber, offset: $offset, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductsImprovidenceFilter &&
        other.productId == productId &&
        other.customerId == customerId &&
        other.collectorId == collectorId &&
        other.cardId == cardId &&
        other.typeId == typeId &&
        other.totalSettlementNumber == totalSettlementNumber &&
        other.offset == offset &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        customerId.hashCode ^
        collectorId.hashCode ^
        cardId.hashCode ^
        typeId.hashCode ^
        totalSettlementNumber.hashCode ^
        offset.hashCode ^
        limit.hashCode;
  }
}
