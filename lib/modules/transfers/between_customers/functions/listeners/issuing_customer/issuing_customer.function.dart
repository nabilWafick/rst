import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/modules/definitions/cards/controllers/cards.controller.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';
import 'package:rst/utils/constants/api/api.constant.dart';

onTransferBCIssuingCustomerChange({
  required WidgetRef ref,
  Customer? previousCustomer,
  Customer? newCustomer,
}) async {
  if (newCustomer != null && newCustomer != previousCustomer) {
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
                  'repaidAt': RSTApiConstants.nullValue,
                },
                {
                  'satisfiedAt': RSTApiConstants.nullValue,
                },
                {
                  'transferredAt': RSTApiConstants.nullValue,
                },
              ]
            },
          },
        );

        // fetch the cards
        final customerCardsData = await CardsController.getMany(listParameters: {
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
                'repaidAt': RSTApiConstants.nullValue,
              },
              {
                'satisfiedAt': RSTApiConstants.nullValue,
              },
              {
                'transferredAt': RSTApiConstants.nullValue,
              },
            ]
          },
        });

        // store the cards
        customerCards = List<Card>.from(
          customerCardsData.data,
        );

        // update transferBC IssuingCard
        ref.read(cardSelectionToolProvider('transfer-bc-issuing-card').notifier).state =
            customerCards.isNotEmpty ? customerCards.firstOrNull : null;
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
