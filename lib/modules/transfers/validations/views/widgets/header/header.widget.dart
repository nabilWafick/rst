import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/transfers/validations/providers/validations.provider.dart';
import 'package:rst/modules/transfers/validations/views/widgets/dialogs/dialogs.widget.dart';

class TransfersValidationPageHeader extends StatefulHookConsumerWidget {
  const TransfersValidationPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransfersValidationPageHeaderState();
}

class _TransfersValidationPageHeaderState
    extends ConsumerState<TransfersValidationPageHeader> {
  @override
  Widget build(BuildContext context) {
    final transfersListParameters = ref.watch(transfersListParametersProvider);
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
                  // refresh providers counts and the transfers list
                  ref.invalidate(transfersListStreamProvider);
                  ref.invalidate(transfersCountProvider);
                  ref.invalidate(specificTransfersCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: !transfersListParameters.containsKey('where')
                    ? 'Filtrer'
                    : 'Filtré',
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(transfersListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (transfersListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in transfersListParameters['where']
                            .entries
                            .first
                            .value) {
                      debugPrint('saved fiter : $filterParameter \n');

                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch;

                      // add it to added filter parameters
                      ref
                          .read(
                        transfersListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const TransferFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !transfersListParameters.containsKey('orderBy')
                    ? 'Trier'
                    : 'Trié',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const TransferSortDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.print_outlined,
                text: 'Imprimer',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const TransferPdfGenerationDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.view_module_outlined,
                text: 'Exporter',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const TransferExcelFileGenerationDialog(),
                  );
                },
              ),
              const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
