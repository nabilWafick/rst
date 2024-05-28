import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/localities/providers/localities.provider.dart';

class LocalityValidators {
  static String? localityName(String? value, WidgetRef ref) {
    if (ref.watch(localityNameProvider).trim() == '') {
      return 'Entrez le nom d\'une localité';
    } else if (ref.watch(localityNameProvider).length < 3) {
      return "Le nom de la localité doit contenir au moins 3 lettres";
    }
    return null;
  }
}
