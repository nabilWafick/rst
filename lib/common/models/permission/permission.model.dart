import 'dart:convert';

import 'package:rst/common/models/common.model.dart';

class Permission extends Operator {
  Permission({
    required super.front,
    required super.back,
  });

  factory Permission.fromMap(Map<String, dynamic> map) {
    return Permission(
      front: map['front'] as String,
      back: map['back'] as String,
    );
  }

  factory Permission.fromJson(String source) =>
      Permission.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Permission(front: $front, back: $back)';

  @override
  bool operator ==(covariant Permission other) {
    if (identical(this, other)) return true;

    return other.front == front && other.back == back;
  }

  @override
  int get hashCode => front.hashCode ^ back.hashCode;
}
