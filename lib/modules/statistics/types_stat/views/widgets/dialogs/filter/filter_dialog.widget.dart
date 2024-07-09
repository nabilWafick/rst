// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/filter_parameter_tool/logical_operator/logical_operator.widget.dart';
import 'package:rst/modules/definitions/types/models/types.model.dart';
import 'package:rst/modules/definitions/types/models/structure/structure.model.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/modules/statistics/types_stat/providers/types_stat.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class TypeFilterDialog extends StatefulHookConsumerWidget {
  const TypeFilterDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TypeFilterDialogState();
}

class _TypeFilterDialogState extends ConsumerState<TypeFilterDialog> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const formCardWidth = 880.0;
    // final typesListParameters = ref.watch(typesListParametersProvider);
    final typesStatsListFilterParametersAdded =
        ref.watch(typesStatsListFilterParametersAddedProvider);

    final typesStatsListParameters =
        ref.watch(typesStatsListParametersProvider);

    final paramOperator = typesStatsListParameters.containsKey('where')
        ? typesStatsListParameters['where'].containsKey('AND')
            ? 'AND'
            : typesStatsListParameters['where'].containsKey('OR')
                ? 'OR'
                : typesStatsListParameters['where'].containsKey('NOR')
                    ? 'NOR'
                    : 'AND'
        : 'AND';

    final logicalOperator = useState<String>(paramOperator);

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
              FilterParametersLogicalOperator(
                logicalOperator: logicalOperator,
                formCardWidth: formCardWidth,
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 300.0,
                  minHeight: .0,
                ),
                child: Consumer(
                  builder: (context, ref, child) {
                    // will store filter parameters tools
                    List<Widget> filterParametersToolsList = [];

                    for (MapEntry filterParameter
                        in typesStatsListFilterParametersAdded.entries) {
                      filterParametersToolsList.add(
                        FilterParameterTool(
                          index: filterParameter.key,
                          fields: TypeStructure.fields
                              .where(
                                (field) => field.back != 'id',
                              )
                              .toList(),
                          filterParametersAddedProvider:
                              typesStatsListFilterParametersAddedProvider,
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

              /// * === TEST ===
              RSTText(
                text: 'Parameters Added : $typesStatsListFilterParametersAdded',
                fontSize: 12.0,
              ),
              const SizedBox(
                height: 5.00,
              ),
              RSTText(
                text:
                    'List Parameters : ${ref.watch(typesListParametersProvider)}',
                fontSize: 12.0,
              ),

              /// * === TEST ===

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
                        .read(typesStatsListFilterParametersAddedProvider
                            .notifier)
                        .update(
                      (state) {
                        state = {
                          ...state,
                          DateTime.now().millisecondsSinceEpoch: {
                            TypeStructure.name.back: {
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
            typesStatsListFilterParametersAdded.isNotEmpty
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Réinitialiser',
                      backgroundColor: RSTColors.primaryColor,
                      onPressed: () {
                        // reset filter tools parameters provider
                        ref.invalidate(
                            typesStatsListFilterParametersAddedProvider);

                        // remove the filter parameters
                        ref.read(typesListParametersProvider.notifier).update(
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
                text: typesStatsListFilterParametersAdded.isNotEmpty
                    ? 'Valider'
                    : 'Fermer',
                onPressed: typesStatsListFilterParametersAdded.isNotEmpty
                    ? () async {
                        // save in update case
                        formKey.currentState!.save();

                        final isFormValid = formKey.currentState!.validate();

                        if (isFormValid) {
                          List<Map<String, dynamic>> filterParameters = [];

                          // perform filter Tool parameter
                          for (MapEntry<int,
                                  Map<String, dynamic>> filterToolParameterEntry
                              in typesStatsListFilterParametersAdded.entries) {
                            final finalFilterToolParameter =
                                performFilterParameter(
                              ref: ref,
                              filterToolIndex: filterToolParameterEntry.key,
                              filterParameter: filterToolParameterEntry.value,
                            );

                            /// * === TEST === * /
                            /// update added filter
                            ref
                                .read(
                                    typesStatsListFilterParametersAddedProvider
                                        .notifier)
                                .update((state) {
                              state = {
                                ...state,
                                filterToolParameterEntry.key:
                                    finalFilterToolParameter,
                              };
                              return state;
                            });

                            if (finalFilterToolParameter.isNotEmpty) {
                              filterParameters.add(finalFilterToolParameter);
                            }
                          }

                          // add filter parameters to typesListParameter

                          ref
                              .read(typesListParametersProvider.notifier)
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

                            // debugPrint('filter Parameter: $state');

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
