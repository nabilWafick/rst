// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/product/providers/selection.provider.dart';
import 'package:rst/modules/definitions/types/controllers/types.controller.dart';
import 'package:rst/modules/definitions/types/models/types.model.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';

class TypesCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    // save due to initial value of type product number
    formKey.currentState!.save();

    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final typeName = ref.watch(typeNameProvider);
      final typeStake = ref.watch(typeStakeProvider);

      // store products and productsNumers
      final typeProductsInputsAddedVisibility =
          ref.watch(typeProductsInputsAddedVisibilityProvider);

      List<TypeProduct> typeProducts = [];

      // for checking if data are validated so as to add or not the new type
      bool areDataValidated = true;

      // check if all typeProductInput added have a selected product
      // if true, store the selcted product
      for (MapEntry<String, bool> typeProductInputAddedVisibility
          in typeProductsInputsAddedVisibility.entries) {
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
        // instanciate the type

        final type = Type(
          name: typeName,
          stake: typeStake,
          typeProducts: typeProducts,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // launch type addition
        final typeAdditionResponse = await TypesController.create(
          type: type,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: typeAdditionResponse.result?.fr,
          error: typeAdditionResponse.error?.fr,
          message: typeAdditionResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide addition form if the the type have been added
        // will be execute in error
        if (typeAdditionResponse.error == null) {
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

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Type type,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final typeName = ref.watch(typeNameProvider);
      final typeStake = ref.watch(typeStakeProvider);

      // store products and productsNumers
      final typeProductsInputsAddedVisibility =
          ref.watch(typeProductsInputsAddedVisibilityProvider);

      List<TypeProduct> typeProducts = [];

      // for checking if data are validated so as to add or not the new type
      bool areDataValidated = true;

      // check if all typeProductInput added have a selected product
      // if true, store the selcted product
      for (MapEntry<String, bool> typeProductInputAddedVisibility
          in typeProductsInputsAddedVisibility.entries) {
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
        // instanciate the type
        final newtype = Type(
          name: typeName,
          stake: typeStake,
          typeProducts: typeProducts,
          createdAt: type.createdAt,
          updatedAt: DateTime.now(),
        );

        // launch type update
        final typeUpdateResponse = await TypesController.update(
          typeId: type.id!,
          type: newtype,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: typeUpdateResponse.result?.fr,
          error: typeUpdateResponse.error?.fr,
          message: typeUpdateResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide update form if the the type have been updated
        if (typeUpdateResponse.error == null) {
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
    required Type type,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch type deletion
    final typeDeletionResponse = await TypesController.delete(
      typeId: type.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: typeDeletionResponse.result?.fr,
      error: typeDeletionResponse.error?.fr,
      message: typeDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the type have been added
    if (typeDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }
}
