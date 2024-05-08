// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'purchasePrice': purchasePrice,
      'photo': photo,
      'number': number,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      purchasePrice: map['purchasePrice'] as double,
      photo: map['photo'] != null ? map['photo'] as String : null,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, purchasePrice: $purchasePrice, photo: $photo, number: $number, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
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
