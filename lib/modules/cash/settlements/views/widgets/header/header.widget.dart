import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/cash/settlements/views/widgets/dialogs/dialogs.widget.dart';

class SettlementsPageHeader extends StatefulHookConsumerWidget {
  const SettlementsPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettlementsPageHeaderState();
}

class _SettlementsPageHeaderState extends ConsumerState<SettlementsPageHeader> {
  @override
  Widget build(BuildContext context) {
    final settlementsListParameters =
        ref.watch(settlementsListParametersProvider);
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
                  // refresh providers counts and the settlements list
                  ref.invalidate(settlementsListStreamProvider);
                  ref.invalidate(settlementsCountProvider);
                  ref.invalidate(specificSettlementsCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: !settlementsListParameters.containsKey('where')
                    ? 'Filtrer'
                    : 'Filtré',
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(settlementsListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (settlementsListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in settlementsListParameters['where']
                            .entries
                            .first
                            .value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch;

                      // add it to added filter parameters
                      ref
                          .read(
                        settlementsListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const SettlementFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !settlementsListParameters.containsKey('orderBy')
                    ? 'Trier'
                    : 'Trié',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const SettlementSortDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.print_outlined,
                text: 'Imprimer',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const SettlementPdfGenerationDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.view_module_outlined,
                text: 'Exporter',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const SettlementExcelFileGenerationDialog(),
                  );
                },
              ),
              const SizedBox(
                width: 1.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
