import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/utils/colors/colors.util.dart';

class RSTUnderlinedTextFormField extends ConsumerStatefulWidget {
  final IconData? icon;
  final IconData? suffixIcon;
  final String hintText;
  final int? maxLine;
  final bool obscureText;
  final String? Function(String?) validator;
  final TextInputType textInputType;
  final void Function(String) onChanged;
  const RSTUnderlinedTextFormField({
    super.key,
    this.icon,
    this.suffixIcon,
    this.maxLine,
    required this.hintText,
    required this.obscureText,
    required this.validator,
    required this.textInputType,
    required this.onChanged,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RSTUnderlinedTextFormFieldState();
}

class _RSTUnderlinedTextFormFieldState
    extends ConsumerState<RSTUnderlinedTextFormField> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      cursorColor: RSTColors.primaryColor,
      maxLines: widget.maxLine,
      //   style: const TextStyle(fontFamily: 'Poppins'),
      decoration: InputDecoration(
        icon: Icon(
          widget.icon,
          color: RSTColors.primaryColor,
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontFamily: 'Poppins',
        ),
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
                icon: Icon(showPassword
                    ? /*YaruIcons.hide*/ Icons.hide_source
                    : widget.suffixIcon),
              )
            : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(width: .5, color: Colors.black45),
          borderRadius: BorderRadius.circular(.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: RSTColors.primaryColor.withOpacity(.5),
          ),
          borderRadius: BorderRadius.circular(.0),
        ),
      ),
      obscureText: showPassword ? false : widget.obscureText,
      validator: (value) => widget.validator(value),
      onChanged: (value) => widget.onChanged(value),
    );
  }
}
