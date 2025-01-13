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
    'where': {
      'AND': [
        {
          'collectedAt': {'gte': '${DateTime(DateTime.now().year).toIso8601String()}Z'},
        },
        {
          'collectedAt': {'lt': '${DateTime(DateTime.now().year + 1).toIso8601String()}Z'}
        }
      ]
    },
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

// used for storing all collections of year of database count
final yearCollectionsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await CollectionsController.countAll(listParameters: {
    'where': {
      'collectedAt': {
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

final collectionsSumProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.sumAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final yearCollectionsSumProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.sumAll(listParameters: {
    'where': {
      'collectedAt': {
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

final collectionsProfitProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.profit();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final yearCollectionsProfitProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.yearProfit();

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

// Daily collections sum provider
final dayCollectionsRestSumProvider = FutureProvider<num>((ref) async {
  final now = DateTime.now();
  final startOfDay = DateTime(now.year, now.month, now.day);
  final startOfNextDay = startOfDay.add(const Duration(days: 1));

  final controllerResponse = await CollectionsController.sumAllRest(listParameters: {
    'where': {
      'collectedAt': {
        'gte': '${startOfDay.toIso8601String()}Z',
        'lt': '${startOfNextDay.toIso8601String()}Z',
      },
    }
  });

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// Weekly collections sum provider
final weekCollectionsRestSumProvider = FutureProvider<num>((ref) async {
  final now = DateTime.now();
  final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
  final startOfDay = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
  final startOfNextWeek = startOfDay.add(const Duration(days: 7));

  final controllerResponse = await CollectionsController.sumAllRest(listParameters: {
    'where': {
      'collectedAt': {
        'gte': '${startOfDay.toIso8601String()}Z',
        'lt': '${startOfNextWeek.toIso8601String()}Z',
      },
    }
  });

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// Monthly collections sum provider
final monthCollectionsRestSumProvider = FutureProvider<num>((ref) async {
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final startOfNextMonth = DateTime(now.year, now.month + 1, 1);

  final controllerResponse = await CollectionsController.sumAllRest(listParameters: {
    'where': {
      'collectedAt': {
        'gte': '${startOfMonth.toIso8601String()}Z',
        'lt': '${startOfNextMonth.toIso8601String()}Z',
      },
    }
  });

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final yearCollectionsRestSumProvider = FutureProvider<num>((ref) async {
  final controllerResponse = await CollectionsController.sumAllRest(listParameters: {
    'where': {
      'collectedAt': {
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
