import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/types/controllers/types.controller.dart';
import 'package:rst/modules/definitions/types/models/type/type.model.dart';

// used for storing type name (form)
final typeNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing type purchase price (form)
final typeStakeProvider = StateProvider<double>(
  (ref) {
    return .0;
  },
);

// for managing products inputs, add,hide inputs, identify inputs
final typeProductsInputsAddedVisibilityProvider =
    StateProvider<Map<String, bool>>((ref) {
  return {};
});

final typeProductNumberProvider = StateProvider.family<int, int>(
  (ref, productIndex) {
    return 0;
  },
);

// used for storing types filter options
final typesListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
  };
});

// used for storing added filter tool
final typesListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched types
final typesListStreamProvider = FutureProvider<List<Type>>((ref) async {
  final listParameters = ref.watch(typesListParametersProvider);

  final controllerResponse = await TypesController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Type>.from(controllerResponse.data)
      : <Type>[];
});

// used for storing all types of database count
final typesCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await TypesController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched types (types respecting filter options) count
final specifictypesCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(typesListParametersProvider);

  final controllerResponse = await TypesController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
