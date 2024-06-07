import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/infos/card/card_infos.widget.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/infos/customer/customer_infos.widget.dart';

class CashOperationsInfos extends ConsumerWidget {
  const CashOperationsInfos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      //  color: Colors.blueGrey,
      height: 340.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CashOperationsCustomerInfos(
              width: width / 3.15,
            ),
            CashOperationsCustomerCardInfos(
              width: width * 1.543 / 3,
            ),
          ],
        ),
      ),
    );
  }
}
