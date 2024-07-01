import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/modules/dashboard/providers/dashboard.provider.dart';
import 'package:rst/modules/dashboard/views/widgets/dashboard.widget.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardCollectorsCollectionsListParameters =
        ref.watch(dashboardCollectorsCollectionsListParametersProvider);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const DashboardOverview(),
          Container(
            margin: const EdgeInsets.only(
              top: 50.0,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100.0,
                        child: TextFormField(
                          initialValue: '0',
                          style: const TextStyle(
                            fontSize: 10.0,
                          ),
                          decoration: const InputDecoration(
                            label: RSTText(
                              text: 'Saut',
                              fontSize: 10.0,
                            ),
                            hintText: 'Saut',
                            hintStyle: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                          onChanged: (value) {
                            ref
                                .read(
                                    dashboardCollectorsCollectionsListParametersProvider
                                        .notifier)
                                .update(
                              (state) {
                                state = {
                                  ...state,
                                  'skip': int.tryParse(value) ?? 0,
                                };
                                return state;
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 100.0,
                        child: TextFormField(
                          initialValue: '10',
                          style: const TextStyle(
                            fontSize: 10.0,
                          ),
                          decoration: const InputDecoration(
                            label: RSTText(
                              text: 'Prise',
                              fontSize: 10.0,
                            ),
                            hintText: 'Prise',
                            hintStyle: TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                          onChanged: (value) {
                            ref
                                .read(
                                    dashboardCollectorsCollectionsListParametersProvider
                                        .notifier)
                                .update(
                              (state) {
                                state = {
                                  ...state,
                                  'take': int.tryParse(value) ?? 10,
                                };
                                return state;
                              },
                            );
                          },
                        ),
                      ),
                      RSTIconButton(
                        icon: Icons.filter_alt_rounded,
                        text: dashboardCollectorsCollectionsListParameters
                                    .containsKey('where') &&
                                dashboardCollectorsCollectionsListParameters[
                                        'where']
                                    .containsKey('AND') &&
                                dashboardCollectorsCollectionsListParameters[
                                        'where']['AND']
                                    .isNotEmpty
                            ? 'Filtré'
                            : 'Filtrer',
                        light: dashboardCollectorsCollectionsListParameters
                                .containsKey('where') &&
                            dashboardCollectorsCollectionsListParameters[
                                    'where']
                                .containsKey('AND') &&
                            dashboardCollectorsCollectionsListParameters[
                                    'where']['AND']
                                .isNotEmpty,
                        onTap: () async {
                          final random = Random();

                          // reset added filter paramters provider
                          ref.invalidate(
                              dashboardCollectorsCollectionsListFilterParametersAddedProvider);

                          // updated added filter parameters with list parameters

                          if (dashboardCollectorsCollectionsListParameters
                              .containsKey('where')) {
                            for (Map<String, dynamic> filterParameter
                                in dashboardCollectorsCollectionsListParameters[
                                        'where']
                                    .entries
                                    .first
                                    .value) {
                              // create a filterToolIndex
                              final filterToolIndex =
                                  DateTime.now().millisecondsSinceEpoch +
                                      random.nextInt(100000);

                              // add it to added filter parameters
                              ref
                                  .read(
                                dashboardCollectorsCollectionsListFilterParametersAddedProvider
                                    .notifier,
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
                            alertDialog:
                                const DashboardCollectorsCollectionsFilterDialog(),
                          );
                        },
                      ),
                      RSTIconButton(
                        icon: Icons.format_list_bulleted_sharp,
                        text: !dashboardCollectorsCollectionsListParameters
                                    .containsKey('orderBy') ||
                                !dashboardCollectorsCollectionsListParameters[
                                        'orderBy']
                                    .isNotEmpty
                            ? 'Trier'
                            : 'Trié',
                        light: dashboardCollectorsCollectionsListParameters
                                .containsKey('orderBy') &&
                            dashboardCollectorsCollectionsListParameters[
                                    'orderBy']
                                .isNotEmpty,
                        onTap: () {
                          FunctionsController.showAlertDialog(
                            context: context,
                            alertDialog:
                                const DasboardCollectorsCollectionsSortDialog(),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const DashboardDayCollection(),
          const DashboardWeekCollection(),
          const DashboardMonthCollection(),
          const DashboardYearCollection(),
          const DashboardGlobalCollection(),
        ],
      ),
    );
  }
}
