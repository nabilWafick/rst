import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/agents/providers/agents.provider.dart';

class AgentValidators {
  static String? agentName(String? value, WidgetRef ref) {
    if (ref.watch(agentNameProvider).trim() == '') {
      return 'Entrez le nom de l\'agent';
    } else if (ref.watch(agentNameProvider).length < 3) {
      return "Le nom doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? agentFirstnames(String? value, WidgetRef ref) {
    if (ref.watch(agentFirstnamesProvider).trim() == '') {
      return 'Entrez le(s) prénom(s) de l\'agent';
    } else if (ref.watch(agentFirstnamesProvider).length < 3) {
      return "Le(s) prénom(s) doit contenir au moins 3 lettres";
    }
    return null;
  }

  static String? agentPhoneNumber(String? value, WidgetRef ref) {
    if (ref.watch(agentPhoneNumberProvider).trim() == '') {
      return 'Entrez le numéro de téléphone de  l\'agent';
    } else if (!RegExp(r'^(\+229|00229)[4569]\d{7}$')
        .hasMatch(ref.watch(agentPhoneNumberProvider))) {
      return "Le numéro de téléphone est incorrect";
    }
    return null;
  }

  static String? agentEmail(String? value, WidgetRef ref) {
    if (!isValidEmail(ref.watch(agentEmailProvider))) {
      return 'Entrez un email valide';
    }
    return null;
  }

  static String? agentAddress(String? value, WidgetRef ref) {
    if (ref.watch(agentAddressProvider).trim() == '') {
      return 'Entrez l\'adresse de l\'agent';
    } else if (ref.watch(agentAddressProvider).length < 3) {
      return "L'adresse doit contenir au moins 3 lettres";
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
