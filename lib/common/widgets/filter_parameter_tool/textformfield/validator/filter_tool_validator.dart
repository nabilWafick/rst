import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterParameterToolTextFieldValueProvider =
    StateProvider.family<String?, String>((ref, inputProvider) {
  return;
});

class FilterParameterToolValidator {
  static String? textFieldValue(String? value, String inputProvider, WidgetRef ref) {
    if (ref.watch(filterParameterToolTextFieldValueProvider(inputProvider))?.trim() == '') {
      return 'Entrez une valeur';
    }
    return null;
  }
}
