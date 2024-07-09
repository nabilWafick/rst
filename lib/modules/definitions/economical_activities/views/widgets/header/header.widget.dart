import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/economical_activities/providers/economical_activities.provider.dart';
import 'package:rst/modules/definitions/economical_activities/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/economical_activities/views/widgets/forms/addition/economical_activity_addition.widget.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class EconomicalActivitiesPageHeader extends StatefulHookConsumerWidget {
  const EconomicalActivitiesPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EconomicalActivitiesPageHeaderState();
}

class _EconomicalActivitiesPageHeaderState
    extends ConsumerState<EconomicalActivitiesPageHeader> {
  @override
  Widget build(BuildContext context) {
    final economicalActivitiesListParameters =
        ref.watch(economicalActivitiesListParametersProvider);
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
                  // refresh providers counts and the economicalActivities list
                  ref.invalidate(economicalActivitiesListStreamProvider);
                  ref.invalidate(economicalActivitiesCountProvider);
                  ref.invalidate(specificEconomicalActivitiesCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: economicalActivitiesListParameters.containsKey('where') &&
                        ((economicalActivitiesListParameters['where']
                                    .containsKey('AND') &&
                                economicalActivitiesListParameters['where']
                                        ['AND']
                                    .isNotEmpty) ||
                            (economicalActivitiesListParameters['where']
                                    .containsKey('OR') &&
                                economicalActivitiesListParameters['where']
                                        ['OR']
                                    .isNotEmpty) ||
                            (economicalActivitiesListParameters['where']
                                    .containsKey('NOR') &&
                                economicalActivitiesListParameters['where']
                                        ['NOR']
                                    .isNotEmpty))
                    ? 'Filtré'
                    : 'Filtrer',
                light: economicalActivitiesListParameters
                        .containsKey('where') &&
                    ((economicalActivitiesListParameters['where']
                                .containsKey('AND') &&
                            economicalActivitiesListParameters['where']['AND']
                                .isNotEmpty) ||
                        (economicalActivitiesListParameters['where']
                                .containsKey('OR') &&
                            economicalActivitiesListParameters['where']['OR']
                                .isNotEmpty) ||
                        (economicalActivitiesListParameters['where']
                                .containsKey('NOR') &&
                            economicalActivitiesListParameters['where']['NOR']
                                .isNotEmpty)),
                onTap: () async {
                  final random = Random();

                  // reset added filter paramters provider
                  ref.invalidate(
                      economicalActivitiesListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (economicalActivitiesListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in economicalActivitiesListParameters['where']
                            .entries
                            .first
                            .value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch +
                              random.nextInt(100000);

                      // add it to added filter parameters
                      ref
                          .read(
                        economicalActivitiesListFilterParametersAddedProvider
                            .notifier,
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
                    alertDialog: const EconomicalActivityFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !economicalActivitiesListParameters
                            .containsKey('orderBy') ||
                        !economicalActivitiesListParameters['orderBy']
                            .isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: economicalActivitiesListParameters
                        .containsKey('orderBy') &&
                    economicalActivitiesListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const EconomicalActivitySortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[
                          PermissionsValues.printEconomicalActivitesList]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const EconomicalActivityPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[
                          PermissionsValues.exportEconomicalActivitiesList]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const EconomicalActivityExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.addEconomicalActivity]
                  ? RSTAddButton(
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const EconomicalActivityAdditionForm(),
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
