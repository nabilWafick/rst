import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/definitions/types/models/type/type.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class TypeBox extends ConsumerWidget {
  final Type customerCardType;
  const TypeBox({
    super.key,
    required this.customerCardType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 7.0,
      color: RSTColors.primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: RSTText(
          text: customerCardType.name,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
