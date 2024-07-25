// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/activities/collectors/providers/collectors_activities.provider.dart';
import 'package:rst/modules/activities/customer/providers/customers_activities.provider.dart';
import 'package:rst/modules/auth/connection/models/connection.model.dart';
import 'package:rst/modules/auth/connection/providers/connection.provider.dart';
import 'package:rst/modules/auth/controllers/auth.controller.dart';
import 'package:rst/modules/auth/model/auth.model.dart';
import 'package:rst/modules/auth/registration/models/registration.model.dart';
import 'package:rst/modules/auth/registration/providers/registration.provider.dart';
import 'package:rst/modules/auth/services/auth.service.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/collections/providers/collections.provider.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/dashboard/providers/dashboard.provider.dart';
import 'package:rst/modules/definitions/agents/providers/agents.provider.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';
import 'package:rst/modules/definitions/categories/providers/categories.provider.dart';
import 'package:rst/modules/definitions/collectors/providers/collectors.provider.dart';
import 'package:rst/modules/definitions/customers/providers/customers.provider.dart';
import 'package:rst/modules/definitions/economical_activities/providers/economical_activities.provider.dart';
import 'package:rst/modules/definitions/localities/providers/localities.provider.dart';
import 'package:rst/modules/definitions/personal_status/providers/personal_status.provider.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/modules/statistics/collectors_collections/providers/collectors_collections.provider.dart';
import 'package:rst/modules/statistics/products_forecasts/providers/products_forecasts.provider.dart';
import 'package:rst/modules/statistics/types_stat/providers/types_stat.provider.dart';
import 'package:rst/modules/stocks/stocks/providers/stocks.provider.dart';
import 'package:rst/modules/transfers/validations/providers/validations.provider.dart';
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
        // invalidate home providers
        invalidateHomePageProviders(
          ref: ref,
        );

        // invalidate modules main providers
        invalidateModulesMainProviders(
          ref: ref,
        );

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
          final prefs = await SharedPreferences.getInstance();

          final Auth? auth = userConnectionResponse.data[0];

          // store email
          await prefs.setString(
            RSTPreferencesKeys.email,
            auth?.agent.email ?? '',
          );

          // store name
          await prefs.setString(
            RSTPreferencesKeys.name,
            auth?.agent.name ?? '',
          );

          // store firstnames
          await prefs.setString(
            RSTPreferencesKeys.firstnames,
            auth?.agent.firstnames ?? '',
          );

          // store permissions
          await prefs.setString(
            RSTPreferencesKeys.permissions,
            jsonEncode(auth?.agent.permissions),
          );

          // store accesToken
          await prefs.setString(
            RSTPreferencesKeys.accesToken,
            auth?.accessToken ?? '',
          );

          // navigate to home page
          Navigator.of(context).pushReplacementNamed(RoutesManager.main);
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
    required ValueNotifier<bool> showDisconnectionButton,
  }) async {
    try {
      // hide disconnection button
      showDisconnectionButton.value = false;

      final prefs = await SharedPreferences.getInstance();

      final userEmail = prefs.getString(RSTPreferencesKeys.email) ?? '';

      // launch agent disconnection
      final userDisconnectionResponse = await AuthController.disconnect(
        userEmail: userEmail,
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
        // remove preferences data
        removeDataStored();

        ref.read(authNameProvider.notifier).state = null;

        ref.read(authFirstnamesProvider.notifier).state = null;

        ref.read(authEmailProvider.notifier).state = null;

        ref.read(authAccesTokenProvider.notifier).state = null;

        // show disconection button
        showDisconnectionButton.value = true;

        // pop confirmation dialog
        Navigator.of(context).pop();

        // navigate to connection page
        Navigator.of(context).pushReplacementNamed(
          RoutesManager.main,
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

  static Future<void> disconnectOnInit() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final userEmail = prefs.getString(RSTPreferencesKeys.email);

      if (userEmail != null) {
        await AuthController.disconnect(
          userEmail: userEmail,
        );

        // remove stored data
        removeDataStored();
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static Future<void> disconnectAgent({
    required WidgetRef ref,
    required BuildContext context,
    required String agentEmail,
  }) async {
    try {
      // launch agent disconnection
      final agentDisconnectionResponse = await AuthController.disconnect(
        userEmail: agentEmail,
      );

      // store response
      ref.read(feedbackDialogResponseProvider.notifier).state =
          FeedbackDialogResponse(
        result: agentDisconnectionResponse.result?.fr,
        error: agentDisconnectionResponse.error?.fr,
        message: 'L\'agent a été déconnecté avec succès',
      );

      // show response
      FunctionsController.showAlertDialog(
        context: context,
        alertDialog: const FeedbackDialog(),
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  static void invalidateHomePageProviders({
    required dynamic ref,
  }) {
    // reset all home provider
    // necessary in case where user is already login
    // but disonnect due to expired token for example

    ref.read(authNameProvider.notifier).state = null;

    ref.read(authFirstnamesProvider.notifier).state = null;

    ref.read(authEmailProvider.notifier).state = null;

    ref.read(authAccesTokenProvider.notifier).state = null;

    ref.read(authPermissionsProvider.notifier).state = null;

    ref.invalidate(modulesVisibilityConditionsProvider);

    ref.invalidate(sidebarOptionsProvider);

    ref.invalidate(selectedSidebarOptionProvider);

    ref.invalidate(selectedSidebarSubOptionProvider);
  }

  static Future<void> removeDataStored() async {
    final prefs = await SharedPreferences.getInstance();

    // remove all user data stored

    // remove email
    await prefs.remove(RSTPreferencesKeys.email);

    // remove name
    await prefs.remove(RSTPreferencesKeys.name);

    // remove firstnames
    await prefs.remove(RSTPreferencesKeys.firstnames);

    // remove accessToken
    await prefs.remove(RSTPreferencesKeys.accesToken);

    // remove permissions
    await prefs.remove(RSTPreferencesKeys.permissions);
  }

  static Future<void> autoDisconnectAfterUnauthorizedException({
    required dynamic ref,
    required num statusCode,
  }) async {
    // debugPrint('Auto called');

    // debugPrint('Status Code: $statusCode');

    // check the status code
    if (statusCode == 401) {
      // check if the disconnection have not be done
      final authEmail = ref.watch(authEmailProvider);

      final response = await AuthServices.disconnect(
        userEmail: authEmail,
      );

      if (authEmail != null && response.statusCode == 200) {
        // remove stored dta
        removeDataStored();

        // reset home providers
        invalidateHomePageProviders(
          ref: ref,
        );

        // invalidate modules main providers
      }
    }
  }

  static void invalidateModulesMainProviders({
    required dynamic ref,
  }) {
    // refresh modules main providers
    // its for getting new data
    // it is necessary in case where user logout and login without close the app

    // dashboard
    ref.invalidate(dashboardCollectorsCollectionsListParametersProvider);
    ref.invalidate(
        dashboardCollectorsCollectionsListFilterParametersAddedProvider);
    ref.invalidate(dashboardDayCollectorsCollectionsListStreamProvider);
    ref.invalidate(dashboardWeekCollectorsCollectionsListStreamProvider);
    ref.invalidate(dashboardMonthCollectorsCollectionsListStreamProvider);
    ref.invalidate(dashboardYearCollectorsCollectionsListStreamProvider);
    ref.invalidate(dashboardGlobalCollectorsCollectionsListStreamProvider);

    // products
    ref.invalidate(productsListParametersProvider);
    ref.invalidate(productsListFilterParametersAddedProvider);
    ref.invalidate(productsListStreamProvider);
    ref.invalidate(productsCountProvider);
    ref.invalidate(specificProductsCountProvider);

    // types
    ref.invalidate(typesListParametersProvider);
    ref.invalidate(typesListFilterParametersAddedProvider);
    ref.invalidate(typesListStreamProvider);
    ref.invalidate(typesCountProvider);
    ref.invalidate(specificTypesCountProvider);

    // customers
    ref.invalidate(customersListParametersProvider);
    ref.invalidate(customersListFilterParametersAddedProvider);
    ref.invalidate(customersListStreamProvider);
    ref.invalidate(customersCountProvider);
    ref.invalidate(specificCustomersCountProvider);

    // collectors
    ref.invalidate(collectorsListParametersProvider);
    ref.invalidate(collectorsListFilterParametersAddedProvider);
    ref.invalidate(collectorsListStreamProvider);
    ref.invalidate(collectorsCountProvider);
    ref.invalidate(specificCollectorsCountProvider);

    // cards
    ref.invalidate(cardsListParametersProvider);
    ref.invalidate(cardsListFilterParametersAddedProvider);
    ref.invalidate(cardsListStreamProvider);
    ref.invalidate(cardsCountProvider);
    ref.invalidate(specificCardsCountProvider);

    // agents
    ref.invalidate(agentsListParametersProvider);
    ref.invalidate(agentsListFilterParametersAddedProvider);
    ref.invalidate(agentsListStreamProvider);
    ref.invalidate(agentsCountProvider);
    ref.invalidate(specificAgentsCountProvider);

    // categories
    ref.invalidate(categoriesListParametersProvider);
    ref.invalidate(categoriesListFilterParametersAddedProvider);
    ref.invalidate(categoriesListStreamProvider);
    ref.invalidate(categoriesCountProvider);
    ref.invalidate(specificCategoriesCountProvider);

    // localities
    ref.invalidate(localitiesListParametersProvider);
    ref.invalidate(localitiesListFilterParametersAddedProvider);
    ref.invalidate(localitiesListStreamProvider);
    ref.invalidate(localitiesCountProvider);
    ref.invalidate(specificLocalitiesCountProvider);

    // economicalActivities
    ref.invalidate(economicalActivitiesListParametersProvider);
    ref.invalidate(economicalActivitiesListFilterParametersAddedProvider);
    ref.invalidate(economicalActivitiesListStreamProvider);
    ref.invalidate(economicalActivitiesCountProvider);
    ref.invalidate(specificEconomicalActivitiesCountProvider);

    // personalStatus
    ref.invalidate(personalStatusListParametersProvider);
    ref.invalidate(personalStatusListFilterParametersAddedProvider);
    ref.invalidate(personalStatusListStreamProvider);
    ref.invalidate(personalStatusCountProvider);
    ref.invalidate(specificPersonalStatusCountProvider);

    // cash
    ref.invalidate(cashOperationsSelectedCollectorProvider);
    ref.invalidate(cashOperationsSelectedCustomerProvider);
    ref.invalidate(cashOperationsSelectedCustomerCardProvider);
    ref.invalidate(cashOperationsSelectedCustomerCardsProvider);
    ref.invalidate(cashOperationsShowAllCustomerCardsProvider);
    ref.invalidate(
        cashOperationsConstrainedOutputProductsInputsAddedVisibilityProvider);
    ref.invalidate(cashOperationsSelectedCardTotalSettlementsNumbersProvider);
    ref.invalidate(cashOperationsSelectedCardSettlementsListParametersProvider);
    ref.invalidate(cashOperationsSelectedCardSettlementsProvider);
    ref.invalidate(cashOperationsSelectedCardSettlementsCountProvider);
    ref.invalidate(cashOperationsSelectedCardSpecificSettlementsCountProvider);

    // collections
    ref.invalidate(collectionsListParametersProvider);
    ref.invalidate(collectionsListFilterParametersAddedProvider);
    ref.invalidate(collectionsListStreamProvider);
    ref.invalidate(collectionsCountProvider);
    ref.invalidate(collectionsSumProvider);
    ref.invalidate(collectionsRestSumProvider);
    ref.invalidate(specificCollectionsCountProvider);
    ref.invalidate(specificCollectionsSumProvider);
    ref.invalidate(specificCollectionsRestSumProvider);
    ref.invalidate(dayCollectionProvider);
    ref.invalidate(monthCollectionProvider);
    ref.invalidate(weekCollectionProvider);
    ref.invalidate(yearCollectionProvider);

    // settlements
    ref.invalidate(settlementsListParametersProvider);
    ref.invalidate(multipleSettlementsAddedInputsVisibilityProvider);
    ref.invalidate(multipleSettlementsSelectedCustomerCardsProvider);
    ref.invalidate(settlementsListFilterParametersAddedProvider);
    ref.invalidate(settlementsListStreamProvider);
    ref.invalidate(settlementsCountProvider);
    ref.invalidate(specificSettlementsCountProvider);

    // collectors activities
    ref.invalidate(collectorsActivitiesListParametersProvider);
    ref.invalidate(collectorsActivitiesListFilterParametersAddedProvider);
    ref.invalidate(collectorsActivitiesListStreamProvider);
    ref.invalidate(collectorsActivitiesCountProvider);
    ref.invalidate(specificCollectorsActivitiesCountProvider);

    // customers activities
    ref.invalidate(customerActivitiesSelectedCustomerProvider);
    ref.invalidate(customerActivitiesSelectedCustomerCardProvider);
    ref.invalidate(customerActivitiesSelectedCollectorProvider);
    ref.invalidate(customerActivitiesSelectedCustomerCardsProvider);
    ref.invalidate(customerActivitiesShowAllCustomerCardsProvider);
    ref.invalidate(
        customerActivitiesSelectedCardTotalSettlementsNumbersProvider);
    ref.invalidate(
        customerActivitiesSelectedCardSettlementsListParametersProvider);
    ref.invalidate(customerActivitiesSelectedCardSettlementsProvider);
    ref.invalidate(customerActivitiesSelectedCardSettlementsCountProvider);
    ref.invalidate(
        customerActivitiesSelectedCardSpecificSettlementsCountProvider);

    // collectors statistics
    ref.invalidate(collectorCollectionTypeProvider);
    ref.invalidate(collectorsCollectionsListParametersProvider);
    ref.invalidate(collectorsCollectionsListFilterParametersAddedProvider);
    ref.invalidate(collectorsCollectionsListStreamProvider);
    ref.invalidate(collectorsCollectionsCountProvider);
    ref.invalidate(specificCollectorsCollectionsCountProvider);

    // types Stats
    ref.invalidate(typesStatsListParametersProvider);
    ref.invalidate(typesStatsListFilterParametersAddedProvider);
    ref.invalidate(typesStatsListStreamProvider);
    ref.invalidate(typesStatsCountProvider);
    ref.invalidate(specificTypesStatsCountProvider);

    // products forecasts
    ref.invalidate(productsForecastsListParametersProvider);
    ref.invalidate(productsForecastsListStreamProvider);
    ref.invalidate(productsForecastsCountProvider);
    ref.invalidate(specificProductsForecastsCountProvider);

    // transfers
    ref.invalidate(transfersListParametersProvider);
    ref.invalidate(transfersListFilterParametersAddedProvider);
    ref.invalidate(transfersListStreamProvider);
    ref.invalidate(transfersCountProvider);
    ref.invalidate(specificTransfersCountProvider);

    // stocks
    // types
    ref.invalidate(stocksListParametersProvider);
    ref.invalidate(stocksListFilterParametersAddedProvider);
    ref.invalidate(stocksListStreamProvider);
    ref.invalidate(stocksCountProvider);
    ref.invalidate(specificStocksCountProvider);
  }
}
