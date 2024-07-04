// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/collectors/controllers/collectors.controller.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';
import 'package:rst/modules/definitions/collectors/providers/collectors.provider.dart';

class CollectorsCRUDFunctions {
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
      final collectorName = ref.watch(collectorNameProvider);
      final collectorFirstnames = ref.watch(collectorFirstnamesProvider);

      final collectorPhoneNumber = ref.watch(collectorPhoneNumberProvider);
      final collectorAddress = ref.watch(collectorAddressProvider);

      // instanciate the collector
      final collector = Collector(
        name: collectorName,
        firstnames: collectorFirstnames,
        phoneNumber: collectorPhoneNumber,
        address: collectorAddress,
        profile: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // launch collector addition
      final collectorAdditionResponse = await CollectorsController.create(
        collector: collector,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: collectorAdditionResponse.result?.fr,
        error: collectorAdditionResponse.error?.fr,
        message: collectorAdditionResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide addition form if the the collector have been added
      if (collectorAdditionResponse.error == null) {
        Navigator.of(context).pop();
      }

      // show response
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const FeedbackDialog(),
      );

      ref.invalidate(collectorsListStreamProvider);
      ref.invalidate(collectorsCountProvider);
      ref.invalidate(specificCollectorsCountProvider);

      await AuthFunctions.autoDisconnectAfterUnauthorizedException(
        ref: ref,
        statusCode: collectorAdditionResponse.statusCode,
      );
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Collector collector,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final collectorName = ref.watch(collectorNameProvider);
      final collectorFirstnames = ref.watch(collectorFirstnamesProvider);

      final collectorPhoneNumber = ref.watch(collectorPhoneNumberProvider);
      final collectorAddress = ref.watch(collectorAddressProvider);

      // instanciate the collector
      final newcollector = Collector(
        name: collectorName,
        firstnames: collectorFirstnames,
        phoneNumber: collectorPhoneNumber,
        address: collectorAddress,
        profile: null,
        createdAt: collector.createdAt,
        updatedAt: DateTime.now(),
      );

      // launch collector update
      final collectorUpdateResponse = await CollectorsController.update(
        collectorId: collector.id!,
        collector: newcollector,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: collectorUpdateResponse.result?.fr,
        error: collectorUpdateResponse.error?.fr,
        message: collectorUpdateResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide update form if the the collector have been updated
      if (collectorUpdateResponse.error == null) {
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

      ref.invalidate(collectorsListStreamProvider);
      ref.invalidate(collectorsCountProvider);
      ref.invalidate(specificCollectorsCountProvider);

      await AuthFunctions.autoDisconnectAfterUnauthorizedException(
        ref: ref,
        statusCode: collectorUpdateResponse.statusCode,
      );
    }
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Collector collector,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch collector deletion
    final collectorDeletionResponse = await CollectorsController.delete(
      collectorId: collector.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: collectorDeletionResponse.result?.fr,
      error: collectorDeletionResponse.error?.fr,
      message: collectorDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the collector have been added
    if (collectorDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );

    ref.invalidate(collectorsListStreamProvider);
    ref.invalidate(collectorsCountProvider);
    ref.invalidate(specificCollectorsCountProvider);

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: collectorDeletionResponse.statusCode,
    );
  }
}
