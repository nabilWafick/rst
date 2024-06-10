// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rst/modules/definitions/products/models/product/product.model.dart';

class TypeProduct {
  final dynamic typeId;
  final int productId;
  final int productNumber;
  final Product product;
  TypeProduct({
    required this.typeId,
    required this.productId,
    required this.productNumber,
    required this.product,
  });

  TypeProduct copyWith({
    dynamic typeId,
    int? productId,
    int? productNumber,
    Product? product,
  }) {
    return TypeProduct(
      typeId: typeId ?? this.typeId,
      productId: productId ?? this.productId,
      productNumber: productNumber ?? this.productNumber,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'typeId': typeId,
      'productId': productId,
      'productNumber': productNumber,
      'product': product.toMap(),
    };
  }

  factory TypeProduct.fromMap(Map<String, dynamic> map) {
    return TypeProduct(
      typeId: map['typeId'] as dynamic,
      productId: map['productId'] as int,
      productNumber: map['productNumber'] as int,
      product: Product.fromMap(map['product'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeProduct.fromJson(String source) =>
      TypeProduct.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TypeProduct(typeId: $typeId, productId: $productId, productNumber: $productNumber, product: $product)';
  }

  @override
  bool operator ==(covariant TypeProduct other) {
    if (identical(this, other)) return true;

    return other.typeId == typeId &&
        other.productId == productId &&
        other.productNumber == productNumber &&
        other.product == product;
  }

  @override
  int get hashCode {
    return typeId.hashCode ^
        productId.hashCode ^
        productNumber.hashCode ^
        product.hashCode;
  }
}
