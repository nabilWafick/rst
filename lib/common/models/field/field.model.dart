// ignore_for_file: public_member_api_docs, sort_constructors_first

class Field {
  final String front;
  final String back;
  final Type type;
  final bool isNullable;
  Field({
    required this.front,
    required this.back,
    required this.type,
    required this.isNullable,
  });

  Field copyWith({
    String? front,
    String? back,
    Type? type,
    bool? isNullable,
  }) {
    return Field(
      front: front ?? this.front,
      back: back ?? this.back,
      type: type ?? this.type,
      isNullable: isNullable ?? this.isNullable,
    );
  }

  @override
  String toString() {
    return 'Field(front: $front, back: $back, type: $type, isNullable: $isNullable)';
  }

  @override
  bool operator ==(covariant Field other) {
    if (identical(this, other)) return true;

    return other.front == front &&
        other.back == back &&
        other.type == type &&
        other.isNullable == isNullable;
  }

  @override
  int get hashCode {
    return front.hashCode ^ back.hashCode ^ type.hashCode ^ isNullable.hashCode;
  }
}
