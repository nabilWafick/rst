import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/products/controllers/products.controller.dart';
import 'package:rst/modules/definitions/products/models/product/product.model.dart';

final productSelectionToolProvider =
    StateProvider.family<Product?, String>((ref, toolName) {
  return;
});

// used for storing products filter options
final productsSelectionListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched products
final productsSelectionListStreamProvider =
    FutureProvider<List<Product>>((ref) async {
  final listParameters = ref.watch(productsSelectionListParametersProvider);

  final controllerResponse = await ProductsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Product>.from(controllerResponse.data)
      : <Product>[];
});

// used for storing fetched products (products respecting filter options) count
final specificProductsSelectionCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(productsSelectionListParametersProvider);

  final controllerResponse = await ProductsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
