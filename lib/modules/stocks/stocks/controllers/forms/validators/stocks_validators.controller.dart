import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/stocks/stocks/providers/stocks.provider.dart';

class StockValidors {
  static String? stockInputQuantity(String? value, WidgetRef ref) {
    final stockInputQuantity = ref.watch(stockInputQuantityProvider);
    if (stockInputQuantity <= 0) {
      return 'Entrez un nombre supérieur ou égal à 1';
    }

    return null;
  }

  static String? stockOutputQuantity(String? value, WidgetRef ref) {
    final stockOutputQuantity = ref.watch(stockOutputQuantityProvider);
    if (stockOutputQuantity <= 0) {
      return 'Entrez un nombre supérieur ou égal à 1';
    }

    return null;
  }
}
