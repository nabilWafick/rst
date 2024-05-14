// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Field {
  final String front;
  final String back;
  Field({
    required this.front,
    required this.back,
  });

  Field copyWith({
    String? front,
    String? back,
  }) {
    return Field(
      front: front ?? this.front,
      back: back ?? this.back,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'front': front,
      'back': back,
    };
  }

  factory Field.fromMap(Map<String, dynamic> map) {
    return Field(
      front: map['front'] as String,
      back: map['back'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Field.fromJson(String source) =>
      Field.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Field(front: $front, back: $back)';

  @override
  bool operator ==(covariant Field other) {
    if (identical(this, other)) return true;

    return other.front == front && other.back == back;
  }

  @override
  int get hashCode => front.hashCode ^ back.hashCode;
}
