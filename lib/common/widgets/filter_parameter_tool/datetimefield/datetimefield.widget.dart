import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/utils/utils.dart';

final filterParameterToolDateTimeFieldValueProvider =
    StateProvider.family<DateTime, String>((ref, providerName) {
  return DateTime.now();
});

class FilterParameterToolDateTimeField extends StatefulHookConsumerWidget {
  final String? initialValue;
  final String providerName;
  const FilterParameterToolDateTimeField({
    super.key,
    this.initialValue,
    required this.providerName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterParameterToolDateTimeFieldState();
}

class _FilterParameterToolDateTimeFieldState
    extends ConsumerState<FilterParameterToolDateTimeField> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      if (widget.initialValue != null && mounted) {
        final isoStringDate = widget.initialValue!.split('Z')[0];

        ref
            .watch(filterParameterToolDateTimeFieldValueProvider(
                    widget.providerName)
                .notifier)
            .state = DateTime.parse(isoStringDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDateTime = ref.watch(
        filterParameterToolDateTimeFieldValueProvider(widget.providerName));
    final format = DateFormat.yMMMMEEEEd('fr');
    final formatedDate = format.format(selectedDateTime);
    final formatedTime = FunctionsController.getFormatedTime(
      dateTime: selectedDateTime,
    );
    return InkWell(
      onTap: () async {
        try {
          await FunctionsController.showDateTime(
            context: context,
            ref: ref,
            stateProvider: filterParameterToolDateTimeFieldValueProvider(
              widget.providerName,
            ),
            isNullable: false,
          );
        } catch (error) {
          debugPrint(error.toString());
        }
      },
      splashColor: RSTColors.primaryColor.withOpacity(.05),
      hoverColor: RSTColors.primaryColor.withOpacity(.05),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: RSTColors.primaryColor,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: RSTText(
          text: FunctionsController.truncateText(
            text: '$formatedDate $formatedTime',
            maxLength: 25,
          ),
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
