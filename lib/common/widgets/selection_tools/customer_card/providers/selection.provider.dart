import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/cards/controllers/cards.controller.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

final cardSelectionToolProvider =
    StateProvider.family<Card?, String>((ref, toolName) {
  return;
});

// used for storing cards filter options
final cardsSelectionListParametersProvider =
    StateProvider.family<Map<String, dynamic>, String>((ref, toolName) {
  return {
    'skip': 0,
    'take': 15,
  };
});

// used for storing fetched cards
final cardsSelectionListStreamProvider =
    FutureProvider.family<List<Card>, String>((ref, toolName) async {
  final listParameters =
      ref.watch(cardsSelectionListParametersProvider(toolName));

  final controllerResponse = await CardsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Card>.from(controllerResponse.data)
      : <Card>[];
});

// used for storing fetched cards (cards respecting filter options) count
final specificCardsSelectionCountProvider =
    FutureProvider.family<int, String>((ref, toolName) async {
  final listParameters =
      ref.watch(cardsSelectionListParametersProvider(toolName));

  final controllerResponse = await CardsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
