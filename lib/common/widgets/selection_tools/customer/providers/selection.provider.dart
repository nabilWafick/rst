import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/customers/controllers/customers.controller.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';

final customerSelectionToolProvider =
    StateProvider.family<Customer?, String>((ref, toolName) {
  return;
});

// used for storing customers filter options
final customersSelectionListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched customers
final customersSelectionListStreamProvider =
    FutureProvider<List<Customer>>((ref) async {
  final listParameters = ref.watch(customersSelectionListParametersProvider);

  final controllerResponse = await CustomersController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Customer>.from(controllerResponse.data)
      : <Customer>[];
});

// used for storing fetched customers (customers respecting filter options) count
final specificCustomersSelectionCountProvider =
    FutureProvider<int>((ref) async {
  final listParameters = ref.watch(customersSelectionListParametersProvider);

  final controllerResponse = await CustomersController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
