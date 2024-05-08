import 'dart:convert';

class ServiceMessage {
  final String en;
  final String fr;
  ServiceMessage({
    required this.en,
    required this.fr,
  });

  ServiceMessage copyWith({
    String? en,
    String? fr,
  }) {
    return ServiceMessage(
      en: en ?? this.en,
      fr: fr ?? this.fr,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'en': en,
      'fr': fr,
    };
  }

  factory ServiceMessage.fromMap(Map<String, dynamic> map) {
    return ServiceMessage(
      en: map['en'] as String,
      fr: map['fr'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceMessage.fromJson(String source) =>
      ServiceMessage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ServiceMessage(en: $en, fr: $fr)';

  @override
  bool operator ==(covariant ServiceMessage other) {
    if (identical(this, other)) return true;

    return other.en == en && other.fr == fr;
  }

  @override
  int get hashCode => en.hashCode ^ fr.hashCode;
}
