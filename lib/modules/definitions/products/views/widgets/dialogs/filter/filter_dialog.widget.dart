// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';
import 'package:rst/modules/definitions/products/models/structure/structure.model.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class ProductFilterDialog extends HookConsumerWidget {
  const ProductFilterDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 880.0;
    final productsListParameters = ref.watch(productsListParametersProvider);
    final logicalOperator = useState<String>('ET');
    final andOperatorSelected = useState<bool>(true);
    final orOperatorSelected = useState<bool>(false);
    final notOperatorSelected = useState<bool>(false);

    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Filtre',
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
            Container(
              margin: const EdgeInsets.only(
                bottom: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: formCardWidth / 3.5,
                    child: CheckboxListTile(
                      value: andOperatorSelected.value,
                      hoverColor: RSTColors.primaryColor.withOpacity(.1),
                      title: const RSTText(
                        text: 'ET',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        if (value == true) {
                          andOperatorSelected.value = true;
                          logicalOperator.value = "ET";
                          orOperatorSelected.value = false;
                          notOperatorSelected.value = false;
                        } else if (value == false) {
                          andOperatorSelected.value = value!;
                          notOperatorSelected.value = value;
                          orOperatorSelected.value = true;
                          logicalOperator.value = "OU";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: formCardWidth / 3.5,
                    child: CheckboxListTile(
                      value: orOperatorSelected.value,
                      hoverColor: RSTColors.primaryColor.withOpacity(.1),
                      title: const RSTText(
                        text: 'OU',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        if (value == true) {
                          orOperatorSelected.value = value!;
                          logicalOperator.value = "OU";
                          andOperatorSelected.value = false;
                          notOperatorSelected.value = false;
                        } else if (value == false) {
                          orOperatorSelected.value = value!;
                          notOperatorSelected.value = value;
                          andOperatorSelected.value = true;
                          logicalOperator.value = "ET";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: formCardWidth / 3.5,
                    child: CheckboxListTile(
                      value: notOperatorSelected.value,
                      hoverColor: RSTColors.primaryColor.withOpacity(.15),
                      title: const RSTText(
                        text: 'NON',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: (value) {
                        if (value == true) {
                          notOperatorSelected.value = value!;
                          logicalOperator.value = "NON";
                          orOperatorSelected.value = false;
                          andOperatorSelected.value = false;
                        } else if (value == false) {
                          notOperatorSelected.value = value!;
                          orOperatorSelected.value = value;
                          andOperatorSelected.value = true;
                          logicalOperator.value = "ET";
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            /* FilterParameterTool(
              index: 1,
              logicalOperator: logicalOperator.value,
              fields: ProductStructure.fields,
              listParametersProvider: productsListParametersProvider,
            ),
            FilterParameterTool(
              index: 2,
              logicalOperator: logicalOperator.value,
              fields: ProductStructure.fields,
              listParametersProvider: productsListParametersProvider,
            ),*/
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 280.0,
                minHeight: .0,
              ),
              child: productsListParameters.containsKey('where')
                  ? Consumer(
                      builder: (context, ref, child) {
                        // will store filter parameters tools
                        List<Widget> filterParametersToolsList = [];

                        // get all added parameters
                        final productsListFilterParametersAdded = ref.watch(
                          productsListFilterParametersAddedProvider,
                        );

                        for (MapEntry filterParameter
                            in productsListFilterParametersAdded.entries) {
                          filterParametersToolsList.add(
                            FilterParameterTool(
                              index: filterParameter.key,
                              fields: ProductStructure.fields,
                              filterParametersAddedProvider:
                                  productsListFilterParametersAddedProvider,
                              filterParametersToolsAddedProvider:
                                  productsListFilterParametersToolsAddedProvider,
                            ),
                          );
                        }

                        // store the filters tools in a widget list
                        List<Widget> filterParametersTools = [];

                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: filterParametersTools,
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
                  // check if there is at least one filter parameter
                  // add a new filter parameter

                  final productsListFilterParametersToolsAdded =
                      ref.watch(productsListFilterParametersToolsAddedProvider);

                  if (productsListFilterParametersToolsAdded
                      .entries.isNotEmpty) {
                    // add new filter tool visibility
                    ref
                        .read(productsListFilterParametersToolsAddedProvider
                            .notifier)
                        .update(
                      (state) {
                        state = {
                          ...state,
                          productsListFilterParametersToolsAdded.entries.length:
                              true,
                        };

                        return state;
                      },
                    );

                    // add new filter parameter
                    ref
                        .read(
                            productsListFilterParametersAddedProvider.notifier)
                        .update(
                      (state) {
                        state = {
                          ...state,
                          productsListFilterParametersToolsAdded.length: {
                            ProductStructure.name.back: {
                              "contains": "",
                              "insensitive": true,
                            }
                          }
                        };
                        return state;
                      },
                    );
                  } else {
                    // there is any filter parameter before
                    // add first filter tool visibility
                    ref
                        .read(productsListFilterParametersToolsAddedProvider
                            .notifier)
                        .update(
                      (state) {
                        state = {
                          0: true,
                        };
                        return state;
                      },
                    );

                    // add new filter parameter
                    ref
                        .read(
                            productsListFilterParametersAddedProvider.notifier)
                        .update(
                      (state) {
                        state = {
                          0: {
                            ProductStructure.name.back: {
                              "contains": "",
                              "insensitive": true,
                            }
                          }
                        };
                        return state;
                      },
                    );
                  }
                },
                splashColor: RSTColors.primaryColor.withOpacity(.15),
                hoverColor: RSTColors.primaryColor.withOpacity(.1),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RSTText(
                        text: 'Ajouter un filtre',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Icon(
                        Icons.add_circle_outline_rounded,
                        color: RSTColors.primaryColor,
                        size: 25.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            productsListParameters['where']?.isNotEmpty ?? false
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Réinitialiser',
                      backgroundColor: RSTColors.primaryColor,
                      onPressed: () {
                        // remove the sort option
                        ref
                            .read(productsListParametersProvider.notifier)
                            .update(
                          (state) {
                            Map<String, dynamic> newState = {};

                            for (MapEntry<String, dynamic> entry
                                in state.entries) {
                              if (entry.key != 'where ') {
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
                text: 'Valider',
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
