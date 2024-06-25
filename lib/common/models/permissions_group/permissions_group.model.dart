import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:rst/common/models/permission/permission.model.dart';

class PermissionsGroup {
  final String name;
  final List<Permission> permissions;
  PermissionsGroup({
    required this.name,
    required this.permissions,
  });

  PermissionsGroup copyWith({
    String? name,
    List<Permission>? permissions,
  }) {
    return PermissionsGroup(
      name: name ?? this.name,
      permissions: permissions ?? this.permissions,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll(
      {
        'permissions': permissions
            .map(
              (permission) => permission.toMap(),
            )
            .toList(),
      },
    );

    return result;
  }

  factory PermissionsGroup.fromMap(Map<String, dynamic> map) {
    return PermissionsGroup(
      name: map['name'] ?? '',
      permissions: List<Permission>.from(
        map['permissions']?.map(
          (permission) => Permission.fromMap(permission),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PermissionsGroup.fromJson(String source) => PermissionsGroup.fromMap(
        json.decode(source),
      );

  @override
  String toString() =>
      'PermissionsGroup(name: $name, permissions: $permissions)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PermissionsGroup &&
        other.name == name &&
        listEquals(other.permissions, permissions);
  }

  @override
  int get hashCode => name.hashCode ^ permissions.hashCode;
}
