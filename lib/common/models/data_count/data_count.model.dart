// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DataCount {
  final int count;
  DataCount({
    required this.count,
  });

  DataCount copyWith({
    int? count,
  }) {
    return DataCount(
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
    };
  }

  factory DataCount.fromMap(Map<String, dynamic> map) {
    return DataCount(
      count: map['count'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataCount.fromJson(String source) =>
      DataCount.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DataCount(count: $count)';

  @override
  bool operator ==(covariant DataCount other) {
    if (identical(this, other)) return true;

    return other.count == count;
  }

  @override
  int get hashCode => count.hashCode;
}
