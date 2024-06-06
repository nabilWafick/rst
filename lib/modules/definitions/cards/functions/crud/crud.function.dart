// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/type/providers/selection.provider.dart';
import 'package:rst/modules/definitions/cards/controllers/cards.controller.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';
import 'package:rst/modules/definitions/customers/models/customers.model.dart';
import 'package:rst/modules/definitions/types/models/types.model.dart';

class CardsCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final cardLabel = ref.watch(cardLabelProvider);
      final cardTypesNumber = ref.watch(cardTypesNumberProvider);

      // instanciate the card
      final card = Card(
        label: cardLabel,
        typesNumber: cardTypesNumber,
        type: Type(
          name: 'Test',
          stake: 1.0,
          typeProducts: [],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        customer: Customer(
          name: 'TEST',
          firstnames: 'Test',
          phoneNumber: '1234567890',
          address: 'Address',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // launch card addition
      final cardAdditionResponse = await CardsController.create(
        card: card,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: cardAdditionResponse.result?.fr,
        error: cardAdditionResponse.error?.fr,
        message: cardAdditionResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide addition form if the the card have been added
      if (cardAdditionResponse.error == null) {
        Navigator.of(context).pop();
      }

      // show response
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const FeedbackDialog(),
      );
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Card card,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final cardLabel = ref.watch(cardLabelProvider);
      final cardTypesNumber = ref.watch(cardTypesNumberProvider);
      final cardOwner = ref.watch(customerSelectionToolProvider('card-update'));
      final cardType = ref.watch(typeSelectionToolProvider('card-update'));
      final cardRepaymentDate = ref.watch(cardRepaymentDateProvider);

      // instanciate the card
      final newCard = Card(
        label: cardLabel,
        typesNumber: cardTypesNumber,
        type: cardType!,
        customer: cardOwner!,
        repaidAt: cardRepaymentDate,
        createdAt: card.createdAt,
        updatedAt: DateTime.now(),
      );

      // launch card update
      final cardUpdateResponse = await CardsController.update(
        cardId: card.id!,
        card: newCard,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: cardUpdateResponse.result?.fr,
        error: cardUpdateResponse.error?.fr,
        message: cardUpdateResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide update form if the the card have been updated
      if (cardUpdateResponse.error == null) {
        // delay due response dialog
        Future.delayed(
          const Duration(
            milliseconds: 1500,
          ),
          () {
            // pop confirmation dialog
            Navigator.of(context).pop();
            // pop update dialog
            Navigator.of(context).pop();
          },
        );
      }

      // show response
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const FeedbackDialog(),
      );
    }
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Card card,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch card deletion
    final cardDeletionResponse = await CardsController.delete(
      cardId: card.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: cardDeletionResponse.result?.fr,
      error: cardDeletionResponse.error?.fr,
      message: cardDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the card have been added
    if (cardDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }
}
