// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/cash/settlements/models/settlement/settlement.model.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';

class SettlementsCRUDFunctions {
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
      final settlementNumber = ref.watch(settlementNumberProvider);
      final cashOperationsSelectedCustomerCard =
          ref.watch(cashOperationsSelectedCustomerCardProvider);
      final settlementCollectionDate =
          ref.watch(settlementCollectionDateProvider);
      final settlementCollectorCollection =
          ref.watch(settlementCollectorCollectionProvider);

      bool areDataValidated = true;

      if (settlementCollectionDate == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucune date de collecte n\'a été sélectionnée',
        );

        // show validated button
        showValidatedButton.value = true;

        // show alert
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );
      }

      if (areDataValidated && settlementCollectorCollection == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucune collecte n\'a été trouvée pour cette date',
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
        // instanciate the settlement
        final settlement = Settlement(
          number: settlementNumber,
          isValidated: true,
          card: cashOperationsSelectedCustomerCard!,
          collection: settlementCollectorCollection,
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

        // launch settlement addition
        final settlementAdditionResponse = await SettlementsController.create(
          settlement: settlement,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: settlementAdditionResponse.result?.fr,
          error: settlementAdditionResponse.error?.fr,
          message: settlementAdditionResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide addition form if the the settlement have been added
        if (settlementAdditionResponse.error == null) {
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

  static Future<void> createMultipleSettlements({
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

      final settlementCollectionDate =
          ref.watch(settlementCollectionDateProvider);
      final settlementCollectorCollection =
          ref.watch(settlementCollectorCollectionProvider);

      bool areDataValidated = true;

      if (settlementCollectionDate == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucune date de collecte n\'a été sélectionnée',
        );

        // show validated button
        showValidatedButton.value = true;

        // show alert
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );
      }

      if (areDataValidated && settlementCollectorCollection == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucune collecte n\'a été trouvée pour cette date',
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
        // instanciate the settlements

        final multipleSettlementsAddedInputsVisibility =
            ref.watch(multipleSettlementsAddedInputsVisibilityProvider);

        List<Settlement> settlements = [];

        for (MapEntry<String, bool> settlementInputVisibility
            in multipleSettlementsAddedInputsVisibility.entries) {
          if (settlementInputVisibility.value) {
            settlements.add(
              Settlement(
                number: ref.watch(familyIntFormFieldValueProvider(
                    settlementInputVisibility.key)),
                isValidated: true,
                card: ref.watch(
                  cardSelectionToolProvider(settlementInputVisibility.key),
                )!,
                collection: settlementCollectorCollection,
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
              ),
            );
          }
        }

        // launch settlement addition
        final settlementAdditionResponse =
            await SettlementsController.createMultiple(
          settlements: settlements,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: settlementAdditionResponse.result?.fr,
          error: settlementAdditionResponse.error?.fr,
          message: settlementAdditionResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide addition form if the the settlement have been added
        if (settlementAdditionResponse.error == null) {
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
    required Settlement settlement,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value

      final settlementNumber = ref.watch(settlementNumberProvider);

      bool areDataValidated = true;

      if (areDataValidated) {
        // instanciate the settlement
        final newSettlement = Settlement(
          number: settlementNumber,
          isValidated: settlement.isValidated,
          card: settlement.card,
          collection: settlement.collection,
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
          createdAt: settlement.createdAt,
          updatedAt: DateTime.now(),
        );

        // launch settlement update
        final settlementUpdateResponse = await SettlementsController.update(
          settlementId: settlement.id!,
          settlement: newSettlement,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: settlementUpdateResponse.result?.fr,
          error: settlementUpdateResponse.error?.fr,
          message: settlementUpdateResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide update form if the the settlement have been updated
        if (settlementUpdateResponse.error == null) {
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

  static Future<void> toggleValidation({
    required BuildContext context,
    required WidgetRef ref,
    required Settlement settlement,
  }) async {
    // instanciate the settlement
    final newSettlement = settlement.copyWith(
      isValidated: !settlement.isValidated,
    );

    // launch settlement update
    final settlementUpdateResponse = await SettlementsController.update(
      settlementId: settlement.id!,
      settlement: newSettlement,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: settlementUpdateResponse.result?.fr,
      error: settlementUpdateResponse.error?.fr,
      message: settlementUpdateResponse.message!.fr,
    );

    // hide update form if the the settlement have been updated
    if (settlementUpdateResponse.error == null) {
      // delay due response dialog
      Future.delayed(
        const Duration(
          milliseconds: 1500,
        ),
        () {
          // pop confirmation dialog
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

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Settlement settlement,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch settlement deletion
    final settlementDeletionResponse = await SettlementsController.delete(
      settlementId: settlement.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: settlementDeletionResponse.result?.fr,
      error: settlementDeletionResponse.error?.fr,
      message: settlementDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the settlement have been added
    if (settlementDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }
}
