import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';

class ProductOnChanged {
  static productName(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        productNameProvider,
      );

  static productPurchasePrice(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onDoubleTextInputValueChanged(
        value,
        ref,
        productPurchasePriceProvider,
      );
}
