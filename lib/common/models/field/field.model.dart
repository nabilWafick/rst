import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Field {
  final String front;
  final String back;
  final Type type;
  final bool isNullable;
  final bool isRelation;
  final List<Field>? fields;

  Field({
    required this.front,
    required this.back,
    required this.type,
    required this.isNullable,
    required this.isRelation,
    this.fields,
  }) : assert(
          !isRelation || (fields != null && (fields.isNotEmpty)),
          "A relation should have a least one field \n"
          "if `isRelation` is true, `fields` must not be null or empty",
        );

  Field copyWith({
    String? front,
    String? back,
    Type? type,
    bool? isNullable,
    bool? isRelation,
    List<Field>? fields,
  }) {
    return Field(
      front: front ?? this.front,
      back: back ?? this.back,
      type: type ?? this.type,
      isNullable: isNullable ?? this.isNullable,
      isRelation: isRelation ?? this.isRelation,
      fields: fields ?? this.fields,
    );
  }

  @override
  String toString() {
    return 'Field(front: $front, back: $back, type: $type, isNullable: $isNullable, isRelation: $isRelation, fields: $fields)';
  }

  @override
  bool operator ==(covariant Field other) {
    if (identical(this, other)) return true;

    return other.front == front &&
        other.back == back &&
        other.type == type &&
        other.isNullable == isNullable &&
        other.isRelation == isRelation &&
        listEquals(other.fields, fields);
  }

  @override
  int get hashCode {
    return front.hashCode ^
        back.hashCode ^
        type.hashCode ^
        isNullable.hashCode ^
        isRelation.hashCode ^
        fields.hashCode;
  }
}
