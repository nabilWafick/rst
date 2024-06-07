import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/economical_activities/controllers/economical_activities.controller.dart';
import 'package:rst/modules/definitions/economical_activities/models/economical_activity/economical_activity.model.dart';

final economicalActivitySelectionToolProvider =
    StateProvider.family<EconomicalActivity?, String>((ref, toolName) {
  return;
});

// used for storing economicalActivities filter options
final economicalActivitiesSelectionListParametersProvider =
    StateProvider.family<Map<String, dynamic>, String>((ref, toolName) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched economicalActivities
final economicalActivitiesSelectionListStreamProvider =
    FutureProvider.family<List<EconomicalActivity>, String>(
        (ref, toolName) async {
  final listParameters =
      ref.watch(economicalActivitiesSelectionListParametersProvider(toolName));

  final controllerResponse = await EconomicalActivitiesController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<EconomicalActivity>.from(controllerResponse.data)
      : <EconomicalActivity>[];
});

// used for storing fetched economicalActivities (economicalActivities respecting filter options) count
final specificEconomicalActivitiesSelectionCountProvider =
    FutureProvider.family<int, String>((ref, toolName) async {
  final listParameters =
      ref.watch(economicalActivitiesSelectionListParametersProvider(toolName));

  final controllerResponse = await EconomicalActivitiesController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
