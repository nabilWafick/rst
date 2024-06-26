import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';
import 'package:rst/utils/constants/api/api.constant.dart';
import 'package:rst/utils/constants/preferences_keys/preferences_keys.constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomersServices {
  static const route = '/customers';

  static Future<ServiceResponse> create({
    required Customer customer,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final accessToken = prefs.getString(RSTPreferencesKeys.accesToken);

      final headers = {'Authorization': 'Bearer $accessToken'};

      final response = await Dio(
        BaseOptions(
          baseUrl: RSTApiConstants.apiBaseUrl ?? '',
          headers: headers,
          connectTimeout: RSTApiConstants.connectionTimeoutDuration,
          receiveTimeout: RSTApiConstants.receiveTimeoutDuration,
        ),
      ).post(
        route,
        data: customer.toMap(),
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
          en: 'The customer have been added successfully',
          fr: 'Le client a été ajouté avec succès',
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

  static Future<ServiceResponse> getOne({
    required int customerId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final accessToken = prefs.getString(RSTPreferencesKeys.accesToken);

      final headers = {'Authorization': 'Bearer $accessToken'};

      final response = await Dio(
        BaseOptions(
          baseUrl: RSTApiConstants.apiBaseUrl ?? '',
          headers: headers,
          connectTimeout: RSTApiConstants.connectionTimeoutDuration,
          receiveTimeout: RSTApiConstants.receiveTimeoutDuration,
        ),
      ).get(
        '$route/$customerId',
      );

      return ServiceResponse(
        statusCode: 200,
        data: [
          response.data,
        ],
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

  static Future<ServiceResponse> getMany({
    required Map<String, dynamic> listParameters,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final accessToken = prefs.getString(RSTPreferencesKeys.accesToken);

      final headers = {'Authorization': 'Bearer $accessToken'};

      final response = await Dio(
        BaseOptions(
          baseUrl: RSTApiConstants.apiBaseUrl ?? '',
          headers: headers,
          connectTimeout: RSTApiConstants.connectionTimeoutDuration,
          receiveTimeout: RSTApiConstants.receiveTimeoutDuration,
        ),
      ).get(
        route,
        queryParameters: listParameters,
      );

      return ServiceResponse(
        statusCode: 200,
        data: response.data,
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

  static Future<ServiceResponse> countAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final accessToken = prefs.getString(RSTPreferencesKeys.accesToken);

      final headers = {'Authorization': 'Bearer $accessToken'};

      final response = await Dio(
        BaseOptions(
          baseUrl: RSTApiConstants.apiBaseUrl ?? '',
          headers: headers,
          connectTimeout: RSTApiConstants.connectionTimeoutDuration,
          receiveTimeout: RSTApiConstants.receiveTimeoutDuration,
        ),
      ).get(
        '$route/count/all',
      );

      return ServiceResponse(
        statusCode: 200,
        data: response.data,
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

  static Future<ServiceResponse> countSpecific({
    required Map<String, dynamic> listParameters,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final accessToken = prefs.getString(RSTPreferencesKeys.accesToken);

      final headers = {'Authorization': 'Bearer $accessToken'};

      final response = await Dio(
        BaseOptions(
          baseUrl: RSTApiConstants.apiBaseUrl ?? '',
          headers: headers,
          connectTimeout: RSTApiConstants.connectionTimeoutDuration,
          receiveTimeout: RSTApiConstants.receiveTimeoutDuration,
        ),
      ).get(
        '$route/count/specific',
        queryParameters: listParameters,
      );

      return ServiceResponse(
        statusCode: 200,
        data: response.data,
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

  static Future<ServiceResponse> update({
    required int customerId,
    required Customer customer,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final accessToken = prefs.getString(RSTPreferencesKeys.accesToken);

      final headers = {'Authorization': 'Bearer $accessToken'};

      final response = await Dio(
        BaseOptions(
          baseUrl: RSTApiConstants.apiBaseUrl ?? '',
          headers: headers,
          connectTimeout: RSTApiConstants.connectionTimeoutDuration,
          receiveTimeout: RSTApiConstants.receiveTimeoutDuration,
        ),
      ).patch(
        '$route/$customerId',
        data: customer.toMap(),
      );

      return ServiceResponse(
        statusCode: 200,
        data: [
          response.data,
        ],
        result: ServiceResult(
          en: 'Updated',
          fr: 'Modifié',
        ),
        message: ServiceMessage(
          en: 'The customer have been updated successfully',
          fr: 'Le client a été mis à jour avec succès',
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

  static Future<ServiceResponse> delete({
    required int customerId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final accessToken = prefs.getString(RSTPreferencesKeys.accesToken);

      final headers = {'Authorization': 'Bearer $accessToken'};

      final response = await Dio(
        BaseOptions(
          baseUrl: RSTApiConstants.apiBaseUrl ?? '',
          headers: headers,
          connectTimeout: RSTApiConstants.connectionTimeoutDuration,
          receiveTimeout: RSTApiConstants.receiveTimeoutDuration,
        ),
      ).delete(
        '$route/$customerId',
      );

      return ServiceResponse(
        statusCode: 200,
        data: [
          response.data,
        ],
        result: ServiceResult(
          en: 'Deleted',
          fr: 'Supprimé',
        ),
        message: ServiceMessage(
          en: 'The customer have been deleted successfully',
          fr: 'Le client a été supprimé avec succès',
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
}
