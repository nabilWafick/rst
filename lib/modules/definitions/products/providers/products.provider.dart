import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/products/controllers/products.controller.dart';
import 'package:rst/modules/definitions/products/models/product/product.model.dart';

// used for storing product name (form)
final productNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing product purchase price (form)
final productPurchasePriceProvider = StateProvider<double>(
  (ref) {
    return .0;
  },
);

// used for storing product photo (form)
final productPhotoProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

// used for storing products filter options
final productsFilterOptionsProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
  };
});

// used for storing fetched products
final productsListStreamProvider = FutureProvider<List<Product>>((ref) async {
  final filterOptions = ref.watch(productsFilterOptionsProvider);

  final controllerResponse = await ProductsController.getMany(
    filterOptions: filterOptions,
  );

  return controllerResponse.data != null
      ? List<Product>.from(controllerResponse.data)
      : <Product>[];
});
