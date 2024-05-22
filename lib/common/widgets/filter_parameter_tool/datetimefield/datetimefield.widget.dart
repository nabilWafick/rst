import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/utils/utils.dart';

final filterParameterToolDateTimeFieldProvider =
    StateProvider.family<DateTime, String>((ref, providerName) {
  return DateTime.now();
});

class FilterParameterToolDateTimeField extends HookConsumerWidget {
  final String providerName;
  const FilterParameterToolDateTimeField({
    super.key,
    required this.providerName,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDateTime =
        ref.watch(filterParameterToolDateTimeFieldProvider(providerName));
    final format = DateFormat.yMMMMEEEEd('fr');
    final formatedDate = format.format(selectedDateTime);
    final formatedTime = FunctionsController.getFormatedTime(
      dateTime: selectedDateTime,
    );
    return InkWell(
      onTap: () {
        FunctionsController.showDateTime(
          context: context,
          ref: ref,
          stateProvider: filterParameterToolDateTimeFieldProvider(providerName),
          isNullable: false,
        );
      },
      splashColor: RSTColors.primaryColor.withOpacity(.15),
      hoverColor: RSTColors.primaryColor.withOpacity(.1),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: RSTColors.primaryColor,
          ),
        ),
        child: RSTText(
          text: '$formatedDate $formatedTime',
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
