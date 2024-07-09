import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';
import 'package:rst/modules/definitions/cards/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class CardsPageHeader extends StatefulHookConsumerWidget {
  const CardsPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardsPageHeaderState();
}

class _CardsPageHeaderState extends ConsumerState<CardsPageHeader> {
  @override
  Widget build(BuildContext context) {
    final cardsListParameters = ref.watch(cardsListParametersProvider);
    final authPermissions = ref.watch(authPermissionsProvider);
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
                  // refresh providers counts and the cards list
                  ref.invalidate(cardsListStreamProvider);
                  ref.invalidate(cardsCountProvider);
                  ref.invalidate(specificCardsCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: cardsListParameters.containsKey('where') &&
                        ((cardsListParameters['where'].containsKey('AND') &&
                                cardsListParameters['where']['AND']
                                    .isNotEmpty) ||
                            (cardsListParameters['where'].containsKey('OR') &&
                                cardsListParameters['where']['OR']
                                    .isNotEmpty) ||
                            (cardsListParameters['where'].containsKey('NOR') &&
                                cardsListParameters['where']['NOR'].isNotEmpty))
                    ? 'Filtré'
                    : 'Filtrer',
                light: cardsListParameters.containsKey('where') &&
                    ((cardsListParameters['where'].containsKey('AND') &&
                            cardsListParameters['where']['AND'].isNotEmpty) ||
                        (cardsListParameters['where'].containsKey('OR') &&
                            cardsListParameters['where']['OR'].isNotEmpty) ||
                        (cardsListParameters['where'].containsKey('NOR') &&
                            cardsListParameters['where']['NOR'].isNotEmpty)),
                onTap: () async {
                  final random = Random();
                  // reset added filter paramters provider
                  ref.invalidate(cardsListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (cardsListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in cardsListParameters['where'].entries.first.value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch +
                              random.nextInt(100000);

                      // add it to added filter parameters
                      ref
                          .read(
                        cardsListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const CardFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !cardsListParameters.containsKey('orderBy') ||
                        !cardsListParameters['orderBy'].isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: cardsListParameters.containsKey('orderBy') &&
                    cardsListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CardSortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printCardsList]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CardPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportCardsList]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CardExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              /* RSTAddButton(
                onTap: () {
                  /* FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CardAdditionForm(),
                  );*/
                },
              ),*/
            ],
          ),
        ],
      ),
    );
  }
}
