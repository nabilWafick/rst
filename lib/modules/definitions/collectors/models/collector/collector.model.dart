// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Collector {
  final int? id;
  final String name;
  final String firstnames;
  final String phoneNumber;
  final String address;
  final String? profile;
  final DateTime createdAt;
  final DateTime updatedAt;
  Collector({
    this.id,
    required this.name,
    required this.firstnames,
    required this.phoneNumber,
    required this.address,
    this.profile,
    required this.createdAt,
    required this.updatedAt,
  });

  Collector copyWith({
    int? id,
    String? name,
    String? firstnames,
    String? phoneNumber,
    String? address,
    String? profile,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Collector(
      id: id ?? this.id,
      name: name ?? this.name,
      firstnames: firstnames ?? this.firstnames,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      profile: profile ?? this.profile,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'firstnames': firstnames,
      'phoneNumber': phoneNumber,
      'address': address,
      'profile': profile,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Collector.fromMap(Map<String, dynamic> map) {
    return Collector(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      firstnames: map['firstnames'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      profile: map['profile'] != null ? map['profile'] as String : null,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Collector.fromJson(String source) =>
      Collector.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Collector(id: $id, name: $name, firstnames: $firstnames, phoneNumber: $phoneNumber, address: $address, profile: $profile, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Collector other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.firstnames == firstnames &&
        other.phoneNumber == phoneNumber &&
        other.address == address &&
        other.profile == profile &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        firstnames.hashCode ^
        phoneNumber.hashCode ^
        address.hashCode ^
        profile.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
