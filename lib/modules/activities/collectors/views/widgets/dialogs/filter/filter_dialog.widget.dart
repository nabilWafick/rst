// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/filter_parameter_tool/logical_operator/logical_operator.widget.dart';
import 'package:rst/modules/activities/collectors/providers/collectors_activities.provider.dart';
import 'package:rst/modules/cash/settlements/models/settlements.model.dart';
import 'package:rst/modules/cash/settlements/models/structure/structure.model.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/utils/constants/api/api.constant.dart';

class CollectorsActivitiesFilterDialog extends StatefulHookConsumerWidget {
  const CollectorsActivitiesFilterDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CollectorsActivitiesFilterDialogState();
}

class _CollectorsActivitiesFilterDialogState
    extends ConsumerState<CollectorsActivitiesFilterDialog> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    const formCardWidth = 950.0;
    // final collectorsActivitiesListParameters = ref.watch(collectorsActivitiesListParametersProvider);
    final collectorsActivitiesListFilterParametersAdded =
        ref.watch(collectorsActivitiesListFilterParametersAddedProvider);

    final collectorsActivitiesListParameters =
        ref.watch(collectorsActivitiesListParametersProvider);

    final paramOperator = collectorsActivitiesListParameters.containsKey('where')
        ? collectorsActivitiesListParameters['where'].containsKey('AND')
            ? 'AND'
            : collectorsActivitiesListParameters['where'].containsKey('OR')
                ? 'OR'
                : collectorsActivitiesListParameters['where'].containsKey('NOR')
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
                        in collectorsActivitiesListFilterParametersAdded.entries) {
                      // ensure add only fields as parameter
                      // why
                      // add by default in where filter 'collectionId'
                      // which is not in settlements field

                      filterParametersToolsList.add(
                        FilterParameterTool(
                          index: filterParameter.key,
                          fields: SettlementStructure.fields
                              .where(
                                (field) => field.back != 'id',
                              )
                              .toList(),
                          filterParametersAddedProvider:
                              collectorsActivitiesListFilterParametersAddedProvider,
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
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(
                  top: 15.0,
                  bottom: 10.0,
                ),
                child: InkWell(
                  onTap: () {
                    // add new filter parameter
                    ref.read(collectorsActivitiesListFilterParametersAddedProvider.notifier).update(
                      (state) {
                        state = {
                          ...state,
                          DateTime.now().millisecondsSinceEpoch: {
                            SettlementStructure.number.back: {
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
            collectorsActivitiesListFilterParametersAdded.isNotEmpty
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Réinitialiser',
                      backgroundColor: RSTColors.primaryColor,
                      onPressed: () {
                        // reset filter tools parameters provider
                        ref.invalidate(collectorsActivitiesListFilterParametersAddedProvider);

                        // remove the filter parameters
                        ref.read(collectorsActivitiesListParametersProvider.notifier).update(
                          (state) {
                            Map<String, dynamic> newState = {};

                            for (MapEntry<String, dynamic> entry in state.entries) {
                              // remove where key from parameters
                              if (entry.key != 'where') {
                                newState[entry.key] = entry.value;
                              }
                            }

                            state = {
                              ...newState,
                              'where': {
                                'collectionId': {
                                  'not': RSTApiConstants.nullValue,
                                },
                                'isValidated': {
                                  'equals': true,
                                },
                              }
                            };

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
                text:
                    collectorsActivitiesListFilterParametersAdded.isNotEmpty ? 'Valider' : 'Fermer',
                onPressed: collectorsActivitiesListFilterParametersAdded.isNotEmpty
                    ? () async {
                        // save in update case
                        formKey.currentState!.save();

                        final isFormValid = formKey.currentState!.validate();

                        if (isFormValid) {
                          List<Map<String, dynamic>> filterParameters = [];

                          // perform filter Tool parameter
                          for (MapEntry<int, Map<String, dynamic>> filterToolParameterEntry
                              in collectorsActivitiesListFilterParametersAdded.entries) {
                            final finalFilterToolParameter = performFilterParameter(
                              ref: ref,
                              filterToolIndex: filterToolParameterEntry.key,
                              filterParameter: filterToolParameterEntry.value,
                            );

                            /// * === TEST === * /
                            /// update added filter
                            ref
                                .read(
                                    collectorsActivitiesListFilterParametersAddedProvider.notifier)
                                .update((state) {
                              state = {
                                ...state,
                                filterToolParameterEntry.key: finalFilterToolParameter,
                              };
                              return state;
                            });

                            if (finalFilterToolParameter.isNotEmpty) {
                              filterParameters.add(finalFilterToolParameter);
                            }
                          }

                          // add filter parameters to collectorsActivitiesListParameter

                          ref
                              .read(collectorsActivitiesListParametersProvider.notifier)
                              .update((state) {
                            // remove if exists, 'AND', 'OR', 'NOT' keys

                            Map<String, dynamic> newState = {};

                            for (MapEntry<String, dynamic> entry in state.entries) {
                              if (entry.key != 'where') {
                                newState[entry.key] = entry.value;
                              }
                            }
                            state = newState;
                            // all settlements fetch should be a created settlement
                            state = {
                              ...state,
                              'where': {
                                'collectionId': {
                                  'not': RSTApiConstants.nullValue,
                                },
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
