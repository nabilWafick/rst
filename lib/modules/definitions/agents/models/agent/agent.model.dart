// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Agent {
  final int? id;
  final String name;
  final String firstnames;
  final String phoneNumber;
  final String email;
  final String address;
  final String? profile;
  final Map<String, dynamic> permissions;
  final DateTime createdAt;
  final DateTime updatedAt;
  Agent({
    this.id,
    required this.name,
    required this.firstnames,
    required this.phoneNumber,
    required this.email,
    required this.address,
    this.profile,
    required this.permissions,
    required this.createdAt,
    required this.updatedAt,
  });

  Agent copyWith({
    int? id,
    String? name,
    String? firstnames,
    String? phoneNumber,
    String? email,
    String? address,
    String? profile,
    Map<String, dynamic>? permissions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Agent(
      id: id ?? this.id,
      name: name ?? this.name,
      firstnames: firstnames ?? this.firstnames,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      address: address ?? this.address,
      profile: profile ?? this.profile,
      permissions: permissions ?? this.permissions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'firstnames': firstnames,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'profile': profile,
      'permissions': json.encode(permissions),
    };
  }

  factory Agent.fromMap(Map<String, dynamic> map) {
    return Agent(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      firstnames: map['firstnames'] as String,
      phoneNumber: map['phoneNumber'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      profile: map['profile'] != null ? map['profile'] as String : null,
      permissions: Map<String, dynamic>.from(
        map['permissions'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Agent.fromJson(String source) =>
      Agent.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Agent(id: $id, name: $name, firstnames: $firstnames, phoneNumber: $phoneNumber, email: $email, address: $address, profile: $profile, permissions: $permissions, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Agent other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.firstnames == firstnames &&
        other.phoneNumber == phoneNumber &&
        other.email == email &&
        other.address == address &&
        other.profile == profile &&
        mapEquals(other.permissions, permissions) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        firstnames.hashCode ^
        phoneNumber.hashCode ^
        email.hashCode ^
        address.hashCode ^
        profile.hashCode ^
        permissions.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
