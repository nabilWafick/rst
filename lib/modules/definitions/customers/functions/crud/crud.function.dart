// ignore_for_file: use_build_context_synchronously

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/category/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/collector/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/economical_activity/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/locality/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/personal_status/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/type/providers/selection.provider.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/customers/controllers/customers.controller.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';

import 'package:rst/modules/definitions/types/models/type/type.model.dart';

import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/customers/providers/customers.provider.dart';

class CustomersCRUDFunctions {
  static Future<void> create({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    // save due to initial value of card types number
    formKey.currentState!.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final customerName = ref.watch(customerNameProvider);
      final customerFirstnames = ref.watch(customerFirstnamesProvider);
      final customerPhoneNumber = ref.watch(customerPhoneNumberProvider);
      final customerAddress = ref.watch(customerAddressProvider);
      final customerOccupation = ref.watch(customerOccupationProvider);
      final customerNicNumber = ref.watch(customerNicNumberProvider);
      final customerCategory = ref.watch(categorySelectionToolProvider('customer-addition'));
      final customerPersonalStatus =
          ref.watch(personalStatusSelectionToolProvider('customer-addition'));
      final customerEconomicalActivity =
          ref.watch(economicalActivitySelectionToolProvider('customer-addition'));
      final customerLocality = ref.watch(localitySelectionToolProvider('customer-addition'));
      final customerCollector = ref.watch(collectorSelectionToolProvider('customer-addition'));

      // store types and typesNumers
      final customerCardsInputsAddedVisibility =
          ref.watch(customerCardsInputsAddedVisibilityProvider);

      List<String> cardsLabels = [];
      List<Type> cardsTypes = [];
      List<Card> customerCards = [];

      // for checking if data are validated so as to add or not the new type
      bool areDataValidated = true;

      // check if all customerCardInput added have a selected type
      // if true, store the selected type
      for (MapEntry<String, bool> customerCardInputAddedVisibility
          in customerCardsInputsAddedVisibility.entries) {
        // check if the input is visible
        if (customerCardInputAddedVisibility.value) {
          // store the card label
          final cardLabel = ref.watch(
            familyTextFormFieldValueProvider(
              customerCardInputAddedVisibility.key,
            ),
          );

          // check if the card label have not been selected or is not repeated
          final identicalCardsLabels = cardsLabels.where(
            (label) => label.trim() == cardLabel,
          );

          if (identicalCardsLabels.isNotEmpty) {
            areDataValidated = false;

            // show error alert
            // store response
            ref.read(feedbackDialogResponseProvider.notifier).state = FeedbackDialogResponse(
              result: null,
              error: 'Conflit',
              message: 'Un libellé a été plusieurs fois selectionnés',
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
            // add the label to cardsLabels list
            cardsLabels.add(cardLabel ?? DateTime.now().toIso8601String());

            // check if a type have been selected with-in the input
            final selectedType = ref.watch(
              typeSelectionToolProvider(
                customerCardInputAddedVisibility.key,
              ),
            );

            // if a type is selected, store the type type
            if (selectedType != null) {
              // check if the type have not been selected or is not repeated
              final identicalTypes = cardsTypes.where(
                (type) => type.id == selectedType.id,
              );

              // if the type have been added
              if (identicalTypes.isNotEmpty) {
                areDataValidated = false;

                // show error alert
                // store response
                ref.read(feedbackDialogResponseProvider.notifier).state = FeedbackDialogResponse(
                  result: null,
                  error: 'Répétition',
                  message: 'Un type a été plusieurs fois selectionné',
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
                // add the selected type to cards types list
                cardsTypes.add(selectedType);

                // store the number of type defined
                final typesNumber = ref.watch(
                  familyIntFormFieldValueProvider(
                    customerCardInputAddedVisibility.key,
                  ),
                );

                // add and store the customerCard
                customerCards.add(
                  Card(
                    label: cardLabel ?? DateTime.now().toIso8601String(),
                    type: selectedType,
                    typesNumber: typesNumber ?? 1,
                    customer: Customer(
                      id: 1000000000000000000,
                      name: customerName,
                      firstnames: customerFirstnames,
                      phoneNumber: customerPhoneNumber,
                      address: customerAddress,
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );
              }
            } else {
              areDataValidated = false;

              // show error alert
              // store response
              ref.read(feedbackDialogResponseProvider.notifier).state = FeedbackDialogResponse(
                result: null,
                error: 'Manque',
                message: 'Tous les types n\'ont pas été selectionnés',
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
      }

      if (areDataValidated && customerCards.isNotEmpty && customerCollector == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state = FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucun collecteur n\'a pas été sélectionné',
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
        // instanciate the customer
        final customer = Customer(
          name: customerName,
          firstnames: customerFirstnames,
          phoneNumber: customerPhoneNumber,
          address: customerAddress,
          occupation: customerOccupation,
          nicNumber: customerNicNumber,
          collector: customerCollector,
          locality: customerLocality,
          economicalActivity: customerEconomicalActivity,
          category: customerCategory,
          personalStatus: customerPersonalStatus,
          profile: null,
          signature: null,
          cards: customerCards,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        // launch customer addition
        final customerAdditionResponse = await CustomersController.create(
          customer: customer,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state = FeedbackDialogResponse(
          result: customerAdditionResponse.result?.fr,
          error: customerAdditionResponse.error?.fr,
          message: customerAdditionResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide addition form if the the customer have been added
        if (customerAdditionResponse.error == null) {
          Navigator.of(context).pop();
        }

        // show response
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );

        ref.invalidate(customersListStreamProvider);
        ref.invalidate(customersCountProvider);
        ref.invalidate(specificCustomersCountProvider);

        await AuthFunctions.autoDisconnectAfterUnauthorizedException(
          ref: ref,
          statusCode: customerAdditionResponse.statusCode,
        );
      }
    }
  }

  static Future<void> update({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required Customer customer,
    required ValueNotifier<bool> showValidatedButton,
  }) async {
    formKey.currentState?.save();
    final isFormValid = formKey.currentState!.validate();

    if (isFormValid) {
      // hide validated button
      showValidatedButton.value = false;

      // get form inputs value
      final customerName = ref.watch(customerNameProvider);
      final customerFirstnames = ref.watch(customerFirstnamesProvider);
      final customerPhoneNumber = ref.watch(customerPhoneNumberProvider);
      final customerAddress = ref.watch(customerAddressProvider);
      final customerOccupation = ref.watch(customerOccupationProvider);
      final customerNicNumber = ref.watch(customerNicNumberProvider);
      final customerCategory = ref.watch(categorySelectionToolProvider('customer-update'));
      final customerPersonalStatus =
          ref.watch(personalStatusSelectionToolProvider('customer-update'));
      final customerEconomicalActivity =
          ref.watch(economicalActivitySelectionToolProvider('customer-update'));
      final customerLocality = ref.watch(localitySelectionToolProvider('customer-update'));
      final customerCollector = ref.watch(collectorSelectionToolProvider('customer-update'));

      // store types and typesNumers
      final customerCardsInputsAddedVisibility =
          ref.watch(customerCardsInputsAddedVisibilityProvider);

      List<String> cardsLabels = [];
      List<Type> cardsTypes = [];
      List<Card> customerCards = [];

      // for checking if data are validated so as to add or not the new type
      bool areDataValidated = true;

      // check if all customerCardInput added have a selected type
      // if true, store the selected type
      for (MapEntry<String, bool> customerCardInputAddedVisibility
          in customerCardsInputsAddedVisibility.entries) {
        // check if the input is visible
        if (customerCardInputAddedVisibility.value) {
          // store the card label
          final cardLabel = ref.watch(
            familyTextFormFieldValueProvider(
              customerCardInputAddedVisibility.key,
            ),
          );

          // check if the card label have not been selected or is not repeated
          final identicalCardsLabels = cardsLabels.where(
            (label) => label.trim() == cardLabel,
          );

          if (identicalCardsLabels.isNotEmpty) {
            areDataValidated = false;

            // show error alert
            // store response
            ref.read(feedbackDialogResponseProvider.notifier).state = FeedbackDialogResponse(
              result: null,
              error: 'Conflit',
              message: 'Un libellé a été plusieurs fois selectionnés',
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
            // add the label to cardsLabels list
            cardsLabels.add(cardLabel ?? DateTime.now().toIso8601String());

            // check if a type have been selected with-in the input
            final selectedType = ref.watch(
              typeSelectionToolProvider(
                customerCardInputAddedVisibility.key,
              ),
            );

            // if a type is selected, store the type type
            if (selectedType != null) {
              // check if the type have not been selected or is not repeated
              /*  final identicalTypes = cardsTypes.where(
                (type) => type.id == selectedType.id,
              );
              */

              // add the selected type to cards types list
              cardsTypes.add(selectedType);

              // store the number of type defined
              final typesNumber = ref.watch(
                familyIntFormFieldValueProvider(
                  customerCardInputAddedVisibility.key,
                ),
              );

              // add and store the customerCard
              customerCards.add(
                Card(
                  // especially done for olden cards
                  // they ids have been used as key for
                  // card inputs visibility provider
                  id: int.tryParse(customerCardInputAddedVisibility.key),
                  label: cardLabel ?? DateTime.now().toIso8601String(),
                  type: selectedType,
                  typesNumber: typesNumber ?? 1,
                  customer: Customer(
                    id: customer.id,
                    name: customerName,
                    firstnames: customerFirstnames,
                    phoneNumber: customerPhoneNumber,
                    address: customerAddress,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
            } else {
              areDataValidated = false;

              // show error alert
              // store response
              ref.read(feedbackDialogResponseProvider.notifier).state = FeedbackDialogResponse(
                result: null,
                error: 'Manque',
                message: 'Tous les types n\'ont pas été selectionnés',
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
      }

      if (areDataValidated && customerCards.isNotEmpty && customerCollector == null) {
        areDataValidated = false;

        // show error alert
        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state = FeedbackDialogResponse(
          result: null,
          error: 'Conflit',
          message: 'Aucun collecteur n\'a pas été sélectionné',
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
        // instanciate the customer
        final newCustomer = Customer(
          name: customerName,
          firstnames: customerFirstnames,
          phoneNumber: customerPhoneNumber,
          address: customerAddress,
          occupation: customerOccupation,
          nicNumber: customerNicNumber,
          collector: customerCollector,
          locality: customerLocality,
          economicalActivity: customerEconomicalActivity,
          category: customerCategory,
          personalStatus: customerPersonalStatus,
          profile: null,
          signature: null,
          cards: customerCards,
          createdAt: customer.createdAt,
          updatedAt: DateTime.now(),
        );

        // launch customer update
        final customerUpdateResponse = await CustomersController.update(
          customerId: customer.id!,
          customer: newCustomer,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state = FeedbackDialogResponse(
          result: customerUpdateResponse.result?.fr,
          error: customerUpdateResponse.error?.fr,
          message: customerUpdateResponse.message!.fr,
        );

        // show validated button
        showValidatedButton.value = true;

        // hide update form if the the customer have been updated
        if (customerUpdateResponse.error == null) {
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

        ref.invalidate(customersListStreamProvider);
        ref.invalidate(customersCountProvider);
        ref.invalidate(specificCustomersCountProvider);

        await AuthFunctions.autoDisconnectAfterUnauthorizedException(
          ref: ref,
          statusCode: customerUpdateResponse.statusCode,
        );
      }
    }
  }

  static Future<void> delete({
    required BuildContext context,
    required WidgetRef ref,
    required Customer customer,
    required ValueNotifier<bool> showConfirmationButton,
  }) async {
    // hide validated button
    showConfirmationButton.value = false;

    // launch customer deletion
    final customerDeletionResponse = await CustomersController.delete(
      customerId: customer.id!,
    );

    // store response
    ref.read(feedbackDialogResponseProvider.notifier).state = FeedbackDialogResponse(
      result: customerDeletionResponse.result?.fr,
      error: customerDeletionResponse.error?.fr,
      message: customerDeletionResponse.message!.fr,
    );

    // show validated button
    showConfirmationButton.value = true;

    // hide addition form if the the customer have been added
    if (customerDeletionResponse.error == null) {
      Navigator.of(context).pop();
    }

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );

    ref.invalidate(customersListStreamProvider);
    ref.invalidate(customersCountProvider);
    ref.invalidate(specificCustomersCountProvider);

    await AuthFunctions.autoDisconnectAfterUnauthorizedException(
      ref: ref,
      statusCode: customerDeletionResponse.statusCode,
    );
  }
}
