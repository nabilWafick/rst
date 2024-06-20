import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';

import 'package:rst/modules/definitions/agents/models/agent/agent.model.dart';

class Auth {
  final int id;
  final Agent agent;
  final String password;
  final Map<String, dynamic> securityQuestions;
  final DateTime? lastLoginAt;
  final DateTime? passwordResetedAt;
  final String accessToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  Auth({
    required this.id,
    required this.agent,
    required this.password,
    required this.securityQuestions,
    this.lastLoginAt,
    this.passwordResetedAt,
    required this.accessToken,
    required this.createdAt,
    required this.updatedAt,
  });

  Auth copyWith({
    int? id,
    Agent? agent,
    String? password,
    Map<String, dynamic>? securityQuestions,
    DateTime? lastLoginAt,
    DateTime? passwordResetedAt,
    String? accessToken,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Auth(
      id: id ?? this.id,
      agent: agent ?? this.agent,
      password: password ?? this.password,
      securityQuestions: securityQuestions ?? this.securityQuestions,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      passwordResetedAt: passwordResetedAt ?? this.passwordResetedAt,
      accessToken: accessToken ?? this.accessToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'agent': agent.toMap()});
    result.addAll({'password': password});
    result.addAll({'securityQuestions': securityQuestions});
    if (lastLoginAt != null) {
      result.addAll(
        {
          'lastLoginAt': FunctionsController.getTimestamptzDateString(
            dateTime: lastLoginAt!,
          ),
        },
      );
    }
    if (passwordResetedAt != null) {
      result.addAll(
        {
          'passwordResetedAt': FunctionsController.getTimestamptzDateString(
            dateTime: passwordResetedAt!,
          ),
        },
      );
    }
    result.addAll({'accessToken': accessToken});

    return result;
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      id: map['id']?.toInt() ?? 0,
      agent: Agent.fromMap(map['agent']),
      password: map['password'] ?? '',
      securityQuestions: json.decode(map['securityQuestions'])

      /*  Map<String, dynamic>.from(
        map['securityQuestions'] as Map<String, dynamic>,
      )*/
      ,
      lastLoginAt: map['lastLoginAt'] != null
          ? DateTime.parse(map['lastLoginAt'])
          : null,
      passwordResetedAt: map['passwordResetedAt'] != null
          ? DateTime.parse(map['passwordResetedAt'])
          : null,
      accessToken: map['accessToken'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Auth.fromJson(String source) => Auth.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Auth(id: $id, agent: $agent, password: $password, securityQuestions: $securityQuestions, lastLoginAt: $lastLoginAt, passwordResetedAt: $passwordResetedAt, accessToken: $accessToken, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Auth &&
        other.id == id &&
        other.agent == agent &&
        other.password == password &&
        mapEquals(other.securityQuestions, securityQuestions) &&
        other.lastLoginAt == lastLoginAt &&
        other.passwordResetedAt == passwordResetedAt &&
        other.accessToken == accessToken &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        agent.hashCode ^
        password.hashCode ^
        securityQuestions.hashCode ^
        lastLoginAt.hashCode ^
        passwordResetedAt.hashCode ^
        accessToken.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
