import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/settlements/body/body.widget.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/settlements/footer/footer.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CashOperationsSettlements extends StatefulHookConsumerWidget {
  const CashOperationsSettlements({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashOperationsSettlementsState();
}

class _CashOperationsSettlementsState
    extends ConsumerState<CashOperationsSettlements> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(
          15.0,
        ),
        topRight: Radius.circular(
          15.0,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        height: 350.0,
        margin: const EdgeInsets.only(top: 30.0),
        decoration: BoxDecoration(
          //  color: Colors.blueAccent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(
              15.0,
            ),
            topRight: Radius.circular(
              15.0,
            ),
          ),
          border: Border.all(
            color: RSTColors.sidebarTextColor.withOpacity(.5),
            width: 2,
          ),
        ),
        child: const Column(
          children: [
            CashOperationsSettlementsCardBody(),
            CashOperationsSettlementsCardFooter(),
          ],
        ),
      ),
    );
  }
}
