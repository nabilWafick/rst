// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/auth/connection/models/connection.model.dart';
import 'package:rst/modules/auth/connection/providers/connection.provider.dart';
import 'package:rst/modules/auth/controllers/auth.controller.dart';
import 'package:rst/modules/auth/model/auth.model.dart';
import 'package:rst/modules/auth/registration/models/registration.model.dart';
import 'package:rst/modules/auth/registration/providers/registration.provider.dart';
import 'package:rst/routes/routes.dart';
import 'package:rst/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthFunctions {
  static Future<void> register({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> enableRegistrationButton,
  }) async {
    try {
      final isFormValid = formKey.currentState!.validate();
      if (isFormValid) {
        // disable registration button
        enableRegistrationButton.value = false;

        // get form inputs value
        final newUserEmail = ref.watch(newUserEmailProvider);
        final newUserPassword = ref.watch(newUserPasswordProvider);

        // instanciate the user
        final newUser = AuthRegistration(
          email: newUserEmail,
          password: newUserPassword,
          securityQuestions: {},
        );

        //  debugPrint('Instanciated Agent: $agent');

        // launch agent addition
        final userRegistrationResponse = await AuthController.register(
          authRegistration: newUser,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: userRegistrationResponse.result?.fr,
          error: userRegistrationResponse.error?.fr,
          message: userRegistrationResponse.message!.fr,
        );

        // enable registration button
        enableRegistrationButton.value = true;

        // navigate to home page
        if (userRegistrationResponse.error == null) {
          RoutesManager.navigateTo(
            context: context,
            routeName: RoutesManager.connection,
          );
        }

        // show response
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );
      }
    } catch (error) {
      // enable registration button
      enableRegistrationButton.value = true;

      debugPrint(error.toString());
    }
  }

  static Future<void> connect({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required WidgetRef ref,
    required ValueNotifier<bool> enableConnectionButton,
  }) async {
    try {
      final isFormValid = formKey.currentState!.validate();
      if (isFormValid) {
        // disable connection button
        enableConnectionButton.value = false;

        // get form inputs value
        final userEmail = ref.watch(userEmailProvider);
        final userPassword = ref.watch(userPasswordProvider);

        // instanciate the user
        final user = AuthConnection(
          email: userEmail,
          password: userPassword,
        );

        // launch agent connection
        final userConnectionResponse = await AuthController.connect(
          authConnection: user,
        );

        // store response
        ref.read(feedbackDialogResponseProvider.notifier).state =
            FeedbackDialogResponse(
          result: userConnectionResponse.result?.fr,
          error: userConnectionResponse.error?.fr,
          message: userConnectionResponse.message!.fr,
        );

        //enable connection button
        enableConnectionButton.value = true;

        // navigate to home page
        if (userConnectionResponse.error == null) {
          // TODOS
          // store auth user data in preferenses data
          // shared preferences

          final prefs = await SharedPreferences.getInstance();

          final Auth? auth = userConnectionResponse.data[0];

          // store auth
          await prefs.setString(
            RSTPreferencesKeys.auth,
            jsonEncode(auth),
          );

          // navigate to home page
          Navigator.of(context).pushReplacementNamed(RoutesManager.home);
        }

        // show response
        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: const FeedbackDialog(),
        );
      }
    } catch (error) {
      //enable connection button
      enableConnectionButton.value = true;

      debugPrint(error.toString());
    }
  }

  static Future<void> disconnect({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final auth = prefs.getString(RSTPreferencesKeys.auth) ?? '';

      // launch agent disconnection
      final userDisconnectionResponse = await AuthController.disconnect(
        userEmail: jsonDecode(auth).agent.email,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: userDisconnectionResponse.result?.fr,
        error: userDisconnectionResponse.error?.fr,
        message: userDisconnectionResponse.message!.fr,
      );

      // navigate to home page
      if (userDisconnectionResponse.error == null) {
        // remove all user data stored

        // remove auth
        await prefs.remove(RSTPreferencesKeys.auth);

        // navigate to connection page
        Navigator.of(context).pushReplacementNamed(
          RoutesManager.connection,
        );
      }

      // show response
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const FeedbackDialog(),
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
