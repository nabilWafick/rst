// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';

import 'package:rst/modules/statistics/types_stat/models/customer_stat/customer_stat.model.dart';

class CollectorStatType {
  final Collector collector;
  final List<CustomerStatType> customersStats;
  CollectorStatType({
    required this.collector,
    required this.customersStats,
  });

  CollectorStatType copyWith({
    Collector? collector,
    List<CustomerStatType>? customersStats,
  }) {
    return CollectorStatType(
      collector: collector ?? this.collector,
      customersStats: customersStats ?? this.customersStats,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'collector': collector.toMap(),
      'customersStats': customersStats
          .map((customersStats) => customersStats.toMap())
          .toList(),
    };
  }

  factory CollectorStatType.fromMap(Map<String, dynamic> map) {
    return CollectorStatType(
      collector: Collector.fromMap(map['collector'] as Map<String, dynamic>),
      customersStats: List<CustomerStatType>.from(
        (map['customersStats'] as List<int>).map<CustomerStatType>(
          (x) => CustomerStatType.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectorStatType.fromJson(String source) =>
      CollectorStatType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CollectorStatType(collector: $collector, customersStats: $customersStats)';

  @override
  bool operator ==(covariant CollectorStatType other) {
    if (identical(this, other)) return true;

    return other.collector == collector &&
        listEquals(other.customersStats, customersStats);
  }

  @override
  int get hashCode => collector.hashCode ^ customersStats.hashCode;
}
