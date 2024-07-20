import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/cash/settlements/models/settlements.model.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';
import 'package:rst/modules/definitions/customers/models/customers.model.dart';

final customerActivitiesSelectedCustomerProvider =
    StateProvider<Customer?>((ref) {
  return;
});

final customerActivitiesSelectedCustomerCardProvider =
    StateProvider<Card?>((ref) {
  return;
});

final customerActivitiesSelectedCollectorProvider =
    StateProvider<Collector?>((ref) {
  return;
});

final customerActivitiesSelectedCustomerCardsProvider =
    StateProvider<List<Card>>((ref) {
  return [];
});

final customerActivitiesShowAllCustomerCardsProvider =
    StateProvider<bool>((ref) {
  return false;
});

final customerActivitiesSelectedCardTotalSettlementsNumbersProvider =
    FutureProvider<int>((ref) async {
  final customerActivitiesSelectedCard =
      ref.watch(customerActivitiesSelectedCustomerCardProvider);
  final controllerResponse = await SettlementsController.sumOfNumberForCard(
      cardId: customerActivitiesSelectedCard?.id ?? 0);

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing settlements filter options
final customerActivitiesSelectedCardSettlementsListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 15,
    'where': {
      'AND': [
        {
          'cardId': 0,
        },
      ]
    },
    'orderBy': [
      {
        'collection': {
          'collectedAt': 'asc',
        },
      }
    ]
  };
});

final customerActivitiesSelectedCardSettlementsProvider =
    FutureProvider<List<Settlement>>((ref) async {
  final listParameters = ref
      .watch(customerActivitiesSelectedCardSettlementsListParametersProvider);

  final controllerResponse = await SettlementsController.getMany(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<Settlement>.from(controllerResponse.data)
      : <Settlement>[];
});

// used for storing all settlements of selected card count
final customerActivitiesSelectedCardSettlementsCountProvider =
    FutureProvider<int>((ref) async {
  final customerActivitiesSelectedCustomerCard =
      ref.watch(customerActivitiesSelectedCustomerCardProvider);

  final controllerResponse =
      await SettlementsController.countSpecific(listParameters: {
    'skip': 0,
    'take': 15,
    'where': {
      'AND': [
        {
          'cardId': customerActivitiesSelectedCustomerCard?.id ?? 0,
        },
      ]
    }
  });

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched settlements (settlements respecting filter options) count
final customerActivitiesSelectedCardSpecificSettlementsCountProvider =
    FutureProvider<int>((ref) async {
  final listParameters = ref
      .watch(customerActivitiesSelectedCardSettlementsListParametersProvider);

  final controllerResponse = await SettlementsController.countSpecific(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
