import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/economical_activities/providers/economical_activities.provider.dart';

class EconomicalActivityValidators {
  static String? economicalActivityName(String? value, WidgetRef ref) {
    if (ref.watch(economicalActivityNameProvider).trim() == '') {
      return 'Entrez le nom d\'une activité économique';
    } else if (ref.watch(economicalActivityNameProvider).length < 3) {
      return "Le nom de l'activité économique doit contenir au moins 3 lettres";
    }
    return null;
  }
}
