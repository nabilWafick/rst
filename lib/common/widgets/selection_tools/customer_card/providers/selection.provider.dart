import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/cards/controllers/cards.controller.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

final cardSelectionToolProvider =
    StateProvider.family<Card?, String>((ref, toolName) {
  return;
});

// used for storing cards filter options
final cardsSelectionListParametersProvider =
    StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched cards
final cardsSelectionListStreamProvider =
    FutureProvider<List<Card>>((ref) async {
  final listParameters = ref.watch(cardsSelectionListParametersProvider);

  final controllerResponse = await CardsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Card>.from(controllerResponse.data)
      : <Card>[];
});

// used for storing fetched cards (cards respecting filter options) count
final specificCardsSelectionCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(cardsSelectionListParametersProvider);

  final controllerResponse = await CardsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
