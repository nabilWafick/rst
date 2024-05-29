import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/products/providers/product_selection.provider.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';

class ProductSelectionDialogBody extends StatefulHookConsumerWidget {
  final String toolName;
  const ProductSelectionDialogBody({
    super.key,
    required this.toolName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductSelectionDialogBodyState();
}

class _ProductSelectionDialogBodyState
    extends ConsumerState<ProductSelectionDialogBody> {
  onProductNameChangedTest({required WidgetRef ref, required String value}) {
    final parameters = ref.read(productsSelectionListParametersProvider);

    if (parameters.containsKey('where') &&
        parameters['where'].containsKey('AND')) {
      ref
          .read(productsSelectionListParametersProvider.notifier)
          .update((state) {
        List<Map<String, dynamic>> filters = state['where']['AND'];

        // remove name filter
        filters.removeWhere(
          (filter) => filter.entries.first.key == 'name',
        );

        if (value != '') {
          Map<String, dynamic> newNameFilter = {
            'name': {
              'contains': value,
              'mode': 'insensitive',
            }
          };

          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                ...filters,
                newNameFilter,
              ],
            }
          };
        } else {
          // update state
          state = {
            ...state,
            'where': {
              'AND': filters,
            }
          };
        }

        return state;
      });
    } else {
      if (value != '') {
        ref
            .read(productsSelectionListParametersProvider.notifier)
            .update((state) {
          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                {
                  'name': {
                    'contains': value,
                    'mode': 'insensitive',
                  }
                },
              ],
            }
          };

          return state;
        });
      }
    }
  }

  onProductPurchasePriceChangedTest(
      {required WidgetRef ref, required String value}) {
    final parameters = ref.read(productsSelectionListParametersProvider);

    if (parameters.containsKey('where') &&
        parameters['where'].containsKey('AND')) {
      ref
          .read(productsSelectionListParametersProvider.notifier)
          .update((state) {
        List<Map<String, dynamic>> filters = state['where']['AND'];

        // remove name filter
        filters.removeWhere(
          (filter) => filter.entries.first.key == 'purchasePrice',
        );

        if (value != '') {
          Map<String, dynamic> newPurchasePriceFilter = {
            'purchasePrice': {
              'equals': double.tryParse(value) ?? .0,
            }
          };

          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                ...filters,
                newPurchasePriceFilter,
              ],
            }
          };
        } else {
          // update state
          state = {
            ...state,
            'where': {
              'AND': filters,
            }
          };
        }

        return state;
      });
    } else {
      if (value != '') {
        ref
            .read(productsSelectionListParametersProvider.notifier)
            .update((state) {
          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                {
                  'purchasePrice': {
                    'equals': double.tryParse(value) ?? .0,
                  }
                },
              ],
            }
          };

          return state;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsList = ref.watch(productsSelectionListStreamProvider);

    return Expanded(
      child: Stack(
        children: [
          Container(
            width: 800,
            alignment: Alignment.center,
            child: productsList.when(
              data: (data) => HorizontalDataTable(
                leftHandSideColumnWidth: 100,
                rightHandSideColumnWidth: 700,
                itemCount: data.length,
                isFixedHeader: true,
                leftHandSideColBackgroundColor: Colors.transparent,
                rightHandSideColBackgroundColor: Colors.transparent,
                headerWidgets: [
                  Container(
                    width: 200.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    child: const RSTText(
                      text: 'N°',
                      textAlign: TextAlign.center,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 400.0,
                    height: 50.0,
                    /* const RSTText(
                      text: 'Nom',
                      textAlign: TextAlign.center,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),*/
                  ),
                  const SizedBox(
                    width: 300.0,
                    height: 50.0,
                    /* const RSTText(
                      text: 'Prix d\'achat',
                      textAlign: TextAlign.center,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),*/
                  ),
                ],
                leftSideItemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    width: 200.0,
                    height: 30.0,
                    child: RSTText(
                      text: '${index + 1}',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
                rightSideItemBuilder: (BuildContext context, int index) {
                  final product = data[index];
                  return InkWell(
                    onTap: () {
                      ref
                          .read(productSelectionToolProvider(widget.toolName)
                              .notifier)
                          .state = product;

                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 400.0,
                          height: 30.0,
                          child: RSTText(
                            text: FunctionsController.truncateText(
                              text: product.name,
                              maxLength: 45,
                            ),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 300.0,
                          height: 30.0,
                          child: RSTText(
                            text: '${product.purchasePrice.ceil()} f',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                rowSeparatorWidget: const Divider(),
                scrollPhysics: const BouncingScrollPhysics(),
                horizontalScrollPhysics: const BouncingScrollPhysics(),
              ),
              error: (error, stackTrace) => RSTText(
                text: 'ERREUR :) \n ${error.toString()}',
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
              loading: () => const CircularProgressIndicator(
                strokeWidth: 2.5,
              ),
            ),
          ),
          SizedBox(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 100.0,
                ),
                RSTSearchInput(
                  width: 400.0,
                  hintText: 'Nom',
                  searchProvider: productNameProvider,
                  onChanged: onProductNameChangedTest,
                ),
                RSTSearchInput(
                  width: 300.0,
                  hintText: 'Prix d\'achat',
                  searchProvider: productNameProvider,
                  onChanged: onProductPurchasePriceChangedTest,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
