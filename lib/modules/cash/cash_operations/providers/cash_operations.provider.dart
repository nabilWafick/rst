import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/cash/settlements/models/settlements.model.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';
import 'package:rst/modules/definitions/customers/models/customers.model.dart';

final cashOperationsSelectedCustomerProvider = StateProvider<Customer?>((ref) {
  return;
});

final cashOperationsSelectedCustomerCardProvider = StateProvider<Card?>((ref) {
  return;
});

final cashOperationsSelectedCollectorProvider =
    StateProvider<Collector?>((ref) {
  return;
});

final cashOperationsSelectedCustomerCardsProvider =
    StateProvider<List<Card>>((ref) {
  return [];
});

final cashOperationsShowAllCustomerCardsProvider = StateProvider<bool>((ref) {
  return false;
});

final cashOperationsSelectedCardTotalSettlementsNumbersProvider =
    FutureProvider<int>((ref) async {
  final cashOperationsSelectedCard =
      ref.watch(cashOperationsSelectedCustomerCardProvider);
  final controllerResponse = await SettlementsController.sumOfNumberForCard(
      cardId: cashOperationsSelectedCard?.id ?? 0);

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing settlements filter options
final cashOperationsSelectedCardSettlementsListParametersProvider =
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
    }
  };
});

final cashOperationsSelectedCardSettlementsProvider =
    FutureProvider<List<Settlement>>((ref) async {
  final listParameters =
      ref.watch(cashOperationsSelectedCardSettlementsListParametersProvider);

  final controllerResponse = await SettlementsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Settlement>.from(controllerResponse.data)
      : <Settlement>[];
});

// used for storing all settlements of selected card count
final cashOperationsSelectedCardSettlementsCountProvider =
    FutureProvider<int>((ref) async {
  final cashOperationsSelectedCustomerCard =
      ref.watch(cashOperationsSelectedCustomerCardProvider);

  final controllerResponse =
      await SettlementsController.countSpecific(listParameters: {
    'skip': 0,
    'take': 15,
    'where': {
      'AND': [
        {
          'cardId': cashOperationsSelectedCustomerCard?.id ?? 0,
        },
      ]
    }
  });

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched settlements (settlements respecting filter options) count
final cashOperationsSelectedCardSpecificSettlementsCountProvider =
    FutureProvider<int>((ref) async {
  final listParameters =
      ref.watch(cashOperationsSelectedCardSettlementsListParametersProvider);

  final controllerResponse = await SettlementsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
