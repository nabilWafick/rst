import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/stocks/stocks/controllers/stocks.controller.dart';
import 'package:rst/modules/stocks/stocks/models/stock/stock.model.dart';

// used for storing stock name (form)
final stockInputQuantityProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

final stockOutputQuantityProvider = StateProvider<int>(
  (ref) {
    return 0;
  },
);

// used for storing stocks filter options
final stocksListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
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
final stocksListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched stocks
final stocksListStreamProvider = FutureProvider<List<Stock>>((ref) async {
  final listParameters = ref.watch(stocksListParametersProvider);

  final controllerResponse = await StocksController.getMany(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<Stock>.from(controllerResponse.data)
      : <Stock>[];
});

// used for storing all stocks of database count
final stocksCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await StocksController.countAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched stocks (stocks respecting filter options) count
final specificStocksCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(stocksListParametersProvider);

  final controllerResponse = await StocksController.countSpecific(
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
