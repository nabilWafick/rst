// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:rst/modules/definitions/types/models/type_product/type_product.model.dart';

class Type {
  final int? id;
  final String name;
  final double stake;
  final List<TypeProduct> typeProducts;
  final DateTime createdAt;
  final DateTime updatedAt;

  Type({
    this.id,
    required this.name,
    required this.stake,
    required this.typeProducts,
    required this.createdAt,
    required this.updatedAt,
  });

  Type copyWith({
    int? id,
    String? name,
    double? stake,
    List<TypeProduct>? typeProducts,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Type(
      id: id ?? this.id,
      name: name ?? this.name,
      stake: stake ?? this.stake,
      typeProducts: typeProducts ?? this.typeProducts,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'stake': stake,
      'productsIds': typeProducts.map(
        (typeProduct) => typeProduct.product.id,
      ),
      'productsNumbers': typeProducts
          .map(
            (typeProduct) => typeProduct.productNumber,
          )
          .toList(),
    };
  }

  factory Type.fromMap(Map<String, dynamic> map) {
    return Type(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      stake: double.tryParse(map['stake']) ?? .0,
      typeProducts: List<TypeProduct>.from(
        (map['typeProducts'] as List<dynamic>).map<TypeProduct>(
          (typeProduct) => TypeProduct.fromMap(
            typeProduct as Map<String, dynamic>,
          ),
        ),
      ),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Type.fromJson(String source) =>
      Type.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Type(id: $id, name: $name, stake: $stake, typeProducts: $typeProducts, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Type other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.stake == stake &&
        listEquals(other.typeProducts, typeProducts) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        stake.hashCode ^
        typeProducts.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
