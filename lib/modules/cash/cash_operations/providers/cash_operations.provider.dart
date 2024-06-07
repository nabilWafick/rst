import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';
import 'package:rst/modules/definitions/customers/models/customers.model.dart';

final cashOperationsSelectedCustomerProvider = StateProvider<Customer?>((ref) {
  return;
});

final cashOperationsSelectedCustomerCardProvider = StateProvider<Card?>((ref) {
  return;
});

final cashOperationsSelectedCollectorProvider =
    StateProvider<Collector?>((ref) {
  return;
});

final cashOperationsSelectedCustomerCardsProvider =
    StateProvider<List<Card>>((ref) {
  return [];
});

final cashOperationsShowAllCustomerCardsProvider = StateProvider<bool>((ref) {
  return false;
});
