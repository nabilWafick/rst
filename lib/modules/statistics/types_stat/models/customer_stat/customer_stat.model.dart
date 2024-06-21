// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';
import 'package:rst/modules/statistics/types_stat/models/card_data_stat/card_data_stat.model.dart';

class CustomerStatType {
  final Customer customer;
  final CardDataStatType cardData;
  CustomerStatType({
    required this.customer,
    required this.cardData,
  });

  CustomerStatType copyWith({
    Customer? customer,
    CardDataStatType? cardData,
  }) {
    return CustomerStatType(
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

  factory CustomerStatType.fromMap(Map<String, dynamic> map) {
    return CustomerStatType(
      customer: Customer.fromMap(map['customer'] as Map<String, dynamic>),
      cardData:
          CardDataStatType.fromMap(map['cardData'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerStatType.fromJson(String source) =>
      CustomerStatType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CustomerStatType(customer: $customer, cardData: $cardData)';

  @override
  bool operator ==(covariant CustomerStatType other) {
    if (identical(this, other)) return true;

    return other.customer == customer && other.cardData == cardData;
  }

  @override
  int get hashCode => customer.hashCode ^ cardData.hashCode;
}
