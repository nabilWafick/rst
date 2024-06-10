import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/selection_tools/collector/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/definitions/cards/controllers/cards.controller.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';

onCashOperationsCustomerChange({
  required WidgetRef ref,
  Customer? previousCustomer,
  Customer? newCustomer,
}) async {
  if (newCustomer != null && newCustomer.id != previousCustomer?.id) {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () async {
      try {
        // define the cashOperations customer
        ref.read(cashOperationsSelectedCustomerProvider.notifier).state =
            newCustomer;

        // update the cashOperation selected collector if he is not the collector of  the selected customer
        final cashOperationsSelectedCollector =
            ref.watch(cashOperationsSelectedCollectorProvider);

        if (cashOperationsSelectedCollector == null ||
            (cashOperationsSelectedCollector.id != newCustomer.collector?.id)) {
          // update cash operations collector selection tool value
          ref
              .read(collectorSelectionToolProvider('cash-operations').notifier)
              .state = newCustomer.collector;
        }

        // fetch all cards of customer cards
        List<Card> customerCards = [];

        // update customer cards selection list parameters
        ref
            .read(cardsSelectionListParametersProvider('cash-operations')
                .notifier)
            .state = {
          'skip': 0,
          'take': 15,
          'where': {
            'AND': [
              {
                'customerId': newCustomer.id,
              },
            ]
          }
        };

        // get customer cards number
        // because the number can be knowed without
        // asking the database
        final customerCardsNumberData = await CardsController.countSpecific(
          listParameters: {
            'skip': 0, // This value is override in backend
            'take': 100, // This value is override in backend
            'where': {
              'customer': {
                'id': newCustomer.id!.toInt(),
              },
            },
          },
        );

        // fetch the cards
        final customerCardsData =
            await CardsController.getMany(listParameters: {
          'skip': 0,
          'take': customerCardsNumberData.data.count,
          'where': {
            'customer': {
              'id': newCustomer.id!.toInt(),
            },
          },
        });

        // store the cards
        customerCards = List<Card>.from(
          customerCardsData.data,
        );

        // update cash operations customer cards
        ref.read(cashOperationsSelectedCustomerCardsProvider.notifier).state =
            customerCards;

        // update cashOperations selected customer cards
        ref.read(cashOperationsSelectedCustomerCardProvider.notifier).state =
            customerCards.isNotEmpty
                ? customerCards.firstWhereOrNull(
                    (card) =>
                        card.repaidAt == null &&
                        card.satisfiedAt == null &&
                        card.transferredAt == null,
                  )
                : null;

        // update cash operations card selection tool value
        ref.read(cardSelectionToolProvider('cash-operations').notifier).state =
            customerCards.isNotEmpty
                ? customerCards.firstWhereOrNull(
                    (card) =>
                        card.repaidAt == null &&
                        card.satisfiedAt == null &&
                        card.transferredAt == null,
                  )
                : null;
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
