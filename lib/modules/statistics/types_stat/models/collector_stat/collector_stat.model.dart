// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';

import 'package:rst/modules/statistics/types_stat/models/customer_stat/customer_stat.model.dart';

class CollectorStat {
  final Collector collector;
  final List<CustomerStat> customersStats;
  CollectorStat({
    required this.collector,
    required this.customersStats,
  });

  CollectorStat copyWith({
    Collector? collector,
    List<CustomerStat>? customersStats,
  }) {
    return CollectorStat(
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

  factory CollectorStat.fromMap(Map<String, dynamic> map) {
    return CollectorStat(
      collector: Collector.fromMap(map['collector'] as Map<String, dynamic>),
      customersStats: List<CustomerStat>.from(
        (map['customersStats'] as List<int>).map<CustomerStat>(
          (x) => CustomerStat.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CollectorStat.fromJson(String source) =>
      CollectorStat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CollectorStat(collector: $collector, customersStats: $customersStats)';

  @override
  bool operator ==(covariant CollectorStat other) {
    if (identical(this, other)) return true;

    return other.collector == collector &&
        listEquals(other.customersStats, customersStats);
  }

  @override
  int get hashCode => collector.hashCode ^ customersStats.hashCode;
}
