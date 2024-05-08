import 'package:flutter_riverpod/flutter_riverpod.dart';
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

// used for storing fetched products
final productsListStreamProvider = StreamProvider<List<Product>>((ref) async* {
  yield* Stream<List<Product>>.periodic(
    const Duration(seconds: 1),
    (x) => <Product>[],
  );
});
