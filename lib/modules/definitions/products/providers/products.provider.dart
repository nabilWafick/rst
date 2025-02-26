import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
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
final productsListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
    'orderBy': [
      {
        'id': 'desc',
      }
    ]
  };
});

// used for storing added filter tool
final productsListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing added sort tool
final productsListSortParametersAddedProvider =
    StateProvider<Map<String, Map<String, String>>>((ref) {
  return {};
});

// used for storing fetched products
final productsListStreamProvider = FutureProvider<List<Product>>((ref) async {
  final listParameters = ref.watch(productsListParametersProvider);

  final controllerResponse = await ProductsController.getMany(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<Product>.from(controllerResponse.data)
      : <Product>[];
});

// used for storing all products of database count
final productsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await ProductsController.countAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing all products of database count
final yearProductsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await ProductsController.countAll(listParameters: {
    'where': {
      'createdAt': {
        'gte': '${DateTime(DateTime.now().year).toIso8601String()}Z',
        'lt': '${DateTime(DateTime.now().year + 1).toIso8601String()}Z',
      },
    }
  });

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing fetched products (products respecting filter options) count
final specificProductsCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(productsListParametersProvider);

  final controllerResponse = await ProductsController.countSpecific(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});
