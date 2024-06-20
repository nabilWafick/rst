import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/registration/providers/registration.provider.dart';

class RegistrationValidators {
  static String? newUserEmail(String? value, WidgetRef ref) {
    if (!isValidEmail(ref.watch(newUserEmailProvider))) {
      return 'Entrez un email valide';
    }
    return null;
  }

  static String? newUserPassword(String? value, WidgetRef ref) {
    if (ref.watch(newUserPasswordProvider).trim() == '') {
      return 'Entrez un mot de passe';
    } else if (ref.watch(newUserPasswordProvider).trim().length < 3) {
      return "Le mot de passe doit contenir au moins 7 caractères";
    }
    return null;
  }

  static bool isValidEmail(String email) {
    RegExp emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    return emailRegExp.hasMatch(email);
  }
}
