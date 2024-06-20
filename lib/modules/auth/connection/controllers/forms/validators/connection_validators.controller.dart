import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/connection/providers/connection.provider.dart';

class ConnectionValidators {
  static String? userEmail(String? value, WidgetRef ref) {
    if (!isValidEmail(ref.watch(userEmailProvider))) {
      return 'Entrez un email valide';
    }
    return null;
  }

  static String? userPassword(String? value, WidgetRef ref) {
    if (ref.watch(userPasswordProvider).trim().length < 7) {
      return "Entrez un mot de passe contenant au moins 7 caractères";
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
