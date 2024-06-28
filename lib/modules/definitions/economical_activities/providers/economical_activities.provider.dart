import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/economical_activities/controllers/economical_activities.controller.dart';
import 'package:rst/modules/definitions/economical_activities/models/economical_activity/economical_activity.model.dart';

// used for storing economicalActivity name (form)
final economicalActivityNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing economicalActivities filter options
final economicalActivitiesListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
    'orderBy': [
      {
        'id': 'desc',
      }
    ]
  };
});

// used for storing added filter tool
final economicalActivitiesListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched economicalActivities
final economicalActivitiesListStreamProvider =
    FutureProvider<List<EconomicalActivity>>((ref) async {
  final listParameters = ref.watch(economicalActivitiesListParametersProvider);

  final controllerResponse = await EconomicalActivitiesController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<EconomicalActivity>.from(controllerResponse.data)
      : <EconomicalActivity>[];
});

// used for storing all economicalActivities of database count
final economicalActivitiesCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await EconomicalActivitiesController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched economicalActivities (economicalActivities respecting filter options) count
final specificEconomicalActivitiesCountProvider =
    FutureProvider<int>((ref) async {
  final listParameters = ref.watch(economicalActivitiesListParametersProvider);

  final controllerResponse = await EconomicalActivitiesController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
