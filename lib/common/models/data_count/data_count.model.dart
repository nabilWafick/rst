// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DataCount {
  final int number;
  DataCount({
    required this.number,
  });

  DataCount copyWith({
    int? number,
  }) {
    return DataCount(
      number: number ?? this.number,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'number': number,
    };
  }

  factory DataCount.fromMap(Map<String, dynamic> map) {
    return DataCount(
      number: map['number'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataCount.fromJson(String source) =>
      DataCount.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DataCount(number: $number)';

  @override
  bool operator ==(covariant DataCount other) {
    if (identical(this, other)) return true;

    return other.number == number;
  }

  @override
  int get hashCode => number.hashCode;
}
