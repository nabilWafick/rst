import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CashOperationsCollectorBox extends ConsumerWidget {
  final Collector? collector;
  const CashOperationsCollectorBox({super.key, this.collector});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashOperationsSelectedCollector =
        ref.watch(cashOperationsSelectedCollectorProvider);
    return Row(
      children: [
        Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              50.0,
            ),
            border: Border.all(
              color: RSTColors.sidebarTextColor.withOpacity(.5),
              width: 1.5,
            ),
          ),
          child: Center(
            child: cashOperationsSelectedCollector != null &&
                    cashOperationsSelectedCollector.profile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                      50.0,
                    ),
                    child: Image.asset(
                      cashOperationsSelectedCollector.profile!,
                    ),
                  )
                : const Center(
                    child: Icon(
                      Icons.person,
                      size: 30.0,
                      color: RSTColors.primaryColor,
                    ),
                  ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RSTText(
              text: FunctionsController.truncateText(
                text: cashOperationsSelectedCollector != null
                    ? '${cashOperationsSelectedCollector.name} ${cashOperationsSelectedCollector.firstnames}'
                    : '',
                maxLength: 15,
              ),
              fontWeight: FontWeight.w500,
              fontSize: 11.0,
            ),
            RSTText(
              text: cashOperationsSelectedCollector != null
                  ? cashOperationsSelectedCollector.phoneNumber
                  : '',
              fontSize: 10.0,
            ),
          ],
        ),
      ],
    );
  }
}
