// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/product/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/type/providers/selection.provider.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/definitions/cards/controllers/cards.controller.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';
import 'package:rst/modules/definitions/customers/models/customers.model.dart';
import 'package:rst/modules/definitions/types/models/types.model.dart';
import 'package:rst/modules/stocks/stocks/controllers/stocks.controller.dart';

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

      ref.invalidate(cardsListStreamProvider);
      ref.invalidate(cardsCountProvider);
      ref.invalidate(specificCardsCountProvider);

      await AuthFunctions.autoDisconnectAfterUnauthorizedException(
        ref: ref,
        statusCode: cardAdditionResponse.statusCode,
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
            milliseconds: 1300,
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

      ref.invalidate(cardsListStreamProvider);
      ref.invalidate(cardsCountProvider);
      ref.invalidate(specificCardsCountProvider);

      await AuthFunctions.autoDisconnectAfterUnauthorizedException(
        ref: ref,
        statusCode: cardUpdateResponse.statusCode,
      );
    }
  }

  static Future<void> updateRepaymentStatus({
    required BuildContext context,
    required WidgetRef ref,
    required Card card,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    // hide validated button
    showValidatedButton.value = false;

    final cardRepaymentDate = ref.watch(cardRepaymentDateProvider);

    // instanciate the card
    Card newCard;

    if (card.repaidAt != null) {
      newCard = Card(
        label: card.label,
        type: card.type,
        typesNumber: card.typesNumber,
        customer: card.customer,
        repaidAt: null,
        createdAt: card.createdAt,
        updatedAt: card.updatedAt,
      );
    } else {
      newCard = Card(
        label: card.label,
        type: card.type,
        typesNumber: card.typesNumber,
        customer: card.customer,
        repaidAt: cardRepaymentDate,
        createdAt: card.createdAt,
        updatedAt: card.updatedAt,
      );
    }

    // debugPrint('newCard: $newCard');

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
          milliseconds: 1300,
        ),
        () {
          // pop confirmation dialog
          Navigator.of(context).pop();
        },
      );
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );

    ref.invalidate(cardsListStreamProvider);
    ref.invalidate(cardsCountProvider);
    ref.invalidate(specificCardsCountProvider);

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: cardUpdateResponse.statusCode,
    );
  }

  static Future<void> makeNormaleSatisfaction({
    required BuildContext context,
    required WidgetRef ref,
    required Card card,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    // hide validated button
    showValidatedButton.value = false;

    final cardSatisfactionDate = ref.watch(cardSatisfactionDateProvider);

    // launch card update
    final cardUpdateResponse = await StocksController.createNormalOutput(
        cardId: card.id!, agentId: 7, satisfiedAt: cardSatisfactionDate!);

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
          milliseconds: 1300,
        ),
        () {
          // pop confirmation dialog
          Navigator.of(context).pop();
        },
      );
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );

    ref.invalidate(cardsListStreamProvider);
    ref.invalidate(cardsCountProvider);
    ref.invalidate(specificCardsCountProvider);

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: cardUpdateResponse.statusCode,
    );
  }

  static Future<void> makeConstrainedOutput({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Card card,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    // save due to initial value of type product number
    formKey.currentState!.save();

    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      final cardSatisfactionDate = ref.watch(cardSatisfactionDateProvider);

      // store products and productsNumers
      final cashOperationsConstrainedOutputProductsInputsAddedVisibility =
          ref.watch(
        cashOperationsConstrainedOutputProductsInputsAddedVisibilityProvider,
      );

      List<TypeProduct> typeProducts = [];

      // for checking if data are validated so as to add or not the new type
      bool areDataValidated = true;

      // check if all typeProductInput added have a selected product
      // if true, store the selcted product
      for (MapEntry<String, bool> typeProductInputAddedVisibility
          in cashOperationsConstrainedOutputProductsInputsAddedVisibility
              .entries) {
        // check if the input is visible
        if (typeProductInputAddedVisibility.value) {
          // check if a product have been selected with-in the input
          final selectedProduct = ref.watch(
            productSelectionToolProvider(
              typeProductInputAddedVisibility.key,
            ),
          );

          // if a product is selected, store the type product
          if (selectedProduct != null) {
            // check if the product have not been selected or is not repeated
            final identicalProducts = typeProducts.where(
              (typeProduct) => typeProduct.productId == selectedProduct.id,
            );

            // if the product have been added
            if (identicalProducts.isNotEmpty) {
              areDataValidated = false;

              // show error alert
              // store response
              ref.read(feedbackDialogResponseProvider.notifier).state =
                  FeedbackDialogResponse(
                result: null,
                error: 'Répétition',
                message: 'Un produit a été plusieurs fois selectionné',
              );

              // show validated button
              showValidatedButton.value = true;

              // show alert
              FunctionsController.showAlertDialog(
                context: context,
                alertDialog: const FeedbackDialog(),
              );

              break;
            } else {
              // store the number of product defined
              final productNumber = ref.watch(
                familyIntFormFieldValueProvider(
                    typeProductInputAddedVisibility.key),
              );

              // add and store the typeProduct
              typeProducts.add(
                TypeProduct(
                  typeId: null,
                  productId: selectedProduct.id!,
                  productNumber: productNumber,
                  product: selectedProduct,
                ),
              );
            }
          } else {
            areDataValidated = false;

            // show error alert
            // store response
            ref.read(feedbackDialogResponseProvider.notifier).state =
                FeedbackDialogResponse(
              result: null,
              error: 'Manque',
              message: 'Tous les produits n\'ont pas été selectionnés',
            );

            // show validated button
            showValidatedButton.value = true;

            // show alert
            FunctionsController.showAlertDialog(
              context: context,
              alertDialog: const FeedbackDialog(),
            );

            break;
          }
        }
      }

      if (areDataValidated && typeProducts.isEmpty) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucun produit n\'a été sélectionné',
        );

        // show validated button
        showValidatedButton.value = true;

        // show alert
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );
      }

      if (areDataValidated) {
        // launch type addition
        final constrainedOutputResponse =
            await StocksController.createStockConstrainedOutput(
          cardId: card.id!,
          productsIds: typeProducts
              .map(
                (typeProduct) => typeProduct.productId,
              )
              .toList(),
          productsOutputQuantities: typeProducts
              .map(
                (typeProduct) => typeProduct.productNumber,
              )
              .toList(),
          agentId: 7,
          satisfiedAt: cardSatisfactionDate!,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: constrainedOutputResponse.result?.fr,
          error: constrainedOutputResponse.error?.fr,
          message: constrainedOutputResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide addition form if the the type have been added
        // will be execute in error
        if (constrainedOutputResponse.error == null) {
          Future.delayed(
            const Duration(
              milliseconds: 1300,
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

        ref.invalidate(cardsListStreamProvider);
        ref.invalidate(cardsCountProvider);
        ref.invalidate(specificCardsCountProvider);

        await AuthFunctions.autoDisconnectAfterUnauthorizedException(
          ref: ref,
          statusCode: constrainedOutputResponse.statusCode,
        );
      }
    }
  }

  static Future<void> makeRetrocession({
    required BuildContext context,
    required WidgetRef ref,
    required Card card,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    // hide validated button
    showValidatedButton.value = false;

    // launch card update
    final cardUpdateResponse = await StocksController.createStockRetrocession(
      cardId: card.id!,
      agentId: 7,
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
          milliseconds: 1300,
        ),
        () {
          // pop confirmation dialog
          Navigator.of(context).pop();
        },
      );
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );

    ref.invalidate(cardsListStreamProvider);
    ref.invalidate(cardsCountProvider);
    ref.invalidate(specificCardsCountProvider);

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: cardUpdateResponse.statusCode,
    );
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

    ref.invalidate(cardsListStreamProvider);
    ref.invalidate(cardsCountProvider);
    ref.invalidate(specificCardsCountProvider);

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: cardDeletionResponse.statusCode,
    );
  }
}
