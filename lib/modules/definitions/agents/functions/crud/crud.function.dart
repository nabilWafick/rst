// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/definitions/agents/controllers/agents.controller.dart';
import 'package:rst/modules/definitions/agents/models/agent/agent.model.dart';
import 'package:rst/modules/definitions/agents/providers/agents.provider.dart';

class AgentsCRUDFunctions {
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
      final agentName = ref.watch(agentNameProvider);
      final agentFirstnames = ref.watch(agentFirstnamesProvider);
      final agentEmail = ref.watch(agentEmailProvider);
      final agentPhoneNumber = ref.watch(agentPhoneNumberProvider);
      final agentAddress = ref.watch(agentAddressProvider);
      final agentPermissions = ref.watch(agentPermissionsProvider);

      // instanciate the agent
      final agent = Agent(
        name: agentName,
        firstnames: agentFirstnames,
        email: agentEmail,
        phoneNumber: agentPhoneNumber,
        address: agentAddress,
        permissions: agentPermissions,
        views: {
          'dashboard': false,
        },
        profile: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      //  debugPrint('Instanciated Agent: $agent');

      // launch agent addition
      final agentAdditionResponse = await AgentsController.create(
        agent: agent,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: agentAdditionResponse.result?.fr,
        error: agentAdditionResponse.error?.fr,
        message: agentAdditionResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide addition form if the the agent have been added
      if (agentAdditionResponse.error == null) {
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
    required Agent agent,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final agentName = ref.watch(agentNameProvider);
      final agentFirstnames = ref.watch(agentFirstnamesProvider);
      final agentEmail = ref.watch(agentEmailProvider);
      final agentPhoneNumber = ref.watch(agentPhoneNumberProvider);
      final agentAddress = ref.watch(agentAddressProvider);
      final agentPermissions = ref.watch(agentPermissionsProvider);

      // instanciate the agent
      final newAgent = Agent(
        name: agentName,
        firstnames: agentFirstnames,
        email: agentEmail,
        phoneNumber: agentPhoneNumber,
        address: agentAddress,
        permissions: agentPermissions,
        views: {
          'dashboard': false,
        },
        profile: null,
        createdAt: agent.createdAt,
        updatedAt: DateTime.now(),
      );

      // launch agent update
      final agentUpdateResponse = await AgentsController.update(
        agentId: agent.id!,
        agent: newAgent,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: agentUpdateResponse.result?.fr,
        error: agentUpdateResponse.error?.fr,
        message: agentUpdateResponse.message!.fr,
      );

      // show validated button
      showValidatedButton.value = true;

      // hide update form if the the agent have been updated
      if (agentUpdateResponse.error == null) {
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
    required Agent agent,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch agent deletion
    final agentDeletionResponse = await AgentsController.delete(
      agentId: agent.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: agentDeletionResponse.result?.fr,
      error: agentDeletionResponse.error?.fr,
      message: agentDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the agent have been added
    if (agentDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }
}
