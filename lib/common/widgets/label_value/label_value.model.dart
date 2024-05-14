import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LabelValue extends ConsumerWidget {
  final String label;
  final String value;
  final double? labelSize;
  final double? valueSize;
  final FontWeight? labelFontWeight;
  final FontWeight? valueFontWeight;
  const LabelValue({
    super.key,
    required this.label,
    required this.value,
    this.labelSize,
    this.valueSize,
    this.labelFontWeight,
    this.valueFontWeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: labelSize ?? 12,
            fontWeight: labelFontWeight ?? FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: valueSize ?? 12,
            fontWeight: valueFontWeight ?? FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
