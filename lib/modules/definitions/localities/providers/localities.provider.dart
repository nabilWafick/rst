import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/localities/controllers/localities.controller.dart';
import 'package:rst/modules/definitions/localities/models/locality/locality.model.dart';

// used for storing locality name (form)
final localityNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing localities filter options
final localitiesListParametersProvider =
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
final localitiesListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched localities
final localitiesListStreamProvider =
    FutureProvider<List<Locality>>((ref) async {
  final listParameters = ref.watch(localitiesListParametersProvider);

  final controllerResponse = await LocalitiesController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Locality>.from(controllerResponse.data)
      : <Locality>[];
});

// used for storing all localities of database count
final localitiesCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await LocalitiesController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched localities (localities respecting filter options) count
final specificLocalitiesCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(localitiesListParametersProvider);

  final controllerResponse = await LocalitiesController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
