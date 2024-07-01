import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/collectors/controllers/collectors.controller.dart';
import 'package:rst/modules/statistics/collectors_collections/models/collector_collection/collector_collection.model.dart';
import 'package:rst/modules/statistics/collectors_collections/models/collector_collection_type/collector_collection_type.model.dart';

final collectorCollectionTypeProvider =
    StateProvider<CollectorCollectionType>((ref) {
  return CollectorCollectionType.day;
});

// used for storing collectorsCollections filter options
final collectorsCollectionsListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 20,
  };
});

// used for storing added filter tool
final collectorsCollectionsListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched collectorsCollections
final collectorsCollectionsListStreamProvider =
    FutureProvider<List<CollectorCollection>>((ref) async {
  final listParameters = ref.watch(collectorsCollectionsListParametersProvider);

  final collectionType = ref.watch(collectorCollectionTypeProvider);

  ControllerResponse controllerResponse;

  switch (collectionType) {
    case CollectorCollectionType.day:
      controllerResponse = await CollectorsController.getDayCollections(
        listParameters: listParameters,
      );
      break;
    case CollectorCollectionType.week:
      controllerResponse = await CollectorsController.getWeekCollections(
        listParameters: listParameters,
      );
      break;
    case CollectorCollectionType.month:
      controllerResponse = await CollectorsController.getMonthCollections(
        listParameters: listParameters,
      );
      break;
    case CollectorCollectionType.year:
      controllerResponse = await CollectorsController.getYearCollections(
        listParameters: listParameters,
      );
      break;

    default:
      controllerResponse = await CollectorsController.getGlobalCollections(
        listParameters: listParameters,
      );
  }

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<CollectorCollection>.from(controllerResponse.data)
      : <CollectorCollection>[];
});

// used for storing all collectorsCollections of database count
final collectorsCollectionsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await CollectorsController.countAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched collectorsCollections (collectorsCollections respecting filter options) count
final specificCollectorsCollectionsCountProvider =
    FutureProvider<int>((ref) async {
  final listParameters = ref.watch(collectorsCollectionsListParametersProvider);

  final controllerResponse = await CollectorsController.countSpecific(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
