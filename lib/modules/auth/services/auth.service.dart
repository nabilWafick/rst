import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/auth/connection/models/connection.model.dart';
import 'package:rst/modules/auth/registration/models/registration.model.dart';
import 'package:rst/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static const route = '/auth';

  static Future<ServiceResponse> register({
    required AuthRegistration authRegistration,
  }) async {
    try {
      final response = await RSTApiConstants.dio.post(
        '$route/register',
        data: authRegistration.toMap(),
      );

      return ServiceResponse(
        statusCode: 201,
        data: [
          response.data,
        ],
        result: ServiceResult(
          en: 'Added',
          fr: 'Ajouté',
        ),
        message: ServiceMessage(
          en: 'The account have been created successfully',
          fr: 'Le compte a été créé avec succès',
        ),
      );
    } on DioException catch (error) {
      if (error.response != null) {
        // server error
        debugPrint(error.response?.data.toString());

        return ServiceResponse.fromMap(error.response?.data);
      } else {
        // connection error
        debugPrint(error.response.toString());

        return ServiceResponse(
          statusCode: 503,
          data: null,
          error: ServiceError(
            en: 'Service Unavailable',
            fr: 'Service Indisponible',
          ),
          message: ServiceMessage(
            en: 'Unable to communicate with server',
            fr: 'Impossible de communiquer avec le serveur',
          ),
        );
      }
    }
  }

  static Future<ServiceResponse> connect({
    required AuthConnection authConnection,
  }) async {
    try {
      final response = await RSTApiConstants.dio.post(
        '$route/login',
        data: authConnection.toMap(),
      );

      return ServiceResponse(
        statusCode: 200,
        data: [
          response.data,
        ],
        result: ServiceResult(
          en: 'Connected',
          fr: 'Connecté',
        ),
        message: ServiceMessage(
          en: 'You have been succesfully login',
          fr: 'Vous avez été connecté avec succès',
        ),
      );
    } on DioException catch (error) {
      if (error.response != null) {
        // server error
        debugPrint(error.response?.data.toString());

        return ServiceResponse.fromMap(error.response?.data);
      } else {
        // connection error
        debugPrint(error.response.toString());

        return ServiceResponse(
          statusCode: 503,
          data: null,
          error: ServiceError(
            en: 'Service Unavailable',
            fr: 'Service Indisponible',
          ),
          message: ServiceMessage(
            en: 'Unable to communicate with server',
            fr: 'Impossible de communiquer avec le serveur',
          ),
        );
      }
    }
  }

  static Future<ServiceResponse> disconnect({
    required String userEmail,
  }) async {
    try {
      final response = await RSTApiConstants.dio.patch(
        '$route/logout',
        data: {
          'email': userEmail,
        },
      );

      return ServiceResponse(
        statusCode: 200,
        data: [
          response.data,
        ],
        result: ServiceResult(
          en: 'Disconnected',
          fr: 'Déconnecté',
        ),
        message: ServiceMessage(
          en: 'You have been succesfully disconnected',
          fr: 'Vous avez été déconnecté avec succès',
        ),
      );
    } on DioException catch (error) {
      if (error.response != null) {
        // server error
        debugPrint(error.response?.data.toString());

        return ServiceResponse.fromMap(error.response?.data);
      } else {
        // connection error
        debugPrint(error.response.toString());

        return ServiceResponse(
          statusCode: 503,
          data: null,
          error: ServiceError(
            en: 'Service Unavailable',
            fr: 'Service Indisponible',
          ),
          message: ServiceMessage(
            en: 'Unable to communicate with server',
            fr: 'Impossible de communiquer avec le serveur',
          ),
        );
      }
    }
  }

  static Future<void> protectedRoute() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final accessToken = prefs.getString(RSTPreferencesKeys.accesToken);

      final headers = {'Authorization': 'Bearer $accessToken'};

      debugPrint('headers: $headers');

      final response = await Dio(
        BaseOptions(
          baseUrl: RSTApiConstants.apiBaseUrl ?? '',
          headers: headers,
        ),
      ).get(
        '$route/protected-route',
      );

      debugPrint(
        'Protected Route Response: $response',
      );

      /* return ServiceResponse(
        statusCode: 200,
        data: [
          response.data,
        ],
        result: ServiceResult(
          en: 'Disconnected',
          fr: 'Déconnecté',
        ),
        message: ServiceMessage(
          en: 'You have been succesfully disconnected',
          fr: 'Vous avez été déconnecté avec succès',
        ),
      );*/
    } on DioException catch (error) {
      if (error.response != null) {
        // server error
        debugPrint(error.response?.data.toString());

        //  return ServiceResponse.fromMap(error.response?.data);
      } else {
        // connection error
        debugPrint(error.response.toString());

        /*  return ServiceResponse(
          statusCode: 503,
          data: null,
          error: ServiceError(
            en: 'Service Unavailable',
            fr: 'Service Indisponible',
          ),
          message: ServiceMessage(
            en: 'Unable to communicate with server',
            fr: 'Impossible de communiquer avec le serveur',
          ),
        );*/
      }
    }
  }
}
