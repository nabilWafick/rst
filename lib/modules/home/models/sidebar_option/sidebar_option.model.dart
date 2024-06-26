import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:rst/modules/home/models/suboption/suboption.model.dart';

class SidebarOptionModel {
  final IconData icon;
  final String name;
  final List<SidebarSubOptionModel> subOptions;
  final List<bool> subOptionsVisibility;

  SidebarOptionModel({
    required this.icon,
    required this.name,
    required this.subOptions,
    required this.subOptionsVisibility,
  });

  SidebarOptionModel copyWith({
    IconData? icon,
    String? name,
    List<SidebarSubOptionModel>? subOptions,
    List<bool>? subOptionsVisibility,
  }) {
    return SidebarOptionModel(
      icon: icon ?? this.icon,
      name: name ?? this.name,
      subOptions: subOptions ?? this.subOptions,
      subOptionsVisibility: subOptionsVisibility ?? this.subOptionsVisibility,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': icon.codePoint,
      'name': name,
      'subOptions': subOptions.map((x) => x.toMap()).toList(),
      'subOptionsVisibility': subOptionsVisibility,
    };
  }

  factory SidebarOptionModel.fromMap(Map<String, dynamic> map) {
    return SidebarOptionModel(
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      name: map['name'] ?? '',
      subOptions: List<SidebarSubOptionModel>.from(
          map['subOptions']?.map((x) => SidebarSubOptionModel.fromMap(x))),
      subOptionsVisibility: List<bool>.from(map['subOptionsVisibility']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SidebarOptionModel.fromJson(String source) =>
      SidebarOptionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SidebarOptionModel(icon: $icon, name: $name, subOptions: $subOptions, subOptionsVisibility: $subOptionsVisibility)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is SidebarOptionModel &&
        other.icon == icon &&
        other.name == name &&
        listEquals(other.subOptions, subOptions) &&
        listEquals(other.subOptionsVisibility, subOptionsVisibility);
  }

  @override
  int get hashCode {
    return icon.hashCode ^
        name.hashCode ^
        subOptions.hashCode ^
        subOptionsVisibility.hashCode;
  }
}
