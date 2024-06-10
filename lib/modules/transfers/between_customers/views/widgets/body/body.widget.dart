import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/customer/card/selection_card.widget.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/modules/transfers/between_customers/functions/listeners/issuing_customer/issuing_customer.function.dart';
import 'package:rst/modules/transfers/between_customers/functions/listeners/receiving_customer/receiving_customer.function.dart';
import 'package:rst/modules/transfers/functions/crud/crud.function.dart';
import 'package:rst/modules/transfers/widgets/transfers.widget.dart';

class TransfersBCPageBody extends StatefulHookConsumerWidget {
  const TransfersBCPageBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransfersBCPageBodyState();
}

class _TransfersBCPageBodyState extends ConsumerState<TransfersBCPageBody> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(customerSelectionToolProvider('transfer-bc-issuing-customer'),
        (previous, next) {
      onTransferBCIssuingCustomerChange(
        ref: ref,
        previousCustomer: previous,
        newCustomer: next,
      );
    });

    ref.listen(customerSelectionToolProvider('transfer-bc-receiving-customer'),
        (previous, next) {
      onTransferBCReceivingCustomerChange(
        ref: ref,
        previousCustomer: previous,
        newCustomer: next,
      );
    });

    final enableTransferButton = useState<bool>(true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomerSelectionToolCard(
                  toolName: 'transfer-bc-issuing-customer',
                  width: 400.0,
                  roundedStyle: RoundedStyle.full,
                  textLimit: 40,
                ),
                SizedBox(
                  height: 30.0,
                ),
                TransferIssuingCardBox(
                  transferName: 'transfer-bc',
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomerSelectionToolCard(
                  toolName: 'transfer-bc-receiving-customer',
                  width: 400.0,
                  roundedStyle: RoundedStyle.full,
                  textLimit: 40,
                ),
                SizedBox(
                  height: 30.0,
                ),
                TransferReceivingCardBox(
                  transferName: 'transfer-bc',
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          width: 500.0,
          child: RSTElevatedButton(
            text: enableTransferButton.value
                ? "Transférer"
                : "Veuillez patienter",
            onPressed: () async {
              enableTransferButton.value
                  ? await TransfersCRUDFunctions.createBetweenCustomers(
                      context: context,
                      ref: ref,
                      enableTransferButton: enableTransferButton,
                    )
                  : () {};
            },
          ),
        ),
      ],
    );
  }
}
