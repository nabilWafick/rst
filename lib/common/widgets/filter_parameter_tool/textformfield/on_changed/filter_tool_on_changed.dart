import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/controllers/on_changed/common.on_changed.dart';
import 'package:rst/common/widgets/filter_parameter_tool/textformfield/validator/filter_tool_validator.dart';

class FilterParameterToolOnChanged {
  static textFieldValue(String? value, String inputProvider, WidgetRef ref) =>
      CommonOnChangedFunction.onStringTextInputValueChanged(
        value,
        ref,
        filterParameterToolTextFieldValueProvider(inputProvider),
      );
}
