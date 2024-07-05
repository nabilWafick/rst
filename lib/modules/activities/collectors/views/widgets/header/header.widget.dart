import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/activities/collectors/providers/collectors_activities.provider.dart';
import 'package:rst/modules/activities/collectors/views/widgets/dialogs/excel/excel_dialog.widget.dart';
import 'package:rst/modules/activities/collectors/views/widgets/dialogs/filter/filter_dialog.widget.dart';
import 'package:rst/modules/activities/collectors/views/widgets/dialogs/pdf/pdf_dialog.widget.dart';
import 'package:rst/modules/activities/collectors/views/widgets/dialogs/sort/sort_dialog.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class CollectorsActivitiesPageHeader extends StatefulHookConsumerWidget {
  const CollectorsActivitiesPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorsActivitiesPageHeaderState();
}

class _CollectorsActivitiesPageHeaderState
    extends ConsumerState<CollectorsActivitiesPageHeader> {
  @override
  Widget build(BuildContext context) {
    final collectorsActivitiesListParameters =
        ref.watch(collectorsActivitiesListParametersProvider);
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
                  // refresh providers counts and the collectorsActivities list
                  ref.invalidate(collectorsActivitiesListStreamProvider);
                  ref.invalidate(collectorsActivitiesCountProvider);
                  ref.invalidate(specificCollectorsActivitiesCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: collectorsActivitiesListParameters.containsKey('where') &&
                        collectorsActivitiesListParameters['where']
                            .containsKey('AND') &&
                        collectorsActivitiesListParameters['where']['AND']
                            .isNotEmpty
                    ? 'Filtré'
                    : 'Filtrer',
                light:
                    collectorsActivitiesListParameters.containsKey('where') &&
                        collectorsActivitiesListParameters['where']
                            .containsKey('AND') &&
                        collectorsActivitiesListParameters['where']['AND']
                            .isNotEmpty,
                onTap: () async {
                  final random = Random();
                  // reset added filter paramters provider
                  ref.invalidate(
                      collectorsActivitiesListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (collectorsActivitiesListParameters.containsKey('where') &&
                      collectorsActivitiesListParameters['where']
                          .containsKey('AND')) {
                    for (Map<String, dynamic> filterParameter
                        in collectorsActivitiesListParameters['where']
                            .entries
                            .last
                            // last because where contains collectionIdId and AND entries
                            .value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch +
                              random.nextInt(100000);

                      // add it to added filter parameters
                      ref
                          .read(
                        collectorsActivitiesListFilterParametersAddedProvider
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
                    alertDialog: const CollectorsActivitiesFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !collectorsActivitiesListParameters
                            .containsKey('orderBy') ||
                        !collectorsActivitiesListParameters['orderBy']
                            .isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: collectorsActivitiesListParameters
                        .containsKey('orderBy') &&
                    collectorsActivitiesListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CollectorsActivitiesSortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[
                          PermissionsValues.printCollectorsActivities]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const CollectorsActivitiesPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[
                          PermissionsValues.exportCollectorsActivities]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const CollectorsActivitiesExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              const SizedBox(
                width: 1.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
