// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/product/providers/selection.provider.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';
import 'package:rst/modules/definitions/types/models/type_product/type_product.model.dart';
import 'package:rst/modules/stocks/stocks/controllers/stocks.controller.dart';
import 'package:rst/modules/stocks/stocks/models/stock/stock.model.dart';
import 'package:rst/modules/stocks/stocks/providers/stocks.provider.dart';

class StocksCRUDFunctions {
  static Future<void> createStockManualInput({
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
      final product = ref.watch(productSelectionToolProvider('stock-input'));
      final stockInputQuantity = ref.watch(stockInputQuantityProvider);

      bool areDataValidated = true;

      if (product == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucune produit n\'a été sélectionné',
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
        // instanciate the stock
        final stock = Stock(
          product: product!,
          initialQuantity: 0,
          stockQuantity: 1,
          inputQuantity: stockInputQuantity,
          agent: Agent(
            id: 7,
            name: 'TESTER',
            firstnames: 'Tester',
            phoneNumber: '+22990909001',
            email: 'tester@tester.test',
            address: 'Address',
            permissions: {},
            views: {},
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // launch stock addition
        final stockAdditionResponse = await StocksController.createManualInput(
          stock: stock,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: stockAdditionResponse.result?.fr,
          error: stockAdditionResponse.error?.fr,
          message: stockAdditionResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide addition form if the the stock have been added
        if (stockAdditionResponse.error == null) {
          Navigator.of(context).pop();
        }

        // show response
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );
      }
    }
  }

  static Future<void> createStockManualOutput({
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
      final product = ref.watch(productSelectionToolProvider('stock-output'));
      final stockOutputQuantity = ref.watch(stockOutputQuantityProvider);

      bool areDataValidated = true;

      if (product == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucune produit n\'a été sélectionné',
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
        // instanciate the stock
        final stock = Stock(
          product: product!,
          initialQuantity: 0,
          stockQuantity: 1,
          outputQuantity: stockOutputQuantity,
          agent: Agent(
            id: 7,
            name: 'TESTER',
            firstnames: 'Tester',
            phoneNumber: '+22990909001',
            email: 'tester@tester.test',
            address: 'Address',
            permissions: {},
            views: {},
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // launch stock addition
        final stockAdditionResponse = await StocksController.createManualOutput(
          stock: stock,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: stockAdditionResponse.result?.fr,
          error: stockAdditionResponse.error?.fr,
          message: stockAdditionResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide addition form if the the stock have been added
        if (stockAdditionResponse.error == null) {
          Navigator.of(context).pop();
        }

        // show response
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );
      }
    }
  }

  static Future<void> createConstrainedOutput({
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
                satisfiedAt: cardSatisfactionDate!);

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
      }
    }
  }

  static Future<void> updateStockManualInput({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Stock stock,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value

      final product = ref.watch(productSelectionToolProvider('stock-input'));
      final stockInputQuantity = ref.watch(stockInputQuantityProvider);

      bool areDataValidated = true;

      if (product == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucune produit n\'a été sélectionné',
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
        // instanciate the stock
        final newStock = Stock(
          product: product!,
          initialQuantity: 0,
          stockQuantity: 1,
          inputQuantity: stockInputQuantity,
          agent: Agent(
            id: 7,
            name: 'TESTER',
            firstnames: 'Tester',
            phoneNumber: '+22990909001',
            email: 'tester@tester.test',
            address: 'Address',
            permissions: {},
            views: {},
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          createdAt: stock.createdAt,
          updatedAt: DateTime.now(),
        );

        // launch stock update
        final stockUpdateResponse = await StocksController.updateManualInput(
          stockId: stock.id!,
          stock: newStock,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: stockUpdateResponse.result?.fr,
          error: stockUpdateResponse.error?.fr,
          message: stockUpdateResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide update form if the the stock have been updated
        if (stockUpdateResponse.error == null) {
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
      }
    }
  }

  static Future<void> updateStockManualOutput({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Stock stock,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value

      final product = ref.watch(productSelectionToolProvider('stock-output'));
      final stockOutputQuantity = ref.watch(stockOutputQuantityProvider);

      bool areDataValidated = true;

      if (product == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucune produit n\'a été sélectionné',
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
        // instanciate the stock
        final newStock = Stock(
          product: product!,
          initialQuantity: 0,
          stockQuantity: 1,
          outputQuantity: stockOutputQuantity,
          agent: Agent(
            id: 7,
            name: 'TESTER',
            firstnames: 'Tester',
            phoneNumber: '+22990909001',
            email: 'tester@tester.test',
            address: 'Address',
            permissions: {},
            views: {},
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          createdAt: stock.createdAt,
          updatedAt: DateTime.now(),
        );

        // launch stock update
        final stockUpdateResponse = await StocksController.updateManualOutput(
          stockId: stock.id!,
          stock: newStock,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: stockUpdateResponse.result?.fr,
          error: stockUpdateResponse.error?.fr,
          message: stockUpdateResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide update form if the the stock have been updated
        if (stockUpdateResponse.error == null) {
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
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Stock stock,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch stock deletion
    final stockDeletionResponse = await StocksController.delete(
      stockId: stock.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: stockDeletionResponse.result?.fr,
      error: stockDeletionResponse.error?.fr,
      message: stockDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the stock have been added
    if (stockDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }
}
