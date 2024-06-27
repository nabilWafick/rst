import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/collections/models/collections.model.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/cash/settlements/models/settlement/settlement.model.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

// used for storing settlement name (form)
final settlementNumberProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final settlementCollectionDateProvider = StateProvider<DateTime?>((ref) {
  return;
});

final settlementCollectorCollectionProvider = StateProvider<Collection?>((ref) {
  return;
});

// used for storing settlements filter options
final settlementsListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 15,
    'orderBy': [
      {
        'id': 'desc',
      },
    ]
  };
});

/// **** MULTIPLE SETTLEMENTS PROVIDERS ****

// for managing Types inputs, add,hide inputs, identify inputs
final multipleSettlementsAddedInputsVisibilityProvider =
    StateProvider<Map<String, bool>>((ref) {
  return {};
});

final multipleSettlementsSelectedCustomerCardsProvider =
    StateProvider<Map<String, Card>>((ref) {
  return {};
});

/// **** MULTIPLE SETTLEMENTS PROVIDERS ****

// used for storing added filter tool
final settlementsListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched settlements
final settlementsListStreamProvider =
    FutureProvider<List<Settlement>>((ref) async {
  final listParameters = ref.watch(settlementsListParametersProvider);

  final controllerResponse = await SettlementsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Settlement>.from(controllerResponse.data)
      : <Settlement>[];
});

// used for storing all settlements of database count
final settlementsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await SettlementsController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched settlements (settlements respecting filter options) count
final specificSettlementsCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(settlementsListParametersProvider);

  final controllerResponse = await SettlementsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
