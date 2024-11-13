import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/cash/collections/controllers/collections.controller.dart';
import 'package:rst/modules/cash/collections/models/collection/collection.model.dart';

// used for storing collection name (form)
final collectionAmountProvider = StateProvider<double>(
  (ref) {
    return .0;
  },
);

// used for storing collection firstnames (form)
final collectionDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

// used for storing collections filter options
final collectionsListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
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
final collectionsListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched collections
final collectionsListStreamProvider = FutureProvider<List<Collection>>((ref) async {
  final listParameters = ref.watch(collectionsListParametersProvider);

  final controllerResponse = await CollectionsController.getMany(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<Collection>.from(controllerResponse.data)
      : <Collection>[];
});

// used for storing all collections of database count
final collectionsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await CollectionsController.countAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final collectionsSumProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.sumAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final collectionsProfitProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.profit();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final collectionsRestSumProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.sumAllRest();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing fetched collections (collections respecting filter options) count
final specificCollectionsCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(collectionsListParametersProvider);

  final controllerResponse = await CollectionsController.countSpecific(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final specificCollectionsSumProvider = FutureProvider<num>((ref) async {
  final listParameters = ref.watch(collectionsListParametersProvider);

  final controllerResponse = await CollectionsController.sumSpecific(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final specificCollectionsRestSumProvider = FutureProvider<num>((ref) async {
  final listParameters = ref.watch(collectionsListParametersProvider);

  final controllerResponse = await CollectionsController.sumSpecificRest(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final dayCollectionProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.getDayCollection();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final monthCollectionProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.getMonthCollection();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final weekCollectionProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.getWeekCollection();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final yearCollectionProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.getYearCollection();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});
