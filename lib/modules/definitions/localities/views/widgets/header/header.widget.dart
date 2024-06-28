import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/localities/providers/localities.provider.dart';
import 'package:rst/modules/definitions/localities/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/localities/views/widgets/forms/addition/locality_addition.widget.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class LocalitiesPageHeader extends StatefulHookConsumerWidget {
  const LocalitiesPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LocalitiesPageHeaderState();
}

class _LocalitiesPageHeaderState extends ConsumerState<LocalitiesPageHeader> {
  @override
  Widget build(BuildContext context) {
    final localitiesListParameters =
        ref.watch(localitiesListParametersProvider);
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
                  // refresh providers counts and the localities list
                  ref.invalidate(localitiesListStreamProvider);
                  ref.invalidate(localitiesCountProvider);
                  ref.invalidate(specificLocalitiesCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: localitiesListParameters.containsKey('where') &&
                        localitiesListParameters['where'].containsKey('AND') &&
                        localitiesListParameters['where']['AND'].isNotEmpty
                    ? 'Filtré'
                    : 'Filtrer',
                light: localitiesListParameters.containsKey('where') &&
                    localitiesListParameters['where'].containsKey('AND') &&
                    localitiesListParameters['where']['AND'].isNotEmpty,
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(localitiesListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (localitiesListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in localitiesListParameters['where']
                            .entries
                            .first
                            .value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch;

                      // add it to added filter parameters
                      ref
                          .read(
                        localitiesListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const LocalityFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !localitiesListParameters.containsKey('orderBy') ||
                        !localitiesListParameters['orderBy'].isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: localitiesListParameters.containsKey('orderBy') &&
                    localitiesListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const LocalitySortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printLocalitiesList]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const LocalityPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportLocalitiesList]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const LocalityExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.addLocality]
                  ? RSTAddButton(
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const LocalityAdditionForm(),
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
