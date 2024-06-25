import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/modules/definitions/types/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/types/views/widgets/forms/addition/type_addition.widget.dart';

class TypesPageHeader extends StatefulHookConsumerWidget {
  const TypesPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TypesPageHeaderState();
}

class _TypesPageHeaderState extends ConsumerState<TypesPageHeader> {
  @override
  Widget build(BuildContext context) {
    final typesListParameters = ref.watch(typesListParametersProvider);
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
                  // refresh providers counts and the types list
                  ref.invalidate(typesListStreamProvider);
                  ref.invalidate(typesCountProvider);
                  ref.invalidate(specificTypesCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: !typesListParameters.containsKey('where')
                    ? 'Filtrer'
                    : 'Filtré',
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(typesListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (typesListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in typesListParameters['where'].entries.first.value) {
                      debugPrint('saved fiter : $filterParameter \n');

                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch;

                      // add it to added filter parameters
                      ref
                          .read(
                        typesListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const TypeFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !typesListParameters.containsKey('orderBy')
                    ? 'Trier'
                    : 'Trié',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const TypeSortDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.print_outlined,
                text: 'Imprimer',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const TypePdfGenerationDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.view_module_outlined,
                text: 'Exporter',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const TypeExcelFileGenerationDialog(),
                  );
                },
              ),
              RSTAddButton(
                onTap: () {
                  ref
                      .read(typeProductsInputsAddedVisibilityProvider.notifier)
                      .state = {};
                  //  ref.read(typeSelectedProductsProvider.notifier).state = {};
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const TypeAdditionForm(),
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
