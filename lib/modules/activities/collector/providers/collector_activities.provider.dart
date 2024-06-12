import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/cash/settlements/models/settlement/settlement.model.dart';

// used for storing collectorActivities filter options
final collectorActivitiesListParametersProvider =
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
        {
          'card': {
            'customer': {
              'collector': {
                'name': {
                  "contains": "t",
                  "mode": "insensitive",
                }
              }
            }
          }
        }
      ],
    },
    'orderBy': {
      'id': 'asc',
    }
  };
});

// used for storing added filter tool
final collectorActivitiesListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched collectorActivities
final collectorActivitiesListStreamProvider =
    FutureProvider<List<Settlement>>((ref) async {
  final listParameters = ref.watch(collectorActivitiesListParametersProvider);

  final controllerResponse = await SettlementsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Settlement>.from(controllerResponse.data)
      : <Settlement>[];
});

// used for storing all collectorActivities of database count
final collectorActivitiesCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await SettlementsController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched collectorActivities (settlements respecting filter options) count
final specificCollectorActivitiesCountProvider =
    FutureProvider<int>((ref) async {
  final listParameters = ref.watch(collectorActivitiesListParametersProvider);

  final controllerResponse = await SettlementsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
