// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/main.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';
import 'package:rst/modules/definitions/products/models/structure/structure.model.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class ProductFilterDialog extends StatefulHookConsumerWidget {
  const ProductFilterDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductFilterDialogState();
}

class _ProductFilterDialogState extends ConsumerState<ProductFilterDialog> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const formCardWidth = 880.0;
    // final productsListParameters = ref.watch(productsListParametersProvider);
    final productsListFilterParametersAdded =
        ref.watch(productsListFilterParametersAddedProvider);

    final logicalOperator = useState<String>('AND');
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
        child: Form(
          key: formKey,
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
                            logicalOperator.value = "AND";
                            orOperatorSelected.value = false;
                            notOperatorSelected.value = false;
                          } else if (value == false) {
                            andOperatorSelected.value = value!;
                            notOperatorSelected.value = value;
                            orOperatorSelected.value = true;
                            logicalOperator.value = "OR";
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
                            logicalOperator.value = "OR";
                            andOperatorSelected.value = false;
                            notOperatorSelected.value = false;
                          } else if (value == false) {
                            orOperatorSelected.value = value!;
                            notOperatorSelected.value = value;
                            andOperatorSelected.value = true;
                            logicalOperator.value = "AND";
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
                            logicalOperator.value = "NOT";
                            orOperatorSelected.value = false;
                            andOperatorSelected.value = false;
                          } else if (value == false) {
                            notOperatorSelected.value = value!;
                            orOperatorSelected.value = value;
                            andOperatorSelected.value = true;
                            logicalOperator.value = "AND";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 280.0,
                  minHeight: .0,
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    // will store filter parameters tools
                    List<Widget> filterParametersToolsList = [];

                    for (MapEntry filterParameter
                        in productsListFilterParametersAdded.entries) {
                      filterParametersToolsList.add(
                        FilterParameterTool(
                          index: filterParameter.key,
                          fields: ProductStructure.fields,
                          filterParametersAddedProvider:
                              productsListFilterParametersAddedProvider,
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: filterParametersToolsList,
                      ),
                    );
                  },
                ),
              ),
              /*        /// * === TEST ===
              RSTText(
                text: 'Parameters Added : $productsListFilterParametersAdded',
                fontSize: 12.0,
              ),
              const SizedBox(
                height: 5.00,
              ),
              RSTText(
                text:
                    'List Parameters : ${ref.watch(productsListParametersProvider)}',
                fontSize: 12.0,
              ),
              /// * === TEST ===
*/
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(
                  top: 15.0,
                  bottom: 10.0,
                ),
                child: InkWell(
                  onTap: () {
                    // add new filter parameter
                    ref
                        .read(
                            productsListFilterParametersAddedProvider.notifier)
                        .update(
                      (state) {
                        state = {
                          ...state,
                          DateTime.now().millisecondsSinceEpoch: {
                            ProductStructure.name.back: {
                              FilterOperators.commonOperators.first.back: "",
                            }
                          }
                        };
                        return state;
                      },
                    );
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
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            productsListFilterParametersAdded.isNotEmpty
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Réinitialiser',
                      backgroundColor: RSTColors.primaryColor,
                      onPressed: () {
                        // reset filter tools parameters provider
                        ref.invalidate(
                            productsListFilterParametersAddedProvider);

                        // remove the filter parameters
                        ref
                            .read(productsListParametersProvider.notifier)
                            .update(
                          (state) {
                            Map<String, dynamic> newState = {};

                            for (MapEntry<String, dynamic> entry
                                in state.entries) {
                              // remove where key from parameters
                              if (entry.key != 'where') {
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
                text: productsListFilterParametersAdded.isNotEmpty
                    ? 'Valider'
                    : 'Effacer',
                onPressed: productsListFilterParametersAdded.isNotEmpty
                    ? () async {
                        final isFormValid = formKey.currentState!.validate();

                        if (isFormValid) {
                          List<Map<String, dynamic>> filterParameters = [];

                          // perform filter Tool parameter
                          for (MapEntry<int,
                                  Map<String, dynamic>> filterToolParameterEntry
                              in productsListFilterParametersAdded.entries) {
                            final finalFilterToolParameter =
                                performFilterParameter(
                              ref: ref,
                              filterToolIndex: filterToolParameterEntry.key,
                              filterParameter: filterToolParameterEntry.value,
                            );

                            debugPrint(
                                'final Parameter ${filterToolParameterEntry.key}: $finalFilterToolParameter');

                            filterParameters.add(finalFilterToolParameter);
                          }

                          // add filter parameters to productsListParameter

                          ref
                              .read(productsListParametersProvider.notifier)
                              .update((state) {
                            // remove if exists, 'AND', 'OR', 'NOT' keys

                            Map<String, dynamic> newState = {};

                            for (MapEntry<String, dynamic> entry
                                in state.entries) {
                              if (entry.key != 'where') {
                                newState[entry.key] = entry.value;
                              }
                            }
                            state = newState;

                            state = {
                              ...state,
                              'where': {
                                logicalOperator.value: filterParameters,
                              }
                            };

                            return state;
                          });
                        }
                      }
                    : () {
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
