// used for storing collectorsCollections filter options
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/controller_response/controller_response.model.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/collectors/controllers/collectors.controller.dart';
import 'package:rst/modules/statistics/collectors_collections/models/collector_collection/collector_collection.model.dart';

final dashboardCollectorsCollectionsListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 10,
  };
});

// used for storing added filter tool
final dashboardCollectorsCollectionsListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

final dashboardDayCollectorsCollectionsListStreamProvider =
    FutureProvider<List<CollectorCollection>>((ref) async {
  final listParameters =
      ref.watch(dashboardCollectorsCollectionsListParametersProvider);

  ControllerResponse controllerResponse =
      await CollectorsController.getDayCollections(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<CollectorCollection>.from(controllerResponse.data)
      : <CollectorCollection>[];
});

final dashboardWeekCollectorsCollectionsListStreamProvider =
    FutureProvider<List<CollectorCollection>>((ref) async {
  final listParameters =
      ref.watch(dashboardCollectorsCollectionsListParametersProvider);

  ControllerResponse controllerResponse =
      await CollectorsController.getWeekCollections(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<CollectorCollection>.from(controllerResponse.data)
      : <CollectorCollection>[];
});

final dashboardMonthCollectorsCollectionsListStreamProvider =
    FutureProvider<List<CollectorCollection>>((ref) async {
  final listParameters =
      ref.watch(dashboardCollectorsCollectionsListParametersProvider);

  ControllerResponse controllerResponse =
      await CollectorsController.getMonthCollections(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<CollectorCollection>.from(controllerResponse.data)
      : <CollectorCollection>[];
});

final dashboardYearCollectorsCollectionsListStreamProvider =
    FutureProvider<List<CollectorCollection>>((ref) async {
  final listParameters =
      ref.watch(dashboardCollectorsCollectionsListParametersProvider);

  ControllerResponse controllerResponse =
      await CollectorsController.getYearCollections(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<CollectorCollection>.from(controllerResponse.data)
      : <CollectorCollection>[];
});

final dashboardGlobalCollectorsCollectionsListStreamProvider =
    FutureProvider<List<CollectorCollection>>((ref) async {
  final listParameters =
      ref.watch(dashboardCollectorsCollectionsListParametersProvider);

  ControllerResponse controllerResponse =
      await CollectorsController.getGlobalCollections(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<CollectorCollection>.from(controllerResponse.data)
      : <CollectorCollection>[];
});
