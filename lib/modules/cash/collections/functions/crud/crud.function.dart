// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/cash/collections/controllers/collections.controller.dart';
import 'package:rst/modules/cash/collections/models/collection/collection.model.dart';
import 'package:rst/modules/cash/collections/providers/collections.provider.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';
import 'package:rst/modules/definitions/collectors/models/collectors.model.dart';

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
      final collectionAmount = ref.watch(collectionAmountProvider);
      final collectionDate = ref.watch(collectionDateProvider);

      // instanciate the collection
      final collection = Collection(
        amount: collectionAmount,
        rest: collectionAmount,
        collectedAt: collectionDate!,
        collector: Collector(
          id: 16,
          name: 'TESTER',
          firstnames: 'Tester',
          phoneNumber: '+22990909001',
          address: 'Address',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
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
      // get form inputs value
      final collectionAmount = ref.watch(collectionAmountProvider);
      final collectionDate = ref.watch(collectionDateProvider);

      // instanciate the collection
      final newCollection = Collection(
        amount: collectionAmount,
        rest: collectionAmount,
        collectedAt: collectionDate!,
        collector: Collector(
          id: 16,
          name: 'TESTER',
          firstnames: 'Tester',
          phoneNumber: '+22990909001',
          address: 'Address',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
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
  }
}
