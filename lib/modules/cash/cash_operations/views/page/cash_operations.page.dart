import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/filter_tools/filter_tools.widget.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/infos/infos.widget.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/settlements/settlements.widget.dart';

class CashOperationsPage extends ConsumerWidget {
  const CashOperationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CashOperationsFilterTools(),
        CashOperationsInfos(),
        CashOperationsSettlements()
      ],
    );
  }
}
