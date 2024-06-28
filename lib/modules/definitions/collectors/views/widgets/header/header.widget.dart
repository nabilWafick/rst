import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/collectors/providers/collectors.provider.dart';
import 'package:rst/modules/definitions/collectors/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/collectors/views/widgets/forms/addition/collector_addition.widget.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class CollectorsPageHeader extends StatefulHookConsumerWidget {
  const CollectorsPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorsPageHeaderState();
}

class _CollectorsPageHeaderState extends ConsumerState<CollectorsPageHeader> {
  @override
  Widget build(BuildContext context) {
    final collectorsListParameters =
        ref.watch(collectorsListParametersProvider);
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
                  // refresh providers counts and the collectors list
                  ref.invalidate(collectorsListStreamProvider);
                  ref.invalidate(collectorsCountProvider);
                  ref.invalidate(specificCollectorsCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: collectorsListParameters.containsKey('where') &&
                        collectorsListParameters['where'].containsKey('AND') &&
                        collectorsListParameters['where']['AND'].isNotEmpty
                    ? 'Filtré'
                    : 'Filtrer',
                light: collectorsListParameters.containsKey('where') &&
                    collectorsListParameters['where'].containsKey('AND') &&
                    collectorsListParameters['where']['AND'].isNotEmpty,
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(collectorsListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (collectorsListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in collectorsListParameters['where']
                            .entries
                            .first
                            .value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch;

                      // add it to added filter parameters
                      ref
                          .read(
                        collectorsListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const CollectorFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !collectorsListParameters.containsKey('orderBy') ||
                        !collectorsListParameters['orderBy'].isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: collectorsListParameters.containsKey('orderBy') &&
                    collectorsListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CollectorSortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printCollectorsList]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CollectorPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportCollectorsList]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const CollectorExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.addCollector]
                  ? RSTAddButton(
                      onTap: () {
                        ref.read(collectorProfileProvider.notifier).state =
                            null;
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CollectorAdditionForm(),
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
