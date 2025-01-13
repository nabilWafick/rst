// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/definitions/products/controllers/products.controller.dart';
import 'package:rst/modules/statistics/products_forecasts/functions/pdf/pdf_file.function.dart';
import 'package:rst/modules/statistics/products_forecasts/models/filter_parameter/filter_parameter.model.dart';
import 'package:rst/modules/statistics/products_forecasts/providers/products_forecasts.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class ProductsForecastsPdfGenerationDialog extends HookConsumerWidget {
  const ProductsForecastsPdfGenerationDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final exportAllProductsForecasts = useState<bool>(false);
    final exportSelectionnedProductsForecasts = useState<bool>(true);
    final showPrintButton = useState<bool>(true);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Impression',
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
        margin: const EdgeInsets.symmetric(
          vertical: 25.0,
        ),
        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SwitchListTile(
              value: exportAllProductsForecasts.value,
              title: const RSTText(
                text: 'Tout',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportAllProductsForecasts.value = value;
                  exportSelectionnedProductsForecasts.value = !value;
                } else {
                  exportAllProductsForecasts.value = value;
                  exportSelectionnedProductsForecasts.value = !value;
                }
              },
            ),
            SwitchListTile(
              value: exportSelectionnedProductsForecasts.value,
              title: const RSTText(
                text: 'Groupe sélectionné',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportSelectionnedProductsForecasts.value = value;
                  exportAllProductsForecasts.value = !value;
                } else {
                  exportSelectionnedProductsForecasts.value = value;
                  exportAllProductsForecasts.value = !value;
                }
              },
            )
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
            showPrintButton.value
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Imprimer',
                      onPressed: () async {
                        // get current types filter option
                        final productsForecastsListParameters =
                            ref.read(productsForecastsListParametersProvider);

                        if (exportAllProductsForecasts.value) {
                          // get all types count
                          final productsForecatsCount =
                              await ProductsController.getProductsForecastsCountAll();

                          // generate excel file
                          await generateProductsForecastsPdf(
                            context: context,
                            ref: ref,
                            productsForecastsFilter: ProductsForecastsFilter(
                              offset: 0,
                              limit: productsForecatsCount.data.count,
                            ),
                            showPrintButton: showPrintButton,
                          );
                        } else {
                          // generate excel file
                          await generateProductsForecastsPdf(
                            context: context,
                            ref: ref,
                            productsForecastsFilter: productsForecastsListParameters,
                            showPrintButton: showPrintButton,
                          );
                        }
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
