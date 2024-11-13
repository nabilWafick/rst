import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
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
import 'package:rst/modules/statistics/products_improvidence/models/filter_parameter/filter_parameter.model.dart';
import 'package:rst/modules/statistics/products_improvidence/providers/products_improvidence.provider.dart';
import 'package:rst/modules/statistics/products_improvidence/views/widgets/dialogs/excel/excel_dialog.widget.dart';
import 'package:rst/modules/statistics/products_improvidence/views/widgets/dialogs/pdf/pdf_dialog.widget.dart';

class ProductsImprovidencePageHeader extends StatefulHookConsumerWidget {
  const ProductsImprovidencePageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProductsImprovidencePageHeaderState();
}

class _ProductsImprovidencePageHeaderState extends ConsumerState<ProductsImprovidencePageHeader> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final authPermissions = ref.watch(authPermissionsProvider);

    final toolsSpacing = MediaQuery.of(context).size.width * 0.01;

    // listen to product change
    ref.listen(productSelectionToolProvider('products-Improvidence'), (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(productsImprovidenceListParametersProvider.notifier).update((state) {
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
    ref.listen(customerSelectionToolProvider('products-Improvidence'), (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(productsImprovidenceListParametersProvider.notifier).update((state) {
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
    ref.listen(cardSelectionToolProvider('products-Improvidence'), (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(productsImprovidenceListParametersProvider.notifier).update((state) {
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
    ref.listen(collectorSelectionToolProvider('products-Improvidence'), (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(productsImprovidenceListParametersProvider.notifier).update((state) {
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
    ref.listen(typeSelectionToolProvider('products-Improvidence'), (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(productsImprovidenceListParametersProvider.notifier).update((state) {
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

    return Scrollbar(
      controller: scrollController,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20.0,
        ),
        width: double.maxFinite,
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RSTIconButton(
                icon: Icons.refresh_outlined,
                text: 'Rafraichir',
                onTap: () {
                  // refresh providers
                  ref.invalidate(productsImprovidenceListStreamProvider);
                  ref.invalidate(productsImprovidenceCountProvider);
                  ref.invalidate(specificProductsImprovidenceCountProvider);
                  ref.invalidate(productsImprovidenceTotalAmountProvider);
                  ref.invalidate(specificProductsImprovidenceAmountProvider);
                },
              ),
              SizedBox(
                width: toolsSpacing,
              ),
              const ProductSelectionToolCard(
                width: 200.0,
                toolName: 'products-Improvidence',
                roundedStyle: RoundedStyle.full,
                textLimit: 15,
              ),
              SizedBox(
                width: toolsSpacing,
              ),
              const CustomerSelectionToolCard(
                width: 200.0,
                toolName: 'products-Improvidence',
                roundedStyle: RoundedStyle.full,
                textLimit: 15,
              ),
              SizedBox(
                width: toolsSpacing,
              ),
              const CollectorSelectionToolCard(
                width: 200.0,
                toolName: 'products-Improvidence',
                roundedStyle: RoundedStyle.full,
                textLimit: 15,
              ),
              SizedBox(
                width: toolsSpacing,
              ),
              const TypeSelectionToolCard(
                width: 150.0,
                toolName: 'products-Improvidence',
                roundedStyle: RoundedStyle.full,
                textLimit: 15,
              ),
              SizedBox(
                width: toolsSpacing,
              ),
              const CardSelectionToolCard(
                width: 200.0,
                toolName: 'products-Improvidence',
                roundedStyle: RoundedStyle.full,
                textLimit: 15,
              ),
              SizedBox(
                width: toolsSpacing,
              ),
              SizedBox(
                width: 150.0,
                child: TextFormField(
                  initialValue: '30',
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
                    ref.read(productsImprovidenceListParametersProvider.notifier).update((state) {
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
              SizedBox(
                width: toolsSpacing,
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printProductsForecasts]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const ProductsImprovidencePdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              SizedBox(
                width: toolsSpacing,
              ),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printProductsForecasts]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const ProductsImprovidenceExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
