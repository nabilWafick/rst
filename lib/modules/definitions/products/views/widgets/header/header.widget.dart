import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/modules/definitions/products/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/products/views/widgets/forms/addition/product_addition.widget.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class ProductsPageHeader extends StatefulHookConsumerWidget {
  const ProductsPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsPageHeaderState();
}

class _ProductsPageHeaderState extends ConsumerState<ProductsPageHeader> {
  @override
  Widget build(BuildContext context) {
    final productsListParameters = ref.watch(productsListParametersProvider);
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
                  // refresh providers counts and the products list
                  ref.invalidate(productsListStreamProvider);
                  ref.invalidate(productsCountProvider);
                  ref.invalidate(specificProductsCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: productsListParameters.containsKey('where') &&
                        ((productsListParameters['where'].containsKey('AND') &&
                                productsListParameters['where']
                                        ['AND']
                                    .isNotEmpty) ||
                            (productsListParameters['where']
                                    .containsKey('OR') &&
                                productsListParameters['where']['OR']
                                    .isNotEmpty) ||
                            (productsListParameters['where']
                                    .containsKey('NOR') &&
                                productsListParameters['where']['NOR']
                                    .isNotEmpty))
                    ? 'Filtré'
                    : 'Filtrer',
                light: productsListParameters.containsKey('where') &&
                    ((productsListParameters['where'].containsKey('AND') &&
                            productsListParameters['where']['AND']
                                .isNotEmpty) ||
                        (productsListParameters['where'].containsKey('OR') &&
                            productsListParameters['where']['OR'].isNotEmpty) ||
                        (productsListParameters['where'].containsKey('NOR') &&
                            productsListParameters['where']['NOR'].isNotEmpty)),
                onTap: () async {
                  final random = Random();
                  // reset added filter paramters provider
                  ref.invalidate(productsListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (productsListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in productsListParameters['where']
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
                        productsListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const ProductFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !productsListParameters.containsKey('orderBy') ||
                        !productsListParameters['orderBy'].isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: productsListParameters.containsKey('orderBy') &&
                    productsListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const ProductSortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printProductsList]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const ProductPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportProductsList]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const ProductExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.addProduct]
                  ? RSTAddButton(
                      onTap: () {
                        ref.read(productPhotoProvider.notifier).state = null;
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const ProductAdditionForm(),
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
