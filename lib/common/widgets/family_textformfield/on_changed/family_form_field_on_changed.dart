import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';

class FamilyFormFieldOnChanged {
  static textFieldValue(String? value, String inputProvider, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        familyTextFormFieldValueProvider(inputProvider),
      );

  static intFieldValue(String? value, String inputProvider, WidgetRef ref) =>
      CommonOnChangedFunction.onIntTextInputValueChanged(
        value,
        ref,
        familyIntFormFieldValueProvider(inputProvider),
      );

  static doubleFieldValue(String? value, String inputProvider, WidgetRef ref) =>
      CommonOnChangedFunction.onDoubleTextInputValueChanged(
        value,
        ref,
        familyDoubleFormFieldValueProvider(inputProvider),
      );
}
