// used for storing settlements filter options
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/cash/settlements/models/settlement/settlement.model.dart';

final cardSettlementsOverviewListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  final cashOperationsSelectedCustomerCard =
      ref.watch(cashOperationsSelectedCustomerCardProvider);
  return {
    'skip': 0,
    'take': 15,
    'where': {
      'AND': [
        {
          'cardId': cashOperationsSelectedCustomerCard?.id ?? 0,
        },
      ]
    },
    'orderBy': {
      'collection': {
        'collectedAt': 'asc',
      },
    },
  };
});

final cardSettlementsOverviewProvider =
    FutureProvider<List<Settlement>>((ref) async {
  final listParameters =
      ref.watch(cardSettlementsOverviewListParametersProvider);

  final controllerResponse = await SettlementsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Settlement>.from(controllerResponse.data)
      : <Settlement>[];
});

// used for storing all settlements of selected card count
final cardSettlementsOverviewCountProvider = FutureProvider<int>((ref) async {
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
final cardSettlementsOverviewSpecificSettlementsCountProvider =
    FutureProvider<int>((ref) async {
  final listParameters =
      ref.watch(cardSettlementsOverviewListParametersProvider);

  final controllerResponse = await SettlementsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
