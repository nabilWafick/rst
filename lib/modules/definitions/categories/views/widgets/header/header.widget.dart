import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/categories/providers/categories.provider.dart';
import 'package:rst/modules/definitions/categories/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/categories/views/widgets/forms/addition/category_addition.widget.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class CategoriesPageHeader extends StatefulHookConsumerWidget {
  const CategoriesPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoriesPageHeaderState();
}

class _CategoriesPageHeaderState extends ConsumerState<CategoriesPageHeader> {
  @override
  Widget build(BuildContext context) {
    final categoriesListParameters =
        ref.watch(categoriesListParametersProvider);
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
                  // refresh providers counts and the categories list
                  ref.invalidate(categoriesListStreamProvider);
                  ref.invalidate(categoriesCountProvider);
                  ref.invalidate(specificCategoriesCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: categoriesListParameters.containsKey('where') &&
                        categoriesListParameters['where'].containsKey('AND') &&
                        categoriesListParameters['where']['AND'].isNotEmpty
                    ? 'Filtré'
                    : 'Filtrer',
                light: categoriesListParameters.containsKey('where') &&
                    categoriesListParameters['where'].containsKey('AND') &&
                    categoriesListParameters['where']['AND'].isNotEmpty,
                onTap: () async {
                  final random = Random();
                  // reset added filter paramters provider
                  ref.invalidate(categoriesListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (categoriesListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in categoriesListParameters['where']
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
                        categoriesListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const CategoryFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !categoriesListParameters.containsKey('orderBy') ||
                        !categoriesListParameters['orderBy'].isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: categoriesListParameters.containsKey('orderBy') &&
                    categoriesListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CategorySortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printCategoriesList]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CategoryPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportCategoriesList]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const CategoryExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.addCategory]
                  ? RSTAddButton(
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CategoryAdditionForm(),
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
