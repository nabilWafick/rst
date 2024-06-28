import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/cash/settlements/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class SettlementsPageHeader extends StatefulHookConsumerWidget {
  const SettlementsPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettlementsPageHeaderState();
}

class _SettlementsPageHeaderState extends ConsumerState<SettlementsPageHeader> {
  @override
  Widget build(BuildContext context) {
    final settlementsListParameters =
        ref.watch(settlementsListParametersProvider);
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
                  // refresh providers counts and the settlements list
                  ref.invalidate(settlementsListStreamProvider);
                  ref.invalidate(settlementsCountProvider);
                  ref.invalidate(specificSettlementsCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: settlementsListParameters.containsKey('where') &&
                        settlementsListParameters['where'].containsKey('AND') &&
                        settlementsListParameters['where']['AND'].isNotEmpty
                    ? 'Filtré'
                    : 'Filtrer',
                light: settlementsListParameters.containsKey('where') &&
                    settlementsListParameters['where'].containsKey('AND') &&
                    settlementsListParameters['where']['AND'].isNotEmpty,
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(settlementsListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (settlementsListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in settlementsListParameters['where']
                            .entries
                            .first
                            .value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch;

                      // add it to added filter parameters
                      ref
                          .read(
                        settlementsListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const SettlementFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !settlementsListParameters.containsKey('orderBy') ||
                        !settlementsListParameters['orderBy'].isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: settlementsListParameters.containsKey('orderBy') &&
                    settlementsListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const SettlementSortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printSettlementsList]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const SettlementPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportSettlementsList]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const SettlementExcelFileGenerationDialog(),
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
