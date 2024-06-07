import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/personal_status/controllers/personal_status.controller.dart';
import 'package:rst/modules/definitions/personal_status/models/personal_status/personal_status.model.dart';

final personalStatusSelectionToolProvider =
    StateProvider.family<PersonalStatus?, String>((ref, toolName) {
  return;
});

// used for storing PersonalStatus filter options
final personalStatusSelectionListParametersProvider =
    StateProvider.family<Map<String, dynamic>, String>((ref, toolName) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched PersonalStatus
final personalStatusSelectionListStreamProvider =
    FutureProvider.family<List<PersonalStatus>, String>((ref, toolName) async {
  final listParameters =
      ref.watch(personalStatusSelectionListParametersProvider(toolName));

  final controllerResponse = await PersonalStatusController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<PersonalStatus>.from(controllerResponse.data)
      : <PersonalStatus>[];
});

// used for storing fetched PersonalStatus (PersonalStatus respecting filter options) count
final specificPersonalStatusSelectionCountProvider =
    FutureProvider.family<int, String>((ref, toolName) async {
  final listParameters =
      ref.watch(personalStatusSelectionListParametersProvider(toolName));

  final controllerResponse = await PersonalStatusController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
