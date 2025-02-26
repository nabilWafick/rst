import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/collectors/controllers/collectors.controller.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';

// used for storing collector name (form)
final collectorNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing collector firstnames (form)
final collectorFirstnamesProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing collector phoneNumber (form)
final collectorPhoneNumberProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing collector address (form)
final collectorAddressProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing collector photo (form)
final collectorProfileProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

// used for storing collectors filter options
final collectorsListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
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
final collectorsListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched collectors
final collectorsListStreamProvider = FutureProvider<List<Collector>>((ref) async {
  final listParameters = ref.watch(collectorsListParametersProvider);

  final controllerResponse = await CollectorsController.getMany(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<Collector>.from(controllerResponse.data)
      : <Collector>[];
});

// used for storing all collectors of database count
final collectorsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await CollectorsController.countAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing all collectors of database count
final yearCollectorsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await CollectorsController.countAll(listParameters: {
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

// used for storing fetched collectors (collectors respecting filter options) count
final specificCollectorsCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(collectorsListParametersProvider);

  final controllerResponse = await CollectorsController.countSpecific(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});
