import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/selection_tools/category/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/collector/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/economical_activity/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/locality/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/personal_status/providers/selection.provider.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/customers/providers/customers.provider.dart';
import 'package:rst/modules/definitions/customers/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/customers/views/widgets/forms/addition/customer_addition.widget.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class CustomersPageHeader extends StatefulHookConsumerWidget {
  const CustomersPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersPageHeaderState();
}

class _CustomersPageHeaderState extends ConsumerState<CustomersPageHeader> {
  @override
  Widget build(BuildContext context) {
    final customersListParameters = ref.watch(customersListParametersProvider);
    final authPermissions = ref.watch(authPermissionsProvider);
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RSTIconButton(
                icon: Icons.refresh_outlined,
                text: 'Rafraichir',
                onTap: () {
                  // refresh providers counts and the customers list
                  ref.invalidate(customersListStreamProvider);
                  ref.invalidate(customersCountProvider);
                  ref.invalidate(specificCustomersCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: customersListParameters.containsKey('where') &&
                        customersListParameters['where'].containsKey('AND') &&
                        customersListParameters['where']['AND'].isNotEmpty
                    ? 'Filtré'
                    : 'Filtrer',
                light: customersListParameters.containsKey('where') &&
                    customersListParameters['where'].containsKey('AND') &&
                    customersListParameters['where']['AND'].isNotEmpty,
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(customersListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (customersListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in customersListParameters['where']
                            .entries
                            .first
                            .value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch;

                      // add it to added filter parameters
                      ref
                          .read(
                        customersListFilterParametersAddedProvider.notifier,
                      )
                          .update(
                        (state) {
                          state = {
                            ...state,
                            filterToolIndex: filterParameter,
                          };
                          return state;
                        },
                      );

                      // define the operators and the values

                      defineFilterToolOperatorAndValue(
                        ref: ref,
                        filterToolIndex: filterToolIndex,
                        filterParameter: filterParameter,
                      );
                    }
                  }

                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CustomerFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !customersListParameters.containsKey('orderBy') ||
                        !customersListParameters['orderBy'].isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: customersListParameters.containsKey('orderBy') &&
                    customersListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CustomerSortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printCustomersList]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CustomerPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportCustomersList]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const CustomerExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.addCustomer]
                  ? RSTAddButton(
                      onTap: () {
                        ref.read(customerProfileProvider.notifier).state = null;
                        ref.read(customerSignatureProvider.notifier).state =
                            null;

                        ref
                            .read(customerCardsInputsAddedVisibilityProvider
                                .notifier)
                            .state = {};

                        ref.invalidate(collectorSelectionToolProvider(
                            'customer-addition'));
                        ref.invalidate(
                            categorySelectionToolProvider('customer-addition'));
                        ref.invalidate(personalStatusSelectionToolProvider(
                            'customer-addition'));
                        ref.invalidate(economicalActivitySelectionToolProvider(
                            'customer-addition'));
                        ref.invalidate(
                            localitySelectionToolProvider('customer-addition'));

                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CustomerAdditionForm(),
                        );
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
