// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardDataStat {
  final String label;
  final int typesNumber;
  final int totalSettlementNumber;
  final double totalSettlementAmount;
  CardDataStat({
    required this.label,
    required this.typesNumber,
    required this.totalSettlementNumber,
    required this.totalSettlementAmount,
  });

  CardDataStat copyWith({
    String? label,
    int? typesNumber,
    int? totalSettlementNumber,
    double? totalSettlementAmount,
  }) {
    return CardDataStat(
      label: label ?? this.label,
      typesNumber: typesNumber ?? this.typesNumber,
      totalSettlementNumber:
          totalSettlementNumber ?? this.totalSettlementNumber,
      totalSettlementAmount:
          totalSettlementAmount ?? this.totalSettlementAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'label': label,
      'typesNumber': typesNumber,
      'totalSettlementNumber': totalSettlementNumber,
      'totalSettlementAmount': totalSettlementAmount,
    };
  }

  factory CardDataStat.fromMap(Map<String, dynamic> map) {
    return CardDataStat(
      label: map['label'] as String,
      typesNumber: map['typesNumber'] as int,
      totalSettlementNumber: map['totalSettlementNumber'] as int,
      totalSettlementAmount: map['totalSettlementAmount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CardDataStat.fromJson(String source) =>
      CardDataStat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardDataStat(label: $label, typesNumber: $typesNumber, totalSettlementNumber: $totalSettlementNumber, totalSettlementAmount: $totalSettlementAmount)';
  }

  @override
  bool operator ==(covariant CardDataStat other) {
    if (identical(this, other)) return true;

    return other.label == label &&
        other.typesNumber == typesNumber &&
        other.totalSettlementNumber == totalSettlementNumber &&
        other.totalSettlementAmount == totalSettlementAmount;
  }

  @override
  int get hashCode {
    return label.hashCode ^
        typesNumber.hashCode ^
        totalSettlementNumber.hashCode ^
        totalSettlementAmount.hashCode;
  }
}
