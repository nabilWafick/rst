import 'dart:convert';

import 'package:rst/modules/definitions/products/models/table/products_table.model.dart';

class Product {
  final int? id;
  final String name;
  final double purchasePrice;
  final String? photo;
  int? number;
  final DateTime createdAt;
  final DateTime updatedAt;
  Product({
    this.id,
    required this.name,
    required this.purchasePrice,
    this.photo,
    this.number,
    required this.createdAt,
    required this.updatedAt,
  });

  Product copyWith({
    int? id,
    String? name,
    double? purchasePrice,
    String? photo,
    int? number,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      photo: photo ?? this.photo,
      number: number ?? this.number,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap({required bool isAdding}) {
    // hide creation and update date for avoiding time hacking
    // by unsetting the system datetime
    final map = {
      ProductsTable.name: name,
      ProductsTable.purchasePrice: purchasePrice,
      ProductsTable.photo: photo,
    };

    if (!isAdding) {
      map[ProductsTable.createdAt] = createdAt.toIso8601String();
      map[ProductsTable.updatedAt] = updatedAt.toIso8601String();
    }

    return map;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map[ProductsTable.id]?.toInt(),
      name: map[ProductsTable.name] ?? '',
      purchasePrice: map[ProductsTable.purchasePrice]?.toDouble() ?? 0.0,
      photo: map[ProductsTable.photo],
      number: map['number']?.toInt(),
      createdAt: DateTime.parse(map[ProductsTable.createdAt]),
      updatedAt: DateTime.parse(map[ProductsTable.updatedAt]),
    );
  }

  String toJson() => json.encode(toMap(
        isAdding: true,
      ));

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, name: $name, purchasePrice: $purchasePrice, photo: $photo, number: $number, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.purchasePrice == purchasePrice &&
        other.photo == photo &&
        other.number == number &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        purchasePrice.hashCode ^
        photo.hashCode ^
        number.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
