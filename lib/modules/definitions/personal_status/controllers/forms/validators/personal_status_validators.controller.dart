import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/personal_status/providers/personal_status.provider.dart';

class PersonalStatusValidators {
  static String? personalStatusName(String? value, WidgetRef ref) {
    if (ref.watch(personalStatusNameProvider).trim() == '') {
      return 'Entrez le nom d\'un statut personnel';
    } else if (ref.watch(personalStatusNameProvider).length < 3) {
      return "Le nom du statut personnel doit contenir au moins 3 lettres";
    }
    return null;
  }
}
