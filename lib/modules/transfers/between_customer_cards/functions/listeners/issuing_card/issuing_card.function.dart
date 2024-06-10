import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

onTransferBCCIssuingCardChange({
  required WidgetRef ref,
  Card? previousCard,
  Card? newCard,
}) async {
  if (newCard != null && newCard.id != previousCard?.id) {
    Future.delayed(
        const Duration(
          milliseconds: 100,
        ), () async {
      try {
        final transferBCCRecevingCard =
            ref.watch(cardSelectionToolProvider('transfer-bcc-receiving-card'));

        if (transferBCCRecevingCard != null &&
            previousCard != null &&
            transferBCCRecevingCard.id == newCard.id) {
          ref
              .read(cardSelectionToolProvider('transfer-bcc-receiving-card')
                  .notifier)
              .state = previousCard;
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }
}
