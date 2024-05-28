import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/categories/providers/categories.provider.dart';

class CategoryValidators {
  static String? categoryName(String? value, WidgetRef ref) {
    if (ref.watch(categoryNameProvider).trim() == '') {
      return 'Entrez le nom d\'une categorie';
    } else if (ref.watch(categoryNameProvider).length < 3) {
      return "Le nom de la categorie doit contenir au moins 3 lettres";
    }
    return null;
  }
}
