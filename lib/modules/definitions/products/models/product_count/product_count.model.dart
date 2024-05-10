// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductCount {
  final int count;
  ProductCount({
    required this.count,
  });

  ProductCount copyWith({
    int? count,
  }) {
    return ProductCount(
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
    };
  }

  factory ProductCount.fromMap(Map<String, dynamic> map) {
    return ProductCount(
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductCount.fromJson(String source) =>
      ProductCount.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ProductCount(count: $count)';

  @override
  bool operator ==(covariant ProductCount other) {
    if (identical(this, other)) return true;

    return other.count == count;
  }

  @override
  int get hashCode => count.hashCode;
}
