import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/collector/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/product/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/common/widgets/selection_tools/type/providers/selection.provider.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/modules/statistics/products_forecasts/models/filter_parameter/filter_parameter.model.dart';
import 'package:rst/modules/statistics/products_forecasts/providers/products_forecasts.provider.dart';

class ProductsForecastsPageHeader extends StatefulHookConsumerWidget {
  const ProductsForecastsPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsForecastsPageHeaderState();
}

class _ProductsForecastsPageHeaderState
    extends ConsumerState<ProductsForecastsPageHeader> {
  @override
  Widget build(BuildContext context) {
    final authPermissions = ref.watch(authPermissionsProvider);

    // listen to product change
    ref.listen(productSelectionToolProvider('products-forecasts'),
        (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(productsForecastsListParametersProvider.notifier)
            .update((state) {
          return ProductsForecastsFilter(
            productId: next?.id,
            customerId: state.customerId,
            collectorId: state.collectorId,
            cardId: state.cardId,
            typeId: state.typeId,
            totalSettlementNumber: state.totalSettlementNumber,
            offset: state.offset,
            limit: state.limit,
          );
        });
      });
    });

    // listen to customer change
    ref.listen(customerSelectionToolProvider('products-forecasts'),
        (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(productsForecastsListParametersProvider.notifier)
            .update((state) {
          return ProductsForecastsFilter(
            productId: state.productId,
            customerId: next?.id,
            collectorId: state.collectorId,
            cardId: state.cardId,
            typeId: state.typeId,
            totalSettlementNumber: state.totalSettlementNumber,
            offset: state.offset,
            limit: state.limit,
          );
        });
      });
    });

    // listen to card change
    ref.listen(cardSelectionToolProvider('products-forecasts'),
        (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(productsForecastsListParametersProvider.notifier)
            .update((state) {
          return ProductsForecastsFilter(
            productId: state.productId,
            customerId: state.customerId,
            collectorId: state.collectorId,
            cardId: next?.id,
            typeId: state.typeId,
            totalSettlementNumber: state.totalSettlementNumber,
            offset: state.offset,
            limit: state.limit,
          );
        });
      });
    });

    // listen to collector change
    ref.listen(collectorSelectionToolProvider('products-forecasts'),
        (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(productsForecastsListParametersProvider.notifier)
            .update((state) {
          return ProductsForecastsFilter(
            productId: state.productId,
            customerId: state.customerId,
            collectorId: next?.id,
            cardId: state.cardId,
            typeId: state.typeId,
            totalSettlementNumber: state.totalSettlementNumber,
            offset: state.offset,
            limit: state.limit,
          );
        });
      });
    });

    // listen to type change
    ref.listen(typeSelectionToolProvider('products-forecasts'),
        (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(productsForecastsListParametersProvider.notifier)
            .update((state) {
          return ProductsForecastsFilter(
            productId: state.productId,
            customerId: state.customerId,
            collectorId: state.collectorId,
            cardId: state.cardId,
            typeId: next?.id,
            totalSettlementNumber: state.totalSettlementNumber,
            offset: state.offset,
            limit: state.limit,
          );
        });
      });
    });

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
                  // refresh providers
                  ref.invalidate(productsForecastsListStreamProvider);
                  ref.invalidate(productsForecastsCountProvider);
                  ref.invalidate(specificProductsForecastsCountProvider);
                },
              ),
              const ProductSelectionToolCard(
                width: 200.0,
                toolName: 'products-forecasts',
                roundedStyle: RoundedStyle.full,
                textLimit: 15,
              ),
              const CustomerSelectionToolCard(
                width: 200.0,
                toolName: 'products-forecasts',
                roundedStyle: RoundedStyle.full,
                textLimit: 15,
              ),
              const CollectorSelectionToolCard(
                width: 200.0,
                toolName: 'products-forecasts',
                roundedStyle: RoundedStyle.full,
                textLimit: 15,
              ),
              const TypeSelectionToolCard(
                width: 150.0,
                toolName: 'products-forecasts',
                roundedStyle: RoundedStyle.full,
                textLimit: 15,
              ),
              const CardSelectionToolCard(
                width: 200.0,
                toolName: 'products-forecasts',
                roundedStyle: RoundedStyle.full,
                textLimit: 15,
              ),
              SizedBox(
                width: 150.0,
                child: TextFormField(
                  initialValue: '186',
                  style: const TextStyle(
                    fontSize: 10.0,
                  ),
                  decoration: const InputDecoration(
                    label: RSTText(
                      text: 'Règlements',
                      fontSize: 10.0,
                    ),
                    hintText: 'Nombre',
                    hintStyle: TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  onChanged: (value) {
                    ref
                        .read(productsForecastsListParametersProvider.notifier)
                        .update((state) {
                      return ProductsForecastsFilter(
                        productId: state.productId,
                        customerId: state.customerId,
                        collectorId: state.collectorId,
                        cardId: state.cardId,
                        typeId: state.typeId,
                        totalSettlementNumber: int.tryParse(value),
                        offset: state.offset,
                        limit: state.limit,
                      );
                    });
                  },
                ),
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printProductsForecasts]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        /*  FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const TypePdfGenerationDialog(),
                        );*/
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
