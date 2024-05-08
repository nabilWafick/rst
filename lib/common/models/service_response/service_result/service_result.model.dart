import 'dart:convert';

import 'package:rst/common/models/service_response/service_message/service_message.model.dart';

class ServiceResult extends ServiceMessage {
  ServiceResult({
    required super.en,
    required super.fr,
  });

  factory ServiceResult.fromMap(Map<String, dynamic> map) {
    return ServiceResult(
      en: map['en'] as String,
      fr: map['fr'] as String,
    );
  }

  factory ServiceResult.fromJson(String source) =>
      ServiceResult.fromMap(json.decode(source) as Map<String, dynamic>);
}
