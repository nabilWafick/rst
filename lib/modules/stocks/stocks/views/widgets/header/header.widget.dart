import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/selection_tools/product/providers/selection.provider.dart';
import 'package:rst/modules/stocks/stocks/providers/stocks.provider.dart';
import 'package:rst/modules/stocks/stocks/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/stocks/stocks/views/widgets/forms/addition/output/stock_manual_output_addition.widget.dart';
import 'package:rst/modules/stocks/stocks/views/widgets/forms/forms.widget.dart';

class StocksPageHeader extends StatefulHookConsumerWidget {
  const StocksPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StocksPageHeaderState();
}

class _StocksPageHeaderState extends ConsumerState<StocksPageHeader> {
  @override
  Widget build(BuildContext context) {
    final stocksListParameters = ref.watch(stocksListParametersProvider);
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
                  // refresh providers counts and the stocks list
                  ref.invalidate(stocksListStreamProvider);
                  ref.invalidate(stocksCountProvider);
                  ref.invalidate(specificStocksCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: !stocksListParameters.containsKey('where')
                    ? 'Filtrer'
                    : 'Filtré',
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(stocksListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (stocksListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in stocksListParameters['where'].entries.first.value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch;

                      // add it to added filter parameters
                      ref
                          .read(
                        stocksListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const StockFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !stocksListParameters.containsKey('orderBy')
                    ? 'Trier'
                    : 'Trié',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const StockSortDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.print_outlined,
                text: 'Imprimer',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const StockPdfGenerationDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.view_module_outlined,
                text: 'Exporter',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const StockExcelFileGenerationDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.call_made_rounded,
                text: 'Sortie',
                onTap: () {
                  ref.invalidate(productSelectionToolProvider('stock-output'));
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const StockManualOutputAdditionForm(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.call_received,
                text: 'Entrée',
                onTap: () {
                  ref.invalidate(productSelectionToolProvider('stock-input'));
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const StockManualInputAdditionForm(),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
