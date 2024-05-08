// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
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

      //* TEST
      debugPrint('productName: $productName');

      // instanciate the product
      final product = Product(
        name: productName,
        purchasePrice: productPrice,
        photo: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // launch product adding
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
    }
    return;
  }
}
