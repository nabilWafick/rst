// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Operator {
  final String front;
  final String back;
  Operator({
    required this.front,
    required this.back,
  });

  Operator copyWith({
    String? front,
    String? back,
  }) {
    return Operator(
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

  factory Operator.fromMap(Map<String, dynamic> map) {
    return Operator(
      front: map['front'] as String,
      back: map['back'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Operator.fromJson(String source) =>
      Operator.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Operator(front: $front, back: $back)';

  @override
  bool operator ==(covariant Operator other) {
    if (identical(this, other)) return true;

    return other.front == front && other.back == back;
  }

  @override
  int get hashCode => front.hashCode ^ back.hashCode;
}
