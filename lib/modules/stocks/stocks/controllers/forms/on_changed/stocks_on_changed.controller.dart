import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/modules/stocks/stocks/providers/stocks.provider.dart';

class StockOnChanged {
  static stockInputQuantity(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        stockInputQuantityProvider,
      );

  static stockOutputQuantity(String? value, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        stockOutputQuantityProvider,
      );
}
