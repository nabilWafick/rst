import 'dart:convert';

import 'package:rst/common/models/service_response/service_message/service_message.model.dart';

class ServiceError extends ServiceMessage {
  ServiceError({
    required super.en,
    required super.fr,
  });

  factory ServiceError.fromMap(Map<String, dynamic> map) {
    return ServiceError(
      en: map['en'] as String,
      fr: map['fr'] as String,
    );
  }

  factory ServiceError.fromJson(String source) =>
      ServiceError.fromMap(json.decode(source) as Map<String, dynamic>);
}
