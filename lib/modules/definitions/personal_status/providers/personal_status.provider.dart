import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/personal_status/controllers/personal_status.controller.dart';
import 'package:rst/modules/definitions/personal_status/models/personal_status/personal_status.model.dart';

// used for storing personalStatus name (form)
final personalStatusNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing personalStatus filter options
final personalStatusListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
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
final personalStatusListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched personalStatus
final personalStatusListStreamProvider = FutureProvider<List<PersonalStatus>>((ref) async {
  final listParameters = ref.watch(personalStatusListParametersProvider);

  final controllerResponse = await PersonalStatusController.getMany(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<PersonalStatus>.from(controllerResponse.data)
      : <PersonalStatus>[];
});

// used for storing all personalStatus of database count
final personalStatusCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await PersonalStatusController.countAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing all personalStatus of database count
final yearPersonalStatusCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await PersonalStatusController.countAll(listParameters: {
    'where': {
      'createdAt': {
        'gte': '${DateTime(DateTime.now().year).toIso8601String()}Z',
        'lt': '${DateTime(DateTime.now().year + 1).toIso8601String()}Z',
      },
    }
  });

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing fetched personalStatus (personalStatus respecting filter options) count
final specificPersonalStatusCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(personalStatusListParametersProvider);

  final controllerResponse = await PersonalStatusController.countSpecific(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});
