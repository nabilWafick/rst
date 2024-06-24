import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RSTApiConstants {
  static final apiBaseUrl = dotenv.env['API_BASE_URL'];
  static final wsBaseUrl = dotenv.env['WS_BASE_URL'];
  static final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl ?? '',
      receiveTimeout: const Duration(
        minutes: 2,
      ),
      //   headers:
    ),
  );
}
