import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';

class CardValidors {
  static String? cardLabel(String? value, WidgetRef ref) {
    final cardLabel = ref.watch(cardLabelProvider);
    if (cardLabel == '') {
      return 'Entrez un libellé valide';
    } else if (cardLabel.length < 5) {
      return 'Le libellé doit contenir au moins 8 lettres';
    }
    return null;
  }

  static String? cardTypesNumber(String? value, WidgetRef ref) {
    final cardLabel = ref.watch(cardTypesNumberProvider);
    if (cardLabel < 1) {
      return 'Le nombre de type doit être supérieur ou égal à 1';
    }
    return null;
  }
}
