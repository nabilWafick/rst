import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

onCashOperationsCustomerCardChange({
  required WidgetRef ref,
  Card? previousCustomerCard,
  Card? newCustomerCard,
}) async {
  if (newCustomerCard != null &&
      newCustomerCard.id != previousCustomerCard?.id) {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () async {
      try {
        // define the cash Operations selected card
        ref.read(cashOperationsSelectedCustomerCardProvider.notifier).state =
            newCustomerCard;

        // update the cashOperation selected customer if he is not the owner of  the selected card
        final cashOperationsSelectedCustomer =
            ref.watch(cashOperationsSelectedCustomerProvider);
        if (cashOperationsSelectedCustomer == null ||
            cashOperationsSelectedCustomer.id != newCustomerCard.customer.id) {
          // update cash operations customer selection tool value
          ref
              .read(customerSelectionToolProvider('cash-operations').notifier)
              .state = newCustomerCard.customer;
        }

        // fetch the selected customer card settlements
        ref
            .read(cashOperationsSelectedCardSettlementsListParametersProvider
                .notifier)
            .state = {
          'skip': 0,
          'take': 15,
          'where': {
            'AND': [
              {
                'cardId': newCustomerCard.id,
              },
            ],
          }
        };
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
