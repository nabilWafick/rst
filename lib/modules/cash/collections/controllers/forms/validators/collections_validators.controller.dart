import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/collections/providers/collections.provider.dart';

class CollectionValidors {
  static String? collectionAmount(String? value, WidgetRef ref) {
    final collectionAmount = ref.watch(collectionAmountProvider);
    if (collectionAmount == .0) {
      return 'Entrez un montant valide';
    }
    return null;
  }
}
