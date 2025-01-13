import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/products/controllers/products.controller.dart';
import 'package:rst/modules/statistics/products_forecasts/models/products_forecasts.model.dart';

// used for storing productsImprovidence filter options
final productsImprovidenceListParametersProvider = StateProvider<ProductsForecastsFilter>((ref) {
  return ProductsForecastsFilter(
    totalSettlementNumber: 30,
    offset: 0,
    limit: 20,
  );
});

// used for storing fetched productsImprovidence
final productsImprovidenceListStreamProvider = FutureProvider<List<ProductForecast>>((ref) async {
  final productsImprovidenceFilter = ref.watch(productsImprovidenceListParametersProvider);

  final controllerResponse = await ProductsController.getProductsImprovidence(
    productsImprovidenceFilter: productsImprovidenceFilter,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<ProductForecast>.from(controllerResponse.data)
      : <ProductForecast>[];
});

// used for storing all productsImprovidence of database count
final productsImprovidenceCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await ProductsController.getProductsImprovidenceCountAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing all productsImprovidence total amount
final productsImprovidenceTotalAmountProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await ProductsController.getProductsImprovidenceTotalAmount();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as num : 0;
});

// used for storing fetched productsImprovidence (productsImprovidence respecting filter options) count
final specificProductsImprovidenceCountProvider = FutureProvider<int>((ref) async {
  final productsImprovidenceFilter = ref.watch(
    productsImprovidenceListParametersProvider,
  );

  final controllerResponse = await ProductsController.getSpecificProductsImprovidenceCount(
    productsImprovidenceFilter: productsImprovidenceFilter,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing fetched productsImprovidence (productsImprovidence respecting filter options) count
final specificProductsImprovidenceAmountProvider = FutureProvider<num>((ref) async {
  final productsImprovidenceFilter = ref.watch(
    productsImprovidenceListParametersProvider,
  );

  final controllerResponse = await ProductsController.getSpecificProductsImprovidenceAmount(
    productsImprovidenceFilter: productsImprovidenceFilter,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as num : 0;
});
