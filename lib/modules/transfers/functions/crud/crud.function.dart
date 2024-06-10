// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';
import 'package:rst/modules/transfers/controllers/transfers.controller.dart';
import 'package:rst/modules/transfers/models/transfer/transfer.model.dart';

class TransfersCRUDFunctions {
  static Future<void> createBetweenCustomerCards({
    required BuildContext context,
    required WidgetRef ref,
    required ValueNotifier<bool> enableTransferButton,
  }) async {
    // hide validated button
    enableTransferButton.value = false;

    // get form inputs value
    final transferBCCIssuingCard =
        ref.watch(cardSelectionToolProvider('transfer-bcc-issuing-card'));
    final transferBCCReceivingCard =
        ref.watch(cardSelectionToolProvider('transfer-bcc-receiving-card'));

    // instanciate the transfer

    final transfer = Transfer(
      issuingCard: transferBCCIssuingCard!,
      receivingCard: transferBCCReceivingCard!,
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

    // launch transfer addition
    final transferAdditionResponse = await TransfersController.create(
      transfer: transfer,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: transferAdditionResponse.result?.fr,
      error: transferAdditionResponse.error?.fr,
      message: transferAdditionResponse.message!.fr,
    );

    // show validated button
    enableTransferButton.value = true;

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }

  static Future<void> createBetweenCustomers({
    required BuildContext context,
    required WidgetRef ref,
    required ValueNotifier<bool> enableTransferButton,
  }) async {
    // hide validated button
    enableTransferButton.value = false;

    // get form inputs value
    final transferBCIssuingCard =
        ref.watch(cardSelectionToolProvider('transfer-bc-issuing-card'));
    final transferBCReceivingCard =
        ref.watch(cardSelectionToolProvider('transfer-bc-receiving-card'));

    // instanciate the transfer

    final transfer = Transfer(
      issuingCard: transferBCIssuingCard!,
      receivingCard: transferBCReceivingCard!,
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

    // launch transfer addition
    final transferAdditionResponse = await TransfersController.create(
      transfer: transfer,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: transferAdditionResponse.result?.fr,
      error: transferAdditionResponse.error?.fr,
      message: transferAdditionResponse.message!.fr,
    );

    // show validated button
    enableTransferButton.value = true;

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }

  static Future<void> validate({
    required BuildContext context,
    required WidgetRef ref,
    required Transfer transfer,
  }) async {
    // instanciate the transfer

    final newTransfer = transfer.copyWith(
      validatedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // launch transfer update
    final transferValidationResponse = await TransfersController.update(
      transferId: transfer.id!,
      transfer: newTransfer,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: transferValidationResponse.result?.fr,
      error: transferValidationResponse.error?.fr,
      message: transferValidationResponse.message!.fr,
    );

    // hide addition form if the the transfer have been added
    if (transferValidationResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }

  static Future<void> reject({
    required BuildContext context,
    required WidgetRef ref,
    required Transfer transfer,
  }) async {
    // instanciate the transfer

    final newTransfer = transfer.copyWith(
      rejectedAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // launch transfer update
    final transferRejectionResponse = await TransfersController.update(
      transferId: transfer.id!,
      transfer: newTransfer,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: transferRejectionResponse.result?.fr,
      error: transferRejectionResponse.error?.fr,
      message: transferRejectionResponse.message!.fr,
    );

    // hide addition form if the the transfer have been added
    if (transferRejectionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Transfer transfer,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch transfer deletion
    final transferDeletionResponse = await TransfersController.delete(
      transferId: transfer.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: transferDeletionResponse.result?.fr,
      error: transferDeletionResponse.error?.fr,
      message: transferDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the transfer have been added
    if (transferDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }
}
