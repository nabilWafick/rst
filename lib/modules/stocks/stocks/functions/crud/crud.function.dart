// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/product/providers/selection.provider.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';
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

        await AuthFunctions.autoDisconnectAfterUnauthorizedException(
          ref: ref,
          statusCode: stockAdditionResponse.statusCode,
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

        await AuthFunctions.autoDisconnectAfterUnauthorizedException(
          ref: ref,
          statusCode: stockAdditionResponse.statusCode,
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

        await AuthFunctions.autoDisconnectAfterUnauthorizedException(
          ref: ref,
          statusCode: stockUpdateResponse.statusCode,
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

        await AuthFunctions.autoDisconnectAfterUnauthorizedException(
          ref: ref,
          statusCode: stockUpdateResponse.statusCode,
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

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: stockDeletionResponse.statusCode,
    );
  }
}
