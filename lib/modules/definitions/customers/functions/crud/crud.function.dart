// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/definitions/customers/controllers/customers.controller.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';
import 'package:rst/modules/definitions/customers/providers/customers.provider.dart';

class CustomersCRUDFunctions {
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
      final customerName = ref.watch(customerNameProvider);
      final customerFirstnames = ref.watch(customerFirstnamesProvider);
      final customerPhoneNumber = ref.watch(customerPhoneNumberProvider);
      final customerAddress = ref.watch(customerAddressProvider);
      final customerOccupation = ref.watch(customerOccupationProvider);
      final customerNicNumber = ref.watch(customerNicNumberProvider);

      // instanciate the customer
      final customer = Customer(
        name: customerName,
        firstnames: customerFirstnames,
        phoneNumber: customerPhoneNumber,
        address: customerAddress,
        occupation: customerOccupation,
        nicNumber: customerNicNumber,
        collector: null,
        locality: null,
        economicalActivity: null,
        category: null,
        personalStatus: null,
        profile: null,
        signature: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // launch customer addition
      final customerAdditionResponse = await CustomersController.create(
        customer: customer,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
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

      // instanciate the customer
      final newcustomer = Customer(
        name: customerName,
        firstnames: customerFirstnames,
        phoneNumber: customerPhoneNumber,
        address: customerAddress,
        occupation: customerOccupation,
        nicNumber: customerNicNumber,
        collector: null,
        locality: null,
        economicalActivity: null,
        category: null,
        personalStatus: null,
        profile: null,
        signature: null,
        createdAt: customer.createdAt,
        updatedAt: DateTime.now(),
      );

      // launch customer update
      final customerUpdateResponse = await CustomersController.update(
        customerId: customer.id!,
        customer: newcustomer,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
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
    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
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
  }
}
