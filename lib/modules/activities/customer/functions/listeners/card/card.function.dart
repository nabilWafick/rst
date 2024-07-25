import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/activities/customer/providers/customers_activities.provider.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

onCustomerActivitiesCustomerCardChange({
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
        ref
            .read(customerActivitiesSelectedCustomerCardProvider.notifier)
            .state = newCustomerCard;

        // fetch the selected customer card settlements
        ref
            .read(
                customerActivitiesSelectedCardSettlementsListParametersProvider
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
          },
          'orderBy': [
            {
              'collection': {
                'collectedAt': 'asc',
              },
            }
          ]
        };
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
