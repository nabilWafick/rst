// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:rst/common/models/service_response/service_error/service_error.model.dart';
import 'package:rst/common/models/service_response/service_message/service_message.model.dart';
import 'package:rst/common/models/service_response/service_result/service_result.model.dart';

class ServiceResponse {
  final int statusCode;
  final dynamic data;
  final ServiceResult? result;
  final ServiceError? error;
  final ServiceMessage? message;
  ServiceResponse({
    required this.statusCode,
    required this.data,
    this.result,
    this.error,
    this.message,
  });

  ServiceResponse copyWith({
    int? statusCode,
    dynamic data,
    ServiceResult? result,
    ServiceError? error,
    ServiceMessage? message,
  }) {
    return ServiceResponse(
      statusCode: statusCode ?? this.statusCode,
      data: data ?? this.data,
      result: result ?? this.result,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'data': data,
      'result': result?.toMap(),
      'error': error?.toMap(),
      'message': message?.toMap(),
    };
  }

  factory ServiceResponse.fromMap(Map<String, dynamic> map) {
    return ServiceResponse(
      statusCode: map['statusCode'] as int,
      data: map['data'] as dynamic,
      result: map['result'] != null
          ? ServiceResult.fromMap(map['result'] as Map<String, dynamic>)
          : null,
      error: map['error'] != null
          ? ServiceError.fromMap(map['error'] as Map<String, dynamic>)
          : null,
      message: map['message'] != null
          ? ServiceMessage.fromMap(map['message'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceResponse.fromJson(String source) =>
      ServiceResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ServiceResponse(statusCode: $statusCode, data: $data, result: $result, error: $error, message: $message)';
  }

  @override
  bool operator ==(covariant ServiceResponse other) {
    if (identical(this, other)) return true;

    return other.statusCode == statusCode &&
        other.data == data &&
        other.result == result &&
        other.error == error &&
        other.message == message;
  }

  @override
  int get hashCode {
    return statusCode.hashCode ^
        data.hashCode ^
        result.hashCode ^
        error.hashCode ^
        message.hashCode;
  }
}
