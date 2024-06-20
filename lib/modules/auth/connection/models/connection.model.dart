// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AuthConnection {
  final String email;
  final String password;

  const AuthConnection({
    required this.email,
    required this.password,
  });

  AuthConnection copyWith({
    String? email,
    String? password,
  }) {
    return AuthConnection(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory AuthConnection.fromMap(Map<String, dynamic> map) {
    return AuthConnection(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthConnection.fromJson(String source) =>
      AuthConnection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AuthConnection(email: $email, password: $password, )';

  @override
  bool operator ==(covariant AuthConnection other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
