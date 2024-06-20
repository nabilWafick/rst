// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class AuthRegistration {
  final String email;
  final String password;
  final Map<String, dynamic> securityQuestions;

  const AuthRegistration({
    required this.email,
    required this.password,
    required this.securityQuestions,
  });

  AuthRegistration copyWith({
    String? email,
    String? password,
    Map<String, dynamic>? securityQuestions,
  }) {
    return AuthRegistration(
      email: email ?? this.email,
      password: password ?? this.password,
      securityQuestions: securityQuestions ?? this.securityQuestions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'securityQuestions': json.encode(securityQuestions),
    };
  }

  factory AuthRegistration.fromMap(Map<String, dynamic> map) {
    return AuthRegistration(
      email: map['email'] as String,
      password: map['password'] as String,
      securityQuestions: Map<String, dynamic>.from(
        map['securityQuestions'] as Map<String, dynamic>,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRegistration.fromJson(String source) =>
      AuthRegistration.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AuthRegistration(email: $email, password: $password, securityQuestions: $securityQuestions)';

  @override
  bool operator ==(covariant AuthRegistration other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        mapEquals(other.securityQuestions, securityQuestions);
  }

  @override
  int get hashCode =>
      email.hashCode ^ password.hashCode ^ securityQuestions.hashCode;
}
