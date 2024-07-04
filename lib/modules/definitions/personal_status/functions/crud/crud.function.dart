// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/personal_status/controllers/personal_status.controller.dart';
import 'package:rst/modules/definitions/personal_status/models/personal_status/personal_status.model.dart';
import 'package:rst/modules/definitions/personal_status/providers/personal_status.provider.dart';

class PersonalStatusCRUDFunctions {
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
      final personalStatusName = ref.watch(personalStatusNameProvider);

      // instanciate the personalStatus
      final personalStatus = PersonalStatus(
        name: personalStatusName,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // launch personalStatus addition
      final personalStatusAdditionResponse =
          await PersonalStatusController.create(
        personalStatus: personalStatus,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: personalStatusAdditionResponse.result?.fr,
        error: personalStatusAdditionResponse.error?.fr,
        message: personalStatusAdditionResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide addition form if the the personalStatus have been added
      if (personalStatusAdditionResponse.error == null) {
        Navigator.of(context).pop();
      }

      // show response
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const FeedbackDialog(),
      );

      ref.invalidate(personalStatusListStreamProvider);
      ref.invalidate(personalStatusCountProvider);
      ref.invalidate(specificPersonalStatusCountProvider);

      await AuthFunctions.autoDisconnectAfterUnauthorizedException(
        ref: ref,
        statusCode: personalStatusAdditionResponse.statusCode,
      );
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required PersonalStatus personalStatus,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final personalStatusName = ref.watch(personalStatusNameProvider);

      // instanciate the personalStatus
      final newpersonalStatus = PersonalStatus(
        name: personalStatusName,
        createdAt: personalStatus.createdAt,
        updatedAt: DateTime.now(),
      );

      // launch personalStatus update
      final personalStatusUpdateResponse =
          await PersonalStatusController.update(
        personalStatusId: personalStatus.id!,
        personalStatus: newpersonalStatus,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: personalStatusUpdateResponse.result?.fr,
        error: personalStatusUpdateResponse.error?.fr,
        message: personalStatusUpdateResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide update form if the the personalStatus have been updated
      if (personalStatusUpdateResponse.error == null) {
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
        statusCode: personalStatusUpdateResponse.statusCode,
      );
    }
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required PersonalStatus personalStatus,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch personalStatus deletion
    final personalStatusDeletionResponse =
        await PersonalStatusController.delete(
      personalStatusId: personalStatus.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: personalStatusDeletionResponse.result?.fr,
      error: personalStatusDeletionResponse.error?.fr,
      message: personalStatusDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the personalStatus have been added
    if (personalStatusDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: personalStatusDeletionResponse.statusCode,
    );
  }
}
