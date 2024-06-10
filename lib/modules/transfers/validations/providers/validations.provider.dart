import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/transfers/controllers/transfers.controller.dart';
import 'package:rst/modules/transfers/models/transfer/transfer.model.dart';

// used for storing transfers filter options
final transfersListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
  };
});

// used for storing added filter tool
final transfersListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched transfers
final transfersListStreamProvider = FutureProvider<List<Transfer>>((ref) async {
  final listParameters = ref.watch(transfersListParametersProvider);

  final controllerResponse = await TransfersController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Transfer>.from(controllerResponse.data)
      : <Transfer>[];
});

// used for storing all transfers of database count
final transfersCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await TransfersController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched transfers (transfers respecting filter options) count
final specificTransfersCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(transfersListParametersProvider);

  final controllerResponse = await TransfersController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
