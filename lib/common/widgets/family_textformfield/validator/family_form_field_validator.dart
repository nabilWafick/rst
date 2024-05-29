import 'package:flutter_riverpod/flutter_riverpod.dart';

final familyTextFormFieldValueProvider =
    StateProvider.family<String, String>((ref, inputProvider) {
  return '';
});

final familyIntFormFieldValueProvider =
    StateProvider.family<int, String>((ref, inputProvider) {
  return 0;
});

final familyDoubleFormFieldValueProvider =
    StateProvider.family<double, String>((ref, inputProvider) {
  return .0;
});

class FamilyFormFieldValidator {
  static String? textFieldValue(
    String? value,
    String inputProvider,
    String? Function({required String value}) textFieldValidator,
    WidgetRef ref,
  ) {
    return textFieldValidator(
      value: ref.watch(
        familyTextFormFieldValueProvider(inputProvider),
      ),
    );
  }

  static String? intFieldValue(
    String? value,
    String inputProvider,
    String? Function({required int value}) intFieldValidator,
    WidgetRef ref,
  ) {
    return intFieldValidator(
      value: ref.watch(
        familyIntFormFieldValueProvider(inputProvider),
      ),
    );
  }

  static String? doubleFieldValue(
    String? value,
    String inputProvider,
    String? Function({required double value}) doubleFieldValidator,
    WidgetRef ref,
  ) {
    return doubleFieldValidator(
      value: ref.watch(
        familyDoubleFormFieldValueProvider(inputProvider),
      ),
    );
  }
}
