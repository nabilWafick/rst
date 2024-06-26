import 'dart:convert';

import 'package:rst/common/models/common.model.dart';

class Permission extends Operator {
  final bool isGranted;

  Permission({
    required this.isGranted,
    required super.front,
    required super.back,
  });

  @override
  Permission copyWith({
    bool? isGranted,
    String? front,
    String? back,
  }) {
    return Permission(
      isGranted: isGranted ?? this.isGranted,
      front: front ?? this.front,
      back: back ?? this.back,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'isGranted': isGranted,
      'front': front,
      'back': back,
    };
  }

  factory Permission.fromMap(Map<String, dynamic> map) {
    return Permission(
      isGranted: map['isGranted'] ?? false,
      front: map['front'] ?? '',
      back: map['back'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Permission.fromJson(String source) =>
      Permission.fromMap(json.decode(source));

  @override
  String toString() =>
      'Permission(isGranted: $isGranted, front: $front, back: $back)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Permission &&
        other.isGranted == isGranted &&
        other.front == front &&
        other.back == back;
  }

  @override
  int get hashCode => isGranted.hashCode ^ front.hashCode ^ back.hashCode;
}
