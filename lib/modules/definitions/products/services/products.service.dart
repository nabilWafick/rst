import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rst/modules/definitions/products/models/data/product.model.dart';
import 'package:rst/utils/constants/api/api.constant.dart';

class ProductsServices {
  static create({
    required Product product,
  }) async {
    try {
      // 404
      final response = await RSTApiConstants.dio.get(
        '/products',
        /*  data: product.toMap(
            isAdding: true,
          ),*/
        queryParameters: {
          'skip': 0,
          'take': 10,
        },
      );

      debugPrint(
        response.toString(),
      );
    } on DioException catch (error) {
      if (error.response != null) {
        debugPrint(
          error.response?.data.toString(),
        );
        debugPrint(
          error.response?.headers.toString(),
        );
        debugPrint(
          error.response?.requestOptions.toString(),
        );
      } else {
        debugPrint(
          error.requestOptions.toString(),
        );
        debugPrint(error.message);
      }
    }
  }
}
