import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/customers/controllers/customers.controller.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';

final customerSelectionToolProvider =
    StateProvider.family<Customer?, String>((ref, toolName) {
  return;
});

// used for storing customers filter options
final customersSelectionListParametersProvider =
    StateProvider.family<Map<String, dynamic>, String>((ref, toolName) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched customers
final customersSelectionListStreamProvider =
    FutureProvider.family<List<Customer>, String>((ref, toolName) async {
  final listParameters =
      ref.watch(customersSelectionListParametersProvider(toolName));

  final controllerResponse = await CustomersController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Customer>.from(controllerResponse.data)
      : <Customer>[];
});

// used for storing fetched customers (customers respecting filter options) count
final specificCustomersSelectionCountProvider =
    FutureProvider.family<int, String>((ref, toolName) async {
  final listParameters =
      ref.watch(customersSelectionListParametersProvider(toolName));

  final controllerResponse = await CustomersController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
