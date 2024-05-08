import 'package:rst/common/models/controller_response/controller_response.model.dart';

import 'package:rst/modules/definitions/products/models/product/product.model.dart';
import 'package:rst/modules/definitions/products/services/products.service.dart';

class ProductsController {
  Future<ControllerResponse> create({
    required Product product,
  }) async {
    final serviceResponse = await ProductsServices.create(
      product: product,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data?.map(
        (productMap) => Product.fromMap(
          productMap,
        ),
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  Future<ControllerResponse> getOne({
    required int productId,
  }) async {
    final serviceResponse = await ProductsServices.getOne(
      productId: productId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data?.map(
        (productMap) => Product.fromMap(
          productMap,
        ),
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  Future<ControllerResponse> getMany({
    required Map<String, dynamic> filterOptions,
  }) async {
    final serviceResponse = await ProductsServices.getMany(
      filterOptions: filterOptions,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data?.map(
        (productMap) => Product.fromMap(
          productMap,
        ),
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  Future<ControllerResponse> update({
    required int productId,
    required Product product,
  }) async {
    final serviceResponse = await ProductsServices.update(
      productId: productId,
      product: product,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data?.map(
        (productMap) => Product.fromMap(
          productMap,
        ),
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  Future<ControllerResponse> delete({
    required int productId,
  }) async {
    final serviceResponse = await ProductsServices.getOne(
      productId: productId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data?.map(
        (productMap) => Product.fromMap(
          productMap,
        ),
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }
}
