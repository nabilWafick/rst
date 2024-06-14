// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';
import 'package:rst/modules/statistics/types_stat/models/card_data_stat/card_data_stat.model.dart';

class CustomerStat {
  final Customer customer;
  final CardDataStat cardData;
  CustomerStat({
    required this.customer,
    required this.cardData,
  });

  CustomerStat copyWith({
    Customer? customer,
    CardDataStat? cardData,
  }) {
    return CustomerStat(
      customer: customer ?? this.customer,
      cardData: cardData ?? this.cardData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customer': customer.toMap(),
      'cardData': cardData.toMap(),
    };
  }

  factory CustomerStat.fromMap(Map<String, dynamic> map) {
    return CustomerStat(
      customer: Customer.fromMap(map['customer'] as Map<String, dynamic>),
      cardData: CardDataStat.fromMap(map['cardData'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerStat.fromJson(String source) =>
      CustomerStat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CustomerStat(customer: $customer, cardData: $cardData)';

  @override
  bool operator ==(covariant CustomerStat other) {
    if (identical(this, other)) return true;

    return other.customer == customer && other.cardData == cardData;
  }

  @override
  int get hashCode => customer.hashCode ^ cardData.hashCode;
}
