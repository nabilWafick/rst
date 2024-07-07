import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/field/field.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/functions/on_changed/on_changed.function.dart';
import 'package:rst/common/widgets/selection_tools/search_input/search_input.widget.dart';
import 'package:rst/modules/definitions/cards/models/structure/structure.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CardSelectionDialogBody extends StatefulHookConsumerWidget {
  final String toolName;
  const CardSelectionDialogBody({
    super.key,
    required this.toolName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardSelectionDialogBodyState();
}

class _CardSelectionDialogBodyState
    extends ConsumerState<CardSelectionDialogBody> {
  static void typeNameInput({
    required WidgetRef ref,
    required Field field,
    required String value,
    required StateProvider<Map<String, dynamic>>
        selectionListParametersProvider,
  }) {
    final parameters = ref.read(selectionListParametersProvider);

    if (parameters.containsKey('where') &&
        parameters['where'].containsKey('AND')) {
      ref.read(selectionListParametersProvider.notifier).update((state) {
        List<Map<String, dynamic>> filters = state['where']['AND'];

        // remove field filter
        filters.removeWhere(
          (filter) => filter.entries.first.key == field.back,
        );

        if (value != '') {
          Map<String, dynamic> newFieldFilter = {
            'type': {
              'name': {
                'contains': value,
                'mode': 'insensitive',
              },
            }
          };

          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                ...filters,
                newFieldFilter,
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
        ref.read(selectionListParametersProvider.notifier).update((state) {
          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                {
                  'type': {
                    'name': {
                      'contains': value,
                      'mode': 'insensitive',
                    },
                  },
                },
              ],
            }
          };

          return state;
        });
      }
    }
  }

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final cardsList =
        ref.watch(cardsSelectionListStreamProvider(widget.toolName));

    return Expanded(
      child: Stack(
        children: [
          Container(
            width: 2400,
            alignment: Alignment.center,
            child: cardsList.when(
              data: (data) => HorizontalDataTable(
                leftHandSideColumnWidth: 100,
                rightHandSideColumnWidth: 1000,
                itemCount: data.length,
                isFixedHeader: true,
                leftHandSideColBackgroundColor: material.Colors.transparent,
                rightHandSideColBackgroundColor: material.Colors.transparent,
                horizontalScrollbarStyle: ScrollbarStyle(
                  thickness: 20.0,
                  thumbColor: RSTColors.sidebarTextColor.withOpacity(.2),
                ),
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
                  ),
                  const SizedBox(
                    width: 400.0,
                    height: 50.0,
                  ),
                  const SizedBox(
                    width: 200.0,
                    height: 50.0,
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
                  final card = data[index];
                  return material.InkWell(
                    onTap: () {
                      ref
                          .read(cardSelectionToolProvider(widget.toolName)
                              .notifier)
                          .state = card;

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
                              text: card.label,
                              maxLength: 30,
                            ),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 400.0,
                          height: 30.0,
                          child: RSTText(
                            text: FunctionsController.truncateText(
                              text: card.type.name,
                              maxLength: 30,
                            ),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 200.0,
                          height: 30.0,
                          child: RSTText(
                            text: FunctionsController.truncateText(
                              text: card.typesNumber.toString(),
                              maxLength: 30,
                            ),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                rowSeparatorWidget: const material.Divider(),
                scrollPhysics: const BouncingScrollPhysics(),
                horizontalScrollPhysics: const BouncingScrollPhysics(),
              ),
              error: (error, stackTrace) => RSTText(
                text: 'ERREUR :) \n ${error.toString()}',
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
              loading: () => const material.CircularProgressIndicator(
                strokeWidth: 2.5,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 100.0),
            height: 50,
            child: material.Scrollbar(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RSTSelectionSearchInput(
                      width: 400.0,
                      hintText: 'Libellé',
                      field: CardStructure.label,
                      selectionListParametersProvider:
                          cardsSelectionListParametersProvider(widget.toolName),
                      onChanged: SelectionToolSearchInputOnChanged.stringInput,
                    ),
                    RSTSelectionSearchInput(
                      width: 400.0,
                      hintText: 'Type',
                      field: CardStructure.type,
                      selectionListParametersProvider:
                          cardsSelectionListParametersProvider(widget.toolName),
                      onChanged: typeNameInput,
                    ),
                    RSTSelectionSearchInput(
                      width: 200.0,
                      hintText: 'Nombre Type',
                      field: CardStructure.typesNumber,
                      selectionListParametersProvider:
                          cardsSelectionListParametersProvider(widget.toolName),
                      onChanged: SelectionToolSearchInputOnChanged.intInput,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
