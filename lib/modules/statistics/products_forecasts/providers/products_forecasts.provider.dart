import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/products/controllers/products.controller.dart';
import 'package:rst/modules/statistics/products_forecasts/models/filter_parameter/filter_parameter.model.dart';
import 'package:rst/modules/statistics/products_forecasts/models/product_forecast/product_forecast.model.dart';

// used for storing productsForecasts filter options
final productsForecastsListParametersProvider =
    StateProvider<ProductsForecastsFilter>((ref) {
  return ProductsForecastsFilter(
    totalSettlementNumber: 186,
    offset: 0,
    limit: 20,
  );
});

// used for storing fetched productsForecasts
final productsForecastsListStreamProvider =
    FutureProvider<List<ProductForecast>>((ref) async {
  final productsForecastsFilter =
      ref.watch(productsForecastsListParametersProvider);

  final controllerResponse = await ProductsController.getProductsForecasts(
    productsForecastsFilter: productsForecastsFilter,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<ProductForecast>.from(controllerResponse.data)
      : <ProductForecast>[];
});

// used for storing all productsForecasts of database count
final productsForecastsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse =
      await ProductsController.getProductsForecastsCountAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched productsForecasts (productsForecasts respecting filter options) count
final specificProductsForecastsCountProvider = FutureProvider<int>((ref) async {
  final productsForecastsFilter = ref.watch(
    productsForecastsListParametersProvider,
  );

  final controllerResponse =
      await ProductsController.getProductsForecastsCountSpecific(
    productsForecastsFilter: productsForecastsFilter,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
