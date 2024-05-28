import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/collections/providers/collections.provider.dart';

class CollectionValidors {
  static String? collectionAmount(String? value, WidgetRef ref) {
    final collectionNumber = ref.watch(collectionAmountProvider);
    if (collectionNumber == .0) {
      return 'Entrez un montant valide';
    }
    return null;
  }
}
