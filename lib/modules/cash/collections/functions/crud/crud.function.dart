// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/collector/providers/selection.provider.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/cash/collections/controllers/collections.controller.dart';
import 'package:rst/modules/cash/collections/models/collection/collection.model.dart';
import 'package:rst/modules/cash/collections/providers/collections.provider.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';

class CollectionsCRUDFunctions {
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
      final collector =
          ref.watch(collectorSelectionToolProvider('collection-addition'));
      final collectionAmount = ref.watch(collectionAmountProvider);
      final collectionDate = ref.watch(collectionDateProvider);

      bool areDataValidated = true;

      // check if a collector have been selected
      if (collector == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucun collecteur n\'a été sélectionné',
        );

        // show validated button
        showValidatedButton.value = true;

        // show alert
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );
      }

      // check if a collector have been selected
      if (areDataValidated && collectionDate == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucune date n\'a été sélectionnée',
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
        // instanciate the collection
        final collection = Collection(
          amount: collectionAmount,
          rest: collectionAmount,
          collectedAt: collectionDate!,
          collector: collector!,
          agent: Agent(
            name: 'TESTER',
            firstnames: 'Tester',
            phoneNumber: '+22990909001',
            email: 'tester@tester.test',
            address: 'Address',
            permissions: {},
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // launch collection addition
        final collectionAdditionResponse = await CollectionsController.create(
          collection: collection,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: collectionAdditionResponse.result?.fr,
          error: collectionAdditionResponse.error?.fr,
          message: collectionAdditionResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide addition form if the the collection have been added
        if (collectionAdditionResponse.error == null) {
          Navigator.of(context).pop();
        }

        // show response
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );

        ref.invalidate(collectionsListStreamProvider);
        ref.invalidate(collectionsCountProvider);
        ref.invalidate(specificCollectionsCountProvider);
        ref.invalidate(collectionsSumProvider);
        ref.invalidate(collectionsRestSumProvider);
        ref.invalidate(specificCollectionsSumProvider);
        ref.invalidate(specificCollectionsRestSumProvider);

        await AuthFunctions.autoDisconnectAfterUnauthorizedException(
          ref: ref,
          statusCode: collectionAdditionResponse.statusCode,
        );
      }
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Collection collection,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final collector =
          ref.watch(collectorSelectionToolProvider('collection-update'));
      final collectionAmount = ref.watch(collectionAmountProvider);
      final collectionDate = ref.watch(collectionDateProvider);

      bool areDataValidated = true;

      // check if a collector have been selected
      if (collector == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucun collecteur n\'a été sélectionné',
        );

        // show validated button
        showValidatedButton.value = true;

        // show alert
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );
      }

      // check if a collector have been selected
      if (areDataValidated && collectionDate == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucune date n\'a été sélectionnée',
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
        // instanciate the collection
        final newCollection = Collection(
          amount: collectionAmount,
          rest: collectionAmount,
          collectedAt: collectionDate!,
          collector: collector!,
          agent: collection.agent,
          createdAt: collection.createdAt,
          updatedAt: DateTime.now(),
        );

        // launch collection update
        final collectionUpdateResponse = await CollectionsController.update(
          collectionId: collection.id!,
          collection: newCollection,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: collectionUpdateResponse.result?.fr,
          error: collectionUpdateResponse.error?.fr,
          message: collectionUpdateResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide update form if the the collection have been updated
        if (collectionUpdateResponse.error == null) {
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

        ref.invalidate(collectionsListStreamProvider);
        ref.invalidate(collectionsCountProvider);
        ref.invalidate(specificCollectionsCountProvider);
        ref.invalidate(collectionsSumProvider);
        ref.invalidate(collectionsRestSumProvider);
        ref.invalidate(specificCollectionsSumProvider);
        ref.invalidate(specificCollectionsRestSumProvider);

        await AuthFunctions.autoDisconnectAfterUnauthorizedException(
          ref: ref,
          statusCode: collectionUpdateResponse.statusCode,
        );
      }
    }
  }

  static Future<void> increase({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Collection collection,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value

      final increaseAmount = ref.watch(collectionAmountProvider);

      try {
        // launch collection amount increase
        final collectionUpdateResponse = await CollectionsController.increase(
          collectionId: collection.id!,
          amount: {
            'amount': increaseAmount,
          },
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: collectionUpdateResponse.result?.fr,
          error: collectionUpdateResponse.error?.fr,
          message: collectionUpdateResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide update form if the the collection have been updated
        if (collectionUpdateResponse.error == null) {
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

        ref.invalidate(collectionsListStreamProvider);
        ref.invalidate(collectionsCountProvider);
        ref.invalidate(specificCollectionsCountProvider);
        ref.invalidate(collectionsSumProvider);
        ref.invalidate(collectionsRestSumProvider);
        ref.invalidate(specificCollectionsSumProvider);
        ref.invalidate(specificCollectionsRestSumProvider);

        await AuthFunctions.autoDisconnectAfterUnauthorizedException(
          ref: ref,
          statusCode: collectionUpdateResponse.statusCode,
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  static Future<void> decrease({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Collection collection,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value

      final decreaseAmount = ref.watch(collectionAmountProvider);

      // launch collection amount increase
      final collectionUpdateResponse = await CollectionsController.decrease(
        collectionId: collection.id!,
        amount: {
          'amount': decreaseAmount,
        },
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: collectionUpdateResponse.result?.fr,
        error: collectionUpdateResponse.error?.fr,
        message: collectionUpdateResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide update form if the the collection have been updated
      if (collectionUpdateResponse.error == null) {
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

      ref.invalidate(collectionsListStreamProvider);
      ref.invalidate(collectionsCountProvider);
      ref.invalidate(specificCollectionsCountProvider);
      ref.invalidate(collectionsSumProvider);
      ref.invalidate(collectionsRestSumProvider);
      ref.invalidate(specificCollectionsSumProvider);
      ref.invalidate(specificCollectionsRestSumProvider);

      await AuthFunctions.autoDisconnectAfterUnauthorizedException(
        ref: ref,
        statusCode: collectionUpdateResponse.statusCode,
      );
    }
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Collection collection,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch collection deletion
    final collectionDeletionResponse = await CollectionsController.delete(
      collectionId: collection.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: collectionDeletionResponse.result?.fr,
      error: collectionDeletionResponse.error?.fr,
      message: collectionDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the collection have been added
    if (collectionDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );

    ref.invalidate(collectionsListStreamProvider);
    ref.invalidate(collectionsCountProvider);
    ref.invalidate(specificCollectionsCountProvider);
    ref.invalidate(collectionsSumProvider);
    ref.invalidate(collectionsRestSumProvider);
    ref.invalidate(specificCollectionsSumProvider);
    ref.invalidate(specificCollectionsRestSumProvider);

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: collectionDeletionResponse.statusCode,
    );
  }
}
