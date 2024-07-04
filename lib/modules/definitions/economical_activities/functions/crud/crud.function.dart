// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/economical_activities/controllers/economical_activities.controller.dart';
import 'package:rst/modules/definitions/economical_activities/models/economical_activity/economical_activity.model.dart';
import 'package:rst/modules/definitions/economical_activities/providers/economical_activities.provider.dart';

class EconomicalActivitiesCRUDFunctions {
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
      final economicalActivityName = ref.watch(economicalActivityNameProvider);

      // instanciate the economicalActivity
      final economicalActivity = EconomicalActivity(
        name: economicalActivityName,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // launch economicalActivity addition
      final economicalActivityAdditionResponse =
          await EconomicalActivitiesController.create(
        economicalActivity: economicalActivity,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: economicalActivityAdditionResponse.result?.fr,
        error: economicalActivityAdditionResponse.error?.fr,
        message: economicalActivityAdditionResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide addition form if the the economicalActivity have been added
      if (economicalActivityAdditionResponse.error == null) {
        Navigator.of(context).pop();
      }

      // show response
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const FeedbackDialog(),
      );

      ref.invalidate(economicalActivitiesListStreamProvider);
      ref.invalidate(economicalActivitiesCountProvider);
      ref.invalidate(specificEconomicalActivitiesCountProvider);

      await AuthFunctions.autoDisconnectAfterUnauthorizedException(
        ref: ref,
        statusCode: economicalActivityAdditionResponse.statusCode,
      );
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required EconomicalActivity economicalActivity,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final economicalActivityName = ref.watch(economicalActivityNameProvider);

      // instanciate the economicalActivity
      final neweconomicalActivity = EconomicalActivity(
        name: economicalActivityName,
        createdAt: economicalActivity.createdAt,
        updatedAt: DateTime.now(),
      );

      // launch economicalActivity update
      final economicalActivityUpdateResponse =
          await EconomicalActivitiesController.update(
        economicalActivityId: economicalActivity.id!,
        economicalActivity: neweconomicalActivity,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: economicalActivityUpdateResponse.result?.fr,
        error: economicalActivityUpdateResponse.error?.fr,
        message: economicalActivityUpdateResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide update form if the the economicalActivity have been updated
      if (economicalActivityUpdateResponse.error == null) {
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

      ref.invalidate(economicalActivitiesListStreamProvider);
      ref.invalidate(economicalActivitiesCountProvider);
      ref.invalidate(specificEconomicalActivitiesCountProvider);

      await AuthFunctions.autoDisconnectAfterUnauthorizedException(
        ref: ref,
        statusCode: economicalActivityUpdateResponse.statusCode,
      );
    }
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required EconomicalActivity economicalActivity,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch economicalActivity deletion
    final economicalActivityDeletionResponse =
        await EconomicalActivitiesController.delete(
      economicalActivityId: economicalActivity.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: economicalActivityDeletionResponse.result?.fr,
      error: economicalActivityDeletionResponse.error?.fr,
      message: economicalActivityDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the economicalActivity have been added
    if (economicalActivityDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );

    ref.invalidate(economicalActivitiesListStreamProvider);
    ref.invalidate(economicalActivitiesCountProvider);
    ref.invalidate(specificEconomicalActivitiesCountProvider);

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: economicalActivityDeletionResponse.statusCode,
    );
  }
}
