import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/modules/definitions/products/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/products/views/widgets/forms/addition/product_addition.widget.dart';

class ProductsPageHeader extends ConsumerWidget {
  const ProductsPageHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsFilterOptions = ref.watch(productsFilterOptionsProvider);
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
                text: !productsFilterOptions.containsKey('where')
                    ? 'Filtrer'
                    : 'Filtré',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const ProductFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !productsFilterOptions.containsKey('orderBy')
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
