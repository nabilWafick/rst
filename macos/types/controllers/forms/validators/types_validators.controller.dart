import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';

class TypeValidators {
  static String? typeName(String? value, WidgetRef ref) {
    if (ref.watch(typeNameProvider).trim() == '') {
      return 'Entrez le nom d\'un type';
    } else if (ref.watch(typeNameProvider).length < 3) {
      return "Le nom du type doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? typeStake(String? value, WidgetRef ref) {
    if (ref.watch(typeStakeProvider) == .0) {
      return 'Entrez une valeur';
    }
    return null;
  }
}
