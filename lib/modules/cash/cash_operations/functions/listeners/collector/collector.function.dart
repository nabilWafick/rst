import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/definitions/collectors/models/collectors.model.dart';
import 'package:rst/modules/definitions/customers/controllers/customers.controller.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';

onCashOperationsCollectorChange({
  required WidgetRef ref,
  Collector? previousCollector,
  Collector? newCollector,
}) async {
  if (newCollector != null && newCollector.id != previousCollector?.id) {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () async {
      try {
        // define cashOperations collector
        ref.read(cashOperationsSelectedCollectorProvider.notifier).state =
            newCollector;

        // define one customer of the collector as selected if the current selected is not his

        final cashOperationsSelectedCustomer =
            ref.watch(cashOperationsSelectedCustomerProvider);

        if (cashOperationsSelectedCustomer?.collector?.id != newCollector.id) {
          // fetch all cards of customer cards
          List<Customer> collectorCustomers = [];

          // update customer selection list parameters
          ref
              .read(customersSelectionListParametersProvider('cash-operations')
                  .notifier)
              .state = {
            'skip': 0,
            'take': 15,
            'where': {
              'AND': [
                {
                  'collectorId': newCollector.id,
                },
              ]
            }
          };

          // fetch the first customer of the collector
          final customersData =
              await CustomersController.getMany(listParameters: {
            'skip': 0,
            'take': 1,
            'where': {
              'collector': {
                'id': newCollector.id!.toInt(),
              },
            },
          });

          // store the customers
          collectorCustomers = List<Customer>.from(
            customersData.data,
          );

          // update cash operations customer selection tool value
          ref
              .read(customerSelectionToolProvider('cash-operations').notifier)
              .state = collectorCustomers
                  .isNotEmpty
              ? collectorCustomers.first
              : null;
        }
        // after updating a customer, the customers cards will automatically updated
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
