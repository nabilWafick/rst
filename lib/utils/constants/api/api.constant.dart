import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RSTApiConstants {
  static final baseUrl = dotenv.env['API_BASE_URL'];
  static final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl ?? '',
      receiveTimeout: const Duration(
        minutes: 2,
      ),
    ),
  );
}
