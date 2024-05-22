import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/utils/colors/colors.util.dart';

class FilterParameterToolNumberFormField extends HookConsumerWidget {
  final String inputProvider;
  final TextEditingController? textEditingController;
  final String? label;
  final String? hintText;
  final String? initialValue;
  final IconData? suffixIcon;
  final TextInputType textInputType;
  final String? Function(String?, String, WidgetRef) validator;
  final void Function(String?, String, WidgetRef) onChanged;
  const FilterParameterToolNumberFormField({
    super.key,
    required this.inputProvider,
    this.textEditingController,
    this.label,
    this.hintText,
    this.initialValue,
    this.suffixIcon,
    required this.textInputType,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: textEditingController,
      initialValue: initialValue,
      keyboardType: textInputType,
      cursorColor: RSTColors.primaryColor,
      cursorHeight: 20.0,
      style: const TextStyle(
        fontSize: 12.0,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        label: label != null
            ? RSTText(
                text: label!,
                // fontSize: 15.0,
              )
            : null,
        hintText: hintText,
      ),
      validator: (value) {
        return validator(value, inputProvider, ref);
      },
      onChanged: (newValue) {
        onChanged(newValue, inputProvider, ref);
      },
      onSaved: (newValue) {
        onChanged(newValue, inputProvider, ref);
      },
      enableSuggestions: true,
    );
  }
}
