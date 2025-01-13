import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/cash/settlements/models/settlement/settlement.model.dart';
import 'package:rst/utils/utils.dart';

// used for storing collectorsActivities filter options
final collectorsActivitiesListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
    'where': {
      'collectionId': {
        'not': RSTApiConstants.nullValue,
      },
      'isValidated': {
        'equals': true,
      },
      'AND': [
        {
          'collection': {
            'collectedAt': {'gte': '${DateTime(DateTime.now().year).toIso8601String()}Z'},
          }
        },
        {
          'collection': {
            'collectedAt': {'lt': '${DateTime(DateTime.now().year + 1).toIso8601String()}Z'}
          }
        }
      ]
    },
    'orderBy': [
      {
        'id': 'desc',
      },
    ]
  };
});

// used for storing added filter tool
final collectorsActivitiesListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched collectorsActivities
final collectorsActivitiesListStreamProvider = FutureProvider<List<Settlement>>((ref) async {
  final listParameters = ref.watch(collectorsActivitiesListParametersProvider);

  final controllerResponse = await SettlementsController.getMany(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<Settlement>.from(controllerResponse.data)
      : <Settlement>[];
});

// used for storing all collectorsActivities of database count
final collectorsActivitiesCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await SettlementsController.countAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing fetched collectorsActivities (settlements respecting filter options) count
final specificCollectorsActivitiesCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(collectorsActivitiesListParametersProvider);

  final controllerResponse = await SettlementsController.countSpecific(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});
