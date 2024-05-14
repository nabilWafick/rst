// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';
import 'package:rst/modules/definitions/products/models/structure/structure.model.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class ProductSortDialog extends HookConsumerWidget {
  const ProductSortDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final showSortOptions = useState<bool>(false);
    final showSortButton = useState<bool>(true);
    final productFilterOptions = ref.watch(productsFilterOptionsProvider);

    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Tri',
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close_rounded,
              color: RSTColors.primaryColor,
              size: 30.0,
            ),
          ),
        ],
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(20.0),

        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 280.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: productFilterOptions.containsKey('orderBy')
                      ? productFilterOptions['orderBy']
                          .map(
                            (sortOption) => SortOptionTool(
                              sortOption: sortOption,
                              filterOptionsProvider:
                                  productsFilterOptionsProvider,
                            ),
                          )
                          .toList()
                      : [],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(
                top: 15.0,
                bottom: 10.0,
              ),
              child: InkWell(
                onTap: () {
                  // show or hide sort options
                  showSortOptions.value = !showSortOptions.value;
                },
                splashColor: RSTColors.primaryColor.withOpacity(.15),
                hoverColor: RSTColors.primaryColor.withOpacity(.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const RSTText(
                        text: 'Ajouter une colonne',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Icon(
                        !showSortOptions.value
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: RSTColors.primaryColor,
                        size: 35.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            showSortOptions.value
                ? ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 200.0),
                    child: Wrap(
                      children: productFilterOptions.containsKey('orderBy')
                          ? ProductStructure.fields
                              .where(
                                // show only field which have not been sorted
                                // get first  due to {..., 'nulls':'last'}
                                (field) => productFilterOptions['orderBy'].any(
                                  (sortOption) =>
                                      sortOption.entries.first.key !=
                                      field.back,
                                ),
                              )
                              .map(
                                (field) => SortOption(
                                  field: field,
                                  filterOptionsProvider:
                                      productsFilterOptionsProvider,
                                ),
                              )
                              .toList()
                          : ProductStructure.fields
                              .map(
                                (field) => SortOption(
                                  field: field,
                                  filterOptionsProvider:
                                      productsFilterOptionsProvider,
                                ),
                              )
                              .toList(),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 170.0,
              child: RSTElevatedButton(
                text: 'Annuler',
                backgroundColor: RSTColors.sidebarTextColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            showSortButton.value
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Trier',
                      onPressed: () async {},
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
