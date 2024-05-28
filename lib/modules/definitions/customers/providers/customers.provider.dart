import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/customers/controllers/customers.controller.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';

// used for storing customer name (form)
final customerNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing customer firstnames (form)
final customerFirstnamesProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing customer phoneNumber (form)
final customerPhoneNumberProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing customer address (form)
final customerAddressProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing customer nic number (form)
final customerNicNumberProvider = StateProvider<int?>(
  (ref) {
    return;
  },
);

// used for storing customer occupation (form)
final customerOccupationProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

// used for storing customer photo (form)
final customerProfileProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

// used for storing customer signature (form)
final customerSignatureProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

// used for storing customers filter options
final customersListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
    'include': {
      'collector': true,
      'locality': true,
      'category': true,
      'economicalActivity': true,
      'personalStatus': true,
    }
  };
});

// used for storing added filter tool
final customersListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched customers
final customersListStreamProvider = FutureProvider<List<Customer>>((ref) async {
  final listParameters = ref.watch(customersListParametersProvider);

  final controllerResponse = await CustomersController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Customer>.from(controllerResponse.data)
      : <Customer>[];
});

// used for storing all customers of database count
final customersCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await CustomersController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched customers (customers respecting filter options) count
final specificCustomersCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(customersListParametersProvider);

  final controllerResponse = await CustomersController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
