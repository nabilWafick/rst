import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/customers/providers/customers.provider.dart';

class CustomerValidators {
  static String? customerName(String? value, WidgetRef ref) {
    if (ref.watch(customerNameProvider).trim() == '') {
      return 'Entrez le nom du client';
    } else if (ref.watch(customerNameProvider).length < 3) {
      return "Le nom doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? customerFirstnames(String? value, WidgetRef ref) {
    if (ref.watch(customerFirstnamesProvider).trim() == '') {
      return 'Entrez le(s) prénom(s) nom du client';
    } else if (ref.watch(customerFirstnamesProvider).length < 3) {
      return "Le(s) prénom(s) doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? customerPhoneNumber(String? value, WidgetRef ref) {
    if (ref.watch(customerPhoneNumberProvider).trim() == '') {
      return 'Entrez un numéro de téléphone';
    } else if (!RegExp(r'^(\+229|00229)[4569]\d{7}$')
        .hasMatch(ref.watch(customerPhoneNumberProvider))) {
      return "Le numéro de téléphone est incorrecte";
    }
    return null;
  }

  static String? customerAddress(String? value, WidgetRef ref) {
    if (ref.watch(customerAddressProvider).trim() == '') {
      return 'Entrez l\'adresse du client';
    } else if (ref.watch(customerAddressProvider).length < 5) {
      return "L'adresse doit contenir au moins 5 lettres";
    }
    return null;
  }

  static String? customerOccupation(String? value, WidgetRef ref) {
    if (ref.watch(customerOccupationProvider) != null &&
        ref.watch(customerOccupationProvider) != '' &&
        ref.watch(customerOccupationProvider)!.length < 5) {
      return "La profession doit contenir au moins 4 lettres";
    }
    return null;
  }

  static String? customerNicNumber(String? value, WidgetRef ref) {
    if (ref.watch(customerNicNumberProvider) != 0 &&
        ref.watch(customerNicNumberProvider).toString().length < 10) {
      return 'Entrez un numéro NCI valide';
    }
    return null;
  }
}
