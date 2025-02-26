import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/localities/controllers/localities.controller.dart';
import 'package:rst/modules/definitions/localities/models/locality/locality.model.dart';

final localitySelectionToolProvider =
    StateProvider.family<Locality?, String>((ref, toolName) {
  return;
});

// used for storing localities filter options
final localitiesSelectionListParametersProvider =
    StateProvider.family<Map<String, dynamic>, String>((ref, toolName) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched localities
final localitiesSelectionListStreamProvider =
    FutureProvider.family<List<Locality>, String>((ref, toolName) async {
  final listParameters =
      ref.watch(localitiesSelectionListParametersProvider(toolName));

  final controllerResponse = await LocalitiesController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Locality>.from(controllerResponse.data)
      : <Locality>[];
});

// used for storing fetched localities (localities respecting filter options) count
final specificLocaitiesSelectionCountProvider =
    FutureProvider.family<int, String>((ref, toolName) async {
  final listParameters =
      ref.watch(localitiesSelectionListParametersProvider(toolName));

  final controllerResponse = await LocalitiesController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
