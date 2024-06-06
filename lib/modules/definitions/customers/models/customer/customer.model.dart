// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rst/modules/definitions/categories/models/category/category.model.dart';
import 'package:rst/modules/definitions/collectors/models/collectors.model.dart';
import 'package:rst/modules/definitions/economical_activities/models/economical_activity/economical_activity.model.dart';
import 'package:rst/modules/definitions/localities/models/localities.model.dart';
import 'package:rst/modules/definitions/personal_status/models/personal_status/personal_status.model.dart';

import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

class Customer {
  final int? id;
  final String name;
  final String firstnames;
  final String phoneNumber;
  final String address;
  final String? occupation;
  final int? nicNumber;
  final Collector? collector;
  final Category? category;
  final EconomicalActivity? economicalActivity;
  final PersonalStatus? personalStatus;
  final Locality? locality;
  List<Card>? cards;
  final String? profile;
  final String? signature;
  final DateTime createdAt;
  final DateTime updatedAt;
  Customer({
    this.id,
    required this.name,
    required this.firstnames,
    required this.phoneNumber,
    required this.address,
    this.occupation,
    this.nicNumber,
    this.collector,
    this.category,
    this.economicalActivity,
    this.personalStatus,
    this.locality,
    this.profile,
    this.signature,
    this.cards,
    required this.createdAt,
    required this.updatedAt,
  });

  Customer copyWith({
    int? id,
    String? name,
    String? firstnames,
    String? phoneNumber,
    String? address,
    String? occupation,
    int? nicNumber,
    Collector? collector,
    Category? category,
    EconomicalActivity? economicalActivity,
    PersonalStatus? personalStatus,
    Locality? locality,
    List<Card>? cards,
    String? profile,
    String? signature,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      firstnames: firstnames ?? this.firstnames,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      occupation: occupation ?? this.occupation,
      nicNumber: nicNumber ?? this.nicNumber,
      collector: collector ?? this.collector,
      category: category ?? this.category,
      economicalActivity: economicalActivity ?? this.economicalActivity,
      personalStatus: personalStatus ?? this.personalStatus,
      locality: locality ?? this.locality,
      profile: profile ?? this.profile,
      cards: cards ?? this.cards,
      signature: signature ?? this.signature,
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
      'occupation': occupation,
      'nicNumber': nicNumber,
      'collectorId': collector?.id,
      'categoryId': category?.id,
      'economicalActivityId': economicalActivity?.id,
      'personalStatusId': personalStatus?.id,
      'localityId': locality?.id,
      'profile': profile,
      'signature': signature,
      'cards': cards
          ?.map(
            (card) => card.toMap(),
          )
          .toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      firstnames: map['firstnames'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      occupation:
          map['occupation'] != null ? map['occupation'] as String : null,
      nicNumber: map['nicNumber'] != null ? map['nicNumber'] as int : null,
      collector: map['collector'] != null
          ? Collector.fromMap(map['collector'] as Map<String, dynamic>)
          : null,
      category: map['category'] != null
          ? Category.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      economicalActivity: map['economicalActivity'] != null
          ? EconomicalActivity.fromMap(
              map['economicalActivity'] as Map<String, dynamic>)
          : null,
      personalStatus: map['personalStatus'] != null
          ? PersonalStatus.fromMap(
              map['personalStatus'] as Map<String, dynamic>)
          : null,
      locality: map['locality'] != null
          ? Locality.fromMap(map['locality'] as Map<String, dynamic>)
          : null,
      profile: map['profile'] != null ? map['profile'] as String : null,
      signature: map['signature'] != null ? map['signature'] as String : null,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, firstnames: $firstnames, phoneNumber: $phoneNumber, address: $address, occupation: $occupation, nicNumber: $nicNumber, collector: $collector, category: $category, economicalActivity: $economicalActivity, personalStatus: $personalStatus, locality: $locality, profile: $profile, signature: $signature, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.firstnames == firstnames &&
        other.phoneNumber == phoneNumber &&
        other.address == address &&
        other.occupation == occupation &&
        other.nicNumber == nicNumber &&
        other.collector == collector &&
        other.category == category &&
        other.economicalActivity == economicalActivity &&
        other.personalStatus == personalStatus &&
        other.locality == locality &&
        other.profile == profile &&
        other.signature == signature &&
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
        occupation.hashCode ^
        nicNumber.hashCode ^
        collector.hashCode ^
        category.hashCode ^
        economicalActivity.hashCode ^
        personalStatus.hashCode ^
        locality.hashCode ^
        profile.hashCode ^
        signature.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
