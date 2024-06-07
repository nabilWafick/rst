import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/products/controllers/products.controller.dart';
import 'package:rst/modules/definitions/products/models/product/product.model.dart';

final productSelectionToolProvider =
    StateProvider.family<Product?, String>((ref, toolName) {
  return;
});

// used for storing products filter options
final productsSelectionListParametersProvider =
    StateProvider.family<Map<String, dynamic>, String>((ref, toolName) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched products
final productsSelectionListStreamProvider =
    FutureProvider.family<List<Product>, String>((ref, toolName) async {
  final listParameters =
      ref.watch(productsSelectionListParametersProvider(toolName));

  final controllerResponse = await ProductsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Product>.from(controllerResponse.data)
      : <Product>[];
});

// used for storing fetched products (products respecting filter options) count
final specificProductsSelectionCountProvider =
    FutureProvider.family<int, String>((ref, toolName) async {
  final listParameters =
      ref.watch(productsSelectionListParametersProvider(toolName));

  final controllerResponse = await ProductsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
