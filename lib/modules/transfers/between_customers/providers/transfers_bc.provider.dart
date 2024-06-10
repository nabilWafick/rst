import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';

final transferBCIssuingCustomerProvider = StateProvider<Customer?>((ref) {
  return;
});

final transferBCReceivingCustomerProvider = StateProvider<Customer?>((ref) {
  return;
});

final transferBCReceivingProvider = StateProvider<Card?>((ref) {
  return;
});

final transferBCIssuingCardProvider = StateProvider<Card?>((ref) {
  return;
});
