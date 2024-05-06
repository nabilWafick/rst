import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/products/models/data/product.model.dart';

final productNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final productPurchasePriceProvider = StateProvider<double>(
  (ref) {
    return .0;
  },
);

final productPhotoProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

final productsListStreamProvider = StreamProvider<List<Product>>((ref) async* {
  yield* <Product>[] as Stream<List<Product>>;
});
