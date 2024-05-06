import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';

class ProductValidators {
  static String? productName(String? value, WidgetRef ref) {
    if (ref.watch(productNameProvider).trim() == '') {
      return 'Entrez le nom d\'un produit';
    } else if (ref.watch(productNameProvider).length < 3) {
      return "Le nom du produit doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? productPurchasePrice(String? value, WidgetRef ref) {
    if (ref.watch(productPurchasePriceProvider) == .0) {
      return 'Entrez une valeur';
    }
    return null;
  }
}
