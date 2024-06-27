import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/cash/settlements/models/settlement/settlement.model.dart';

// used for storing collectorsActivities filter options
final collectorsActivitiesListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 15,
    'where': {
      'AND': [
        {
          'collectionId': {
            'not': 'null',
          },
        },
        {
          'isValidated': true,
        },
      ],
    },
    'orderBy': {
      'id': 'asc',
    }
  };
});

// used for storing added filter tool
final collectorsActivitiesListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched collectorsActivities
final collectorsActivitiesListStreamProvider =
    FutureProvider<List<Settlement>>((ref) async {
  final listParameters = ref.watch(collectorsActivitiesListParametersProvider);

  final controllerResponse = await SettlementsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Settlement>.from(controllerResponse.data)
      : <Settlement>[];
});

// used for storing all collectorsActivities of database count
final collectorsActivitiesCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await SettlementsController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched collectorsActivities (settlements respecting filter options) count
final specificCollectorsActivitiesCountProvider =
    FutureProvider<int>((ref) async {
  final listParameters = ref.watch(collectorsActivitiesListParametersProvider);

  final controllerResponse = await SettlementsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
