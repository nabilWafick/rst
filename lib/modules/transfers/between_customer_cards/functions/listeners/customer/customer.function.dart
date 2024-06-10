import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/modules/definitions/cards/controllers/cards.controller.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';

onTransferBCCCustomerChange({
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
        // fetch all cards of customer cards
        List<Card> customerCards = [];

        // get customer cards number
        // because the number can be knowed without
        // asking the database
        final customerCardsNumberData = await CardsController.countSpecific(
          listParameters: {
            'skip': 0, // This value is override in backend
            'take': 100, // This value is override in backend
            'where': {
              'AND': [
                {
                  'customer': {
                    'id': newCustomer.id!.toInt(),
                  },
                },
                {
                  'repaidAt': 'null',
                },
                {
                  'satisfiedAt': 'null',
                },
                {
                  'transferredAt': 'null',
                },
              ]
            },
          },
        );

        // fetch the cards
        final customerCardsData =
            await CardsController.getMany(listParameters: {
          'skip': 0,
          'take': customerCardsNumberData.data.count,
          'where': {
            'AND': [
              {
                'customer': {
                  'id': newCustomer.id!.toInt(),
                },
              },
              {
                'repaidAt': 'null',
              },
              {
                'satisfiedAt': 'null',
              },
              {
                'transferredAt': 'null',
              },
            ]
          },
        });

        // store the cards
        customerCards = List<Card>.from(
          customerCardsData.data,
        );

        // update transferBCC IssuingCard
        ref
                .read(cardSelectionToolProvider('transfer-bcc-issuing-card')
                    .notifier)
                .state =
            customerCards.isNotEmpty ? customerCards.firstOrNull : null;

        // update transferBCC ReceivingCard
        ref.read(cardSelectionToolProvider('transfer-bcc-receiving-card').notifier).state =
            customerCards.isNotEmpty
                ? customerCards.firstWhereOrNull(
                    (card) =>
                        card.id !=
                        ref
                            .watch(
                              cardSelectionToolProvider(
                                  'transfer-bcc-issuing-card'),
                            )
                            ?.id,
                  )
                : null;
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
