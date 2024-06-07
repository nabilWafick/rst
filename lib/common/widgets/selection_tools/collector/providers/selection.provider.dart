import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/collectors/controllers/collectors.controller.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';

final collectorSelectionToolProvider =
    StateProvider.family<Collector?, String>((ref, toolName) {
  return;
});

// used for storing collectors filter options
final collectorsSelectionListParametersProvider =
    StateProvider.family<Map<String, dynamic>, String>((ref, toolName) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched collectors
final collectorsSelectionListStreamProvider =
    FutureProvider.family<List<Collector>, String>((ref, toolName) async {
  final listParameters =
      ref.watch(collectorsSelectionListParametersProvider(toolName));

  final controllerResponse = await CollectorsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Collector>.from(controllerResponse.data)
      : <Collector>[];
});

// used for storing fetched collectors (collectors respecting filter options) count
final specificCollectorsSelectionCountProvider =
    FutureProvider.family<int, String>((ref, toolName) async {
  final listParameters =
      ref.watch(collectorsSelectionListParametersProvider(toolName));

  final controllerResponse = await CollectorsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
