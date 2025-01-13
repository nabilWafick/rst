import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/types/controllers/types.controller.dart';
import 'package:rst/modules/statistics/types_stat/models/type_stat/type_stat.model.dart';

// used for storing typesStats filter options
final typesStatsListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 20,
  };
});

// used for storing added filter tool
final typesStatsListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched typesStats
final typesStatsListStreamProvider = FutureProvider<List<TypeStat>>((ref) async {
  final listParameters = ref.watch(typesStatsListParametersProvider);

  final controllerResponse = await TypesController.getGlobalStats(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<TypeStat>.from(controllerResponse.data)
      : <TypeStat>[];
});

// used for storing all typesStats of database count
final typesStatsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await TypesController.countAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing fetched typesStats (typesStats respecting filter options) count
final specificTypesStatsCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(typesStatsListParametersProvider);

  final controllerResponse = await TypesController.countSpecific(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});
