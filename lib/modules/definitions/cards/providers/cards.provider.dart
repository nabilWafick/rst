import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/cards/controllers/cards.controller.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

// used for storing card label (form)
final cardLabelProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing card label (form)
final cardTypesNumberProvider = StateProvider<int>(
  (ref) {
    return 1;
  },
);

// used for storing card repayment date (form)
final cardRepaymentDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

// used for storing card satisfaction date (form)
final cardSatisfactionDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

// used for storing card transfer (form)
final cardTransferDateProvider = StateProvider<DateTime?>(
  (ref) {
    return;
  },
);

// used for storing cards filter options
final cardsListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
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
final cardsListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched cards
final cardsListStreamProvider = FutureProvider<List<Card>>((ref) async {
  final listParameters = ref.watch(cardsListParametersProvider);

  final controllerResponse = await CardsController.getMany(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? List<Card>.from(controllerResponse.data)
      : <Card>[];
});

// used for storing all cards of database count
final cardsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await CardsController.countAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched cards (cards respecting filter options) count
final specificCardsCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(cardsListParametersProvider);

  final controllerResponse = await CardsController.countSpecific(
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
