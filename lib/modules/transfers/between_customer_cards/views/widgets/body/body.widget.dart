import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/customer/card/selection_card.widget.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/modules/transfers/between_customer_cards/functions/listeners/customer/customer.function.dart';
import 'package:rst/modules/transfers/between_customer_cards/functions/listeners/issuing_card/issuing_card.function.dart';
import 'package:rst/modules/transfers/between_customer_cards/functions/listeners/receiving_card/receiving_card.function.dart';
import 'package:rst/modules/transfers/functions/crud/crud.function.dart';
import 'package:rst/modules/transfers/widgets/transfers.widget.dart';

class TransfersBCCPageBody extends StatefulHookConsumerWidget {
  const TransfersBCCPageBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransfersBCCPageBodyState();
}

class _TransfersBCCPageBodyState extends ConsumerState<TransfersBCCPageBody> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final enableTransferButton = useState<bool>(true);

    ref.listen(customerSelectionToolProvider('transfer-bcc-customer'),
        (previous, next) {
      onTransferBCCCustomerChange(
        ref: ref,
        previousCustomer: previous,
        newCustomer: next,
      );
    });

    ref.listen(cardSelectionToolProvider('transfer-bcc-issuing-card'),
        (previous, next) {
      onTransferBCCIssuingCardChange(
        ref: ref,
        previousCard: previous,
        newCard: next,
      );
    });

    ref.listen(cardSelectionToolProvider('transfer-bcc-receiving-card'),
        (previous, next) {
      onTransferBCCReceivingCardChange(
        ref: ref,
        previousCard: previous,
        newCard: next,
      );
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: CustomerSelectionToolCard(
            toolName: 'transfer-bcc-customer',
            width: 400.0,
            roundedStyle: RoundedStyle.full,
            textLimit: 45,
          ),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TransferIssuingCardBox(
              transferName: 'transfer-bcc',
            ),
            TransferReceivingCardBox(
              transferName: 'transfer-bcc',
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
                  ? await TransfersCRUDFunctions.createBetweenCustomerCards(
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
