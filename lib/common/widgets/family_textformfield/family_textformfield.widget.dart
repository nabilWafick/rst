import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/utils/colors/colors.util.dart';

class FamilyTextFormField extends HookConsumerWidget {
  final String inputName;
  final TextEditingController? textEditingController;
  final String? label;
  final String? hintText;
  final String? initialValue;
  final IconData? suffixIcon;
  final bool? enabled;
  final TextInputType textInputType;
  final RoundedStyle roundedStyle;
  final String? Function({required dynamic value}) valueChecker;
  final String? Function(String?, String,
      String? Function({required dynamic value}), WidgetRef) validator;
  final void Function(String?, String, WidgetRef) onChanged;

  const FamilyTextFormField({
    super.key,
    required this.inputName,
    this.textEditingController,
    this.label,
    this.hintText,
    this.initialValue,
    this.suffixIcon,
    this.enabled,
    required this.textInputType,
    required this.roundedStyle,
    required this.valueChecker,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: textEditingController,
      initialValue: initialValue,
      keyboardType: textInputType,
      enabled: enabled,
      cursorColor: RSTColors.primaryColor,
      cursorHeight: 20.0,
      style: const TextStyle(
        fontSize: 12.0,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 18.5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: roundedStyle == RoundedStyle.full
              ? BorderRadius.circular(15.0)
              : roundedStyle == RoundedStyle.none
                  ? BorderRadius.circular(.0)
                  : BorderRadius.only(
                      topLeft: roundedStyle == RoundedStyle.onlyLeft
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      bottomLeft: roundedStyle == RoundedStyle.onlyLeft
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      topRight: roundedStyle == RoundedStyle.onlyRight
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      bottomRight: roundedStyle == RoundedStyle.onlyRight
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                    ),
          borderSide: const BorderSide(
            color: RSTColors.tertiaryColor,
            width: .5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: roundedStyle == RoundedStyle.full
              ? BorderRadius.circular(15.0)
              : roundedStyle == RoundedStyle.none
                  ? BorderRadius.circular(.0)
                  : BorderRadius.only(
                      topLeft: roundedStyle == RoundedStyle.onlyLeft
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      bottomLeft: roundedStyle == RoundedStyle.onlyLeft
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      topRight: roundedStyle == RoundedStyle.onlyRight
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      bottomRight: roundedStyle == RoundedStyle.onlyRight
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                    ),
          borderSide:
              const BorderSide(color: RSTColors.primaryColor, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: roundedStyle == RoundedStyle.full
              ? BorderRadius.circular(15.0)
              : roundedStyle == RoundedStyle.none
                  ? BorderRadius.circular(.0)
                  : BorderRadius.only(
                      topLeft: roundedStyle == RoundedStyle.onlyLeft
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      bottomLeft: roundedStyle == RoundedStyle.onlyLeft
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      topRight: roundedStyle == RoundedStyle.onlyRight
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      bottomRight: roundedStyle == RoundedStyle.onlyRight
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                    ),
          borderSide: const BorderSide(
            color: Colors.red,
            width: .5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: roundedStyle == RoundedStyle.full
              ? BorderRadius.circular(15.0)
              : roundedStyle == RoundedStyle.none
                  ? BorderRadius.circular(.0)
                  : BorderRadius.only(
                      topLeft: roundedStyle == RoundedStyle.onlyLeft
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      bottomLeft: roundedStyle == RoundedStyle.onlyLeft
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      topRight: roundedStyle == RoundedStyle.onlyRight
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      bottomRight: roundedStyle == RoundedStyle.onlyRight
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                    ),
          borderSide: const BorderSide(
            color: Colors.red,
            width: .5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: roundedStyle == RoundedStyle.full
              ? BorderRadius.circular(15.0)
              : roundedStyle == RoundedStyle.none
                  ? BorderRadius.circular(.0)
                  : BorderRadius.only(
                      topLeft: roundedStyle == RoundedStyle.onlyLeft
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      bottomLeft: roundedStyle == RoundedStyle.onlyLeft
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      topRight: roundedStyle == RoundedStyle.onlyRight
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                      bottomRight: roundedStyle == RoundedStyle.onlyRight
                          ? const Radius.circular(15.0)
                          : const Radius.circular(.0),
                    ),
          borderSide: const BorderSide(
            color: RSTColors.tertiaryColor,
            width: .5,
          ),
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
        return validator(value, inputName, valueChecker, ref);
      },
      onChanged: (newValue) {
        onChanged(newValue, inputName, ref);
      },
      onSaved: (newValue) {
        onChanged(newValue, inputName, ref);
      },
      enableSuggestions: true,
    );
  }
}
