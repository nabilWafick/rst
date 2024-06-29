// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/definitions/cards/models/cards.model.dart';
import 'package:rst/modules/definitions/cards/models/structure/structure.model.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CardSortDialog extends HookConsumerWidget {
  const CardSortDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final showSortParameters = useState<bool>(false);
    final cardsListParameters = ref.watch(cardsListParametersProvider);

    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Tri',
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
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),

        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 280.0,
                minHeight: .0,
              ),
              child: cardsListParameters.containsKey('orderBy')
                  ? Consumer(
                      builder: (context, ref, child) {
                        List<Map<String, String>> sortConditions =
                            cardsListParameters['orderBy'];
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: sortConditions
                                .map(
                                  (sortParameter) => SortParameterTool(
                                    sortParameter: sortParameter,
                                    fields: CardStructure.fields
                                        .where(
                                          (field) => !field.isRelation,
                                        )
                                        .toList(),
                                    listParametersProvider:
                                        cardsListParametersProvider,
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(
                top: 15.0,
                bottom: 10.0,
              ),
              child: InkWell(
                onTap: () {
                  // show or hide sort Parameters
                  showSortParameters.value = !showSortParameters.value;
                },
                splashColor: RSTColors.primaryColor.withOpacity(.15),
                hoverColor: RSTColors.primaryColor.withOpacity(.1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const RSTText(
                        text: 'Ajouter une colonne',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Icon(
                        showSortParameters.value
                            ? Icons.keyboard_arrow_up_rounded
                            : Icons.keyboard_arrow_down_rounded,
                        color: RSTColors.primaryColor,
                        size: 35.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            showSortParameters.value
                ? ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200.0,
                      minHeight: .0,
                    ),
                    child: Wrap(
                      children: cardsListParameters.containsKey('orderBy')
                          ? CardStructure.fields
                              .where(
                                (field) => !field.isRelation,
                              )
                              .toList()
                              .where(
                                (field) {
                                  List<Map<String, String>> sortParameters =
                                      cardsListParameters['orderBy'];
                                  return sortParameters.every(
                                    (sortParameter) =>
                                        sortParameter.entries.first.key !=
                                        field.back,
                                  );
                                },
                              )
                              .toList()
                              .map(
                                (field) => SortParameter(
                                  field: field,
                                  listParametersProvider:
                                      cardsListParametersProvider,
                                ),
                              )
                              .toList()
                          : CardStructure.fields
                              .where(
                                (field) => !field.isRelation,
                              )
                              .toList()
                              .map(
                                (field) => SortParameter(
                                  field: field,
                                  listParametersProvider:
                                      cardsListParametersProvider,
                                ),
                              )
                              .toList(),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            cardsListParameters['orderBy']?.isNotEmpty ?? false
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Réinitialiser',
                      backgroundColor: RSTColors.primaryColor,
                      onPressed: () {
                        // remove the sort Parameter
                        ref.read(cardsListParametersProvider.notifier).update(
                          (state) {
                            Map<String, dynamic> newState = {};

                            for (MapEntry<String, dynamic> entry
                                in state.entries) {
                              if (entry.key != 'orderBy') {
                                newState[entry.key] = entry.value;
                              }
                            }
                            state = newState;

                            return state;
                          },
                        );
                      },
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              width: 20.0,
            ),
            SizedBox(
              width: 170.0,
              child: RSTElevatedButton(
                text: cardsListParameters['orderBy']?.isEmpty ?? false
                    ? 'Valider'
                    : 'Fermer',
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
