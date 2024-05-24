import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/modules/definitions/products/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/products/views/widgets/forms/addition/product_addition.widget.dart';

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
                text: !productsListParameters.containsKey('where')
                    ? 'Filtrer'
                    : 'Filtré',
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(productsListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (productsListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in productsListParameters['where']
                            .entries
                            // first for logical operator
                            .first
                            .value) {
                      ref
                          .read(
                        productsListFilterParametersAddedProvider.notifier,
                      )
                          .update((state) {
                        state = {
                          ...state,
                          DateTime.now().millisecondsSinceEpoch:
                              filterParameter,
                        };
                        return state;
                      });
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
                text: !productsListParameters.containsKey('orderBy')
                    ? 'Trier'
                    : 'Trié',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const ProductSortDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.print_outlined,
                text: 'Imprimer',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const ProductPdfGenerationDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.view_module_outlined,
                text: 'Exporter',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const ProductExcelFileGenerationDialog(),
                  );
                },
              ),
              RSTAddButton(
                onTap: () {
                  ref.read(productPhotoProvider.notifier).state = null;
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const ProductAdditionForm(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
