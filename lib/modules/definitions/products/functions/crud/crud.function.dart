// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/products/controllers/products.controller.dart';
import 'package:rst/modules/definitions/products/models/product/product.model.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';

class ProductsCRUDFunctions {
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
      final productName = ref.watch(productNameProvider);
      final productPrice = ref.watch(productPurchasePriceProvider);

      // instanciate the product
      final product = Product(
        name: productName,
        purchasePrice: productPrice,
        photo: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // launch product addition
      final productAdditionResponse = await ProductsController.create(
        product: product,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: productAdditionResponse.result?.fr,
        error: productAdditionResponse.error?.fr,
        message: productAdditionResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide addition form if the the product have been added
      if (productAdditionResponse.error == null) {
        Navigator.of(context).pop();
      }

      // show response
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const FeedbackDialog(),
      );

      ref.invalidate(productsListStreamProvider);
      ref.invalidate(productsCountProvider);
      ref.invalidate(specificProductsCountProvider);

      await AuthFunctions.autoDisconnectAfterUnauthorizedException(
        ref: ref,
        statusCode: productAdditionResponse.statusCode,
      );
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Product product,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final productName = ref.watch(productNameProvider);
      final productPrice = ref.watch(productPurchasePriceProvider);

      // instanciate the product
      final newProduct = Product(
        name: productName,
        purchasePrice: productPrice,
        photo: null,
        createdAt: product.createdAt,
        updatedAt: DateTime.now(),
      );

      // launch product update
      final productUpdateResponse = await ProductsController.update(
        productId: product.id!,
        product: newProduct,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: productUpdateResponse.result?.fr,
        error: productUpdateResponse.error?.fr,
        message: productUpdateResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide update form if the the product have been updated
      if (productUpdateResponse.error == null) {
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

      ref.invalidate(productsListStreamProvider);
      ref.invalidate(productsCountProvider);
      ref.invalidate(specificProductsCountProvider);

      await AuthFunctions.autoDisconnectAfterUnauthorizedException(
        ref: ref,
        statusCode: productUpdateResponse.statusCode,
      );
    }
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Product product,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch product deletion
    final productDeletionResponse = await ProductsController.delete(
      productId: product.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: productDeletionResponse.result?.fr,
      error: productDeletionResponse.error?.fr,
      message: productDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the product have been added
    if (productDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );

    ref.invalidate(productsListStreamProvider);
    ref.invalidate(productsCountProvider);
    ref.invalidate(specificProductsCountProvider);

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: productDeletionResponse.statusCode,
    );
  }
}
