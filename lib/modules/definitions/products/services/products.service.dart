import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/products/models/product/product.model.dart';
import 'package:rst/utils/constants/api/api.constant.dart';

class ProductsServices {
  static const route = '/products';

  static Future<ServiceResponse> create({
    required Product product,
  }) async {
    try {
      final response = await RSTApiConstants.dio.post(
        route,
        data: product.toMap(),
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
          en: 'The product have been added successfully',
          fr: 'Le produit a été ajouté avec succès',
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
    required int productId,
  }) async {
    try {
      final response = await RSTApiConstants.dio.get(
        '$route/$productId',
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
      final response = await RSTApiConstants.dio.get(
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
      final response = await RSTApiConstants.dio.get(
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
      final response = await RSTApiConstants.dio.get(
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
    required int productId,
    required Product product,
  }) async {
    try {
      final response = await RSTApiConstants.dio.patch(
        '$route/$productId',
        data: product.toMap(),
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
          en: 'The product have been updated successfully',
          fr: 'Le produit a été mis à jour avec succès',
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
    required int productId,
  }) async {
    try {
      final response = await RSTApiConstants.dio.delete(
        '$route/$productId',
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
          en: 'The product have been deleted successfully',
          fr: 'Le produit a été supprimé avec succès',
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
