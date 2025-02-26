import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';
import 'package:rst/modules/definitions/products/services/products.service.dart';
import 'package:rst/modules/statistics/products_forecasts/models/filter_parameter/filter_parameter.model.dart';
import 'package:rst/modules/statistics/products_forecasts/models/product_forecast/product_forecast.model.dart';

class ProductsController {
  static Future<ControllerResponse> create({
    required Product product,
  }) async {
    final serviceResponse = await ProductsServices.create(
      product: product,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (productMap) => Product.fromMap(
              productMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getOne({
    required int productId,
  }) async {
    final serviceResponse = await ProductsServices.getOne(
      productId: productId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (productMap) => Product.fromMap(
              productMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getMany({
    required Map<String, dynamic> listParameters,
  }) async {
    final serviceResponse = await ProductsServices.getMany(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (productMap) => Product.fromMap(
              productMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> countAll({
    Map<String, dynamic>? listParameters,
  }) async {
    final serviceResponse = await ProductsServices.countAll(listParameters: listParameters);

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> countSpecific({
    required Map<String, dynamic> listParameters,
  }) async {
    final serviceResponse = await ProductsServices.countSpecific(
      listParameters: listParameters,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> update({
    required int productId,
    required Product product,
  }) async {
    final serviceResponse = await ProductsServices.update(
      productId: productId,
      product: product,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (productMap) => Product.fromMap(
              productMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> delete({
    required int productId,
  }) async {
    final serviceResponse = await ProductsServices.delete(
      productId: productId,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (productMap) => Product.fromMap(
              productMap,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getProductsForecasts({
    required ProductsForecastsFilter productsForecastsFilter,
  }) async {
    final serviceResponse = await ProductsServices.getProductsForecasts(
      productsForecastsFilter: productsForecastsFilter,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (productForecast) => ProductForecast.fromMap(
              productForecast,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getProductsForecastsCountAll() async {
    final serviceResponse = await ProductsServices.getProductsForecastsCountAll();

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getProductsForecastsTotalAmount() async {
    final serviceResponse = await ProductsServices.getProductsForecastsTotalAmount();

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getSpecificProductsForecastsCount({
    required ProductsForecastsFilter productsForecastsFilter,
  }) async {
    final serviceResponse = await ProductsServices.getSpecificProductsForecastsCount(
      productsForecastsFilter: productsForecastsFilter,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getSpecificProductsForecastsAmount({
    required ProductsForecastsFilter productsForecastsFilter,
  }) async {
    final serviceResponse = await ProductsServices.getSpecificProductsForecastsAmount(
      productsForecastsFilter: productsForecastsFilter,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  // **** IMPROVIDENCE
  static Future<ControllerResponse> getProductsImprovidence({
    required ProductsForecastsFilter productsImprovidenceFilter,
  }) async {
    final serviceResponse = await ProductsServices.getProductsImprovidence(
      productsImprovidenceFilter: productsImprovidenceFilter,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: serviceResponse.data
          ?.map(
            (productImprovidence) => ProductForecast.fromMap(
              productImprovidence,
            ),
          )
          .toList(),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getProductsImprovidenceCountAll() async {
    final serviceResponse = await ProductsServices.getProductsImprovidenceCountAll();

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getProductsImprovidenceTotalAmount() async {
    final serviceResponse = await ProductsServices.getProductsImprovidenceTotalAmount();

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getSpecificProductsImprovidenceCount({
    required ProductsForecastsFilter productsImprovidenceFilter,
  }) async {
    final serviceResponse = await ProductsServices.getSpecificProductsImprovidenceCount(
      productsImprovidenceFilter: productsImprovidenceFilter,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }

  static Future<ControllerResponse> getSpecificProductsImprovidenceAmount({
    required ProductsForecastsFilter productsImprovidenceFilter,
  }) async {
    final serviceResponse = await ProductsServices.getSpecificProductsImprovidenceAmount(
      productsImprovidenceFilter: productsImprovidenceFilter,
    );

    return ControllerResponse(
      statusCode: serviceResponse.statusCode,
      data: DataCount.fromMap(
        serviceResponse.data,
      ),
      result: serviceResponse.result,
      error: serviceResponse.error,
      message: serviceResponse.message,
    );
  }
}
