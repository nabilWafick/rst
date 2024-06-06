import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/types/controllers/types.controller.dart';
import 'package:rst/modules/definitions/types/models/type/type.model.dart';

final typeSelectionToolProvider =
    StateProvider.family<Type?, String>((ref, toolName) {
  return;
});

// used for storing types filter options
final typesSelectionListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched types
final typesSelectionListStreamProvider =
    FutureProvider<List<Type>>((ref) async {
  final listParameters = ref.watch(typesSelectionListParametersProvider);

  final controllerResponse = await TypesController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Type>.from(controllerResponse.data)
      : <Type>[];
});

// used for storing fetched types (types respecting filter options) count
final specifictypesSelectionCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(typesSelectionListParametersProvider);

  final controllerResponse = await TypesController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
