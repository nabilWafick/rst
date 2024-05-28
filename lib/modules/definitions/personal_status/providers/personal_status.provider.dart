import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/personal_status/controllers/personal_status.controller.dart';
import 'package:rst/modules/definitions/personal_status/models/personal_status/personal_status.model.dart';

// used for storing personalStatus name (form)
final personalStatusNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing personalStatus filter options
final personalStatusListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
  };
});

// used for storing added filter tool
final personalStatusListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched personalStatus
final personalStatusListStreamProvider =
    FutureProvider<List<PersonalStatus>>((ref) async {
  final listParameters = ref.watch(personalStatusListParametersProvider);

  final controllerResponse = await PersonalStatusController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<PersonalStatus>.from(controllerResponse.data)
      : <PersonalStatus>[];
});

// used for storing all personalStatus of database count
final personalStatusCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await PersonalStatusController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched personalStatus (personalStatus respecting filter options) count
final specificPersonalStatusCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(personalStatusListParametersProvider);

  final controllerResponse = await PersonalStatusController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
