import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/modules/definitions/types/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/modules/statistics/types_stat/providers/types_stat.provider.dart';
import 'package:rst/modules/statistics/types_stat/views/widgets/dialogs/excel/excel_dialog.widget.dart';
import 'package:rst/modules/statistics/types_stat/views/widgets/dialogs/pdf/pdf_dialog.widget.dart';

class TypesStatsPageHeader extends StatefulHookConsumerWidget {
  const TypesStatsPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TypesStatsPageHeaderState();
}

class _TypesStatsPageHeaderState extends ConsumerState<TypesStatsPageHeader> {
  @override
  Widget build(BuildContext context) {
    final typesStatsListParameters =
        ref.watch(typesStatsListParametersProvider);

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
                  // refresh providers counts and the types list
                  ref.invalidate(typesStatsListStreamProvider);
                  ref.invalidate(typesStatsCountProvider);
                  ref.invalidate(specificTypesStatsCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: typesStatsListParameters.containsKey('where') &&
                        ((typesStatsListParameters['where']
                                    .containsKey('AND') &&
                                typesStatsListParameters['where']['AND']
                                    .isNotEmpty) ||
                            (typesStatsListParameters['where']
                                    .containsKey('OR') &&
                                typesStatsListParameters['where']['OR']
                                    .isNotEmpty) ||
                            (typesStatsListParameters['where']
                                    .containsKey('NOR') &&
                                typesStatsListParameters['where']['NOR']
                                    .isNotEmpty))
                    ? 'Filtré'
                    : 'Filtrer',
                light: typesStatsListParameters.containsKey('where') &&
                    ((typesStatsListParameters['where'].containsKey('AND') &&
                            typesStatsListParameters['where']['AND']
                                .isNotEmpty) ||
                        (typesStatsListParameters['where'].containsKey('OR') &&
                            typesStatsListParameters['where']['OR']
                                .isNotEmpty) ||
                        (typesStatsListParameters['where'].containsKey('NOR') &&
                            typesStatsListParameters['where']['NOR']
                                .isNotEmpty)),
                onTap: () async {
                  final random = Random();
                  // reset added filter paramters provider
                  ref.invalidate(typesListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (typesStatsListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in typesStatsListParameters['where']
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
                        typesListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const TypeFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !typesStatsListParameters.containsKey('orderBy') ||
                        !typesStatsListParameters['orderBy'].isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: typesStatsListParameters.containsKey('orderBy') &&
                    typesStatsListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const TypeSortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printTypesStatistics]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const TypesStatsPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportTypesStatistics]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const TypesStatsExcelFileGenerationDialog(),
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
