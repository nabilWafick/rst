import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/modules/statistics/collectors_collections/models/collector_collection_type/collector_collection_type.model.dart';
import 'package:rst/modules/statistics/collectors_collections/providers/collectors_collections.provider.dart';
import 'package:rst/modules/statistics/collectors_collections/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/utils/utils.dart';

class CollectorsCollectionsPageHeader extends StatefulHookConsumerWidget {
  const CollectorsCollectionsPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorsCollectionsPageHeaderState();
}

class _CollectorsCollectionsPageHeaderState
    extends ConsumerState<CollectorsCollectionsPageHeader> {
  @override
  Widget build(BuildContext context) {
    final collectorsCollectionsListParameters =
        ref.watch(collectorsCollectionsListParametersProvider);

    final collectorCollectionType = ref.watch(collectorCollectionTypeProvider);
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
                  // refresh providers counts and the types list
                  ref.invalidate(collectorsCollectionsListStreamProvider);
                  ref.invalidate(collectorsCollectionsCountProvider);
                  ref.invalidate(specificCollectorsCollectionsCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text:
                    collectorsCollectionsListParameters.containsKey('where') &&
                            collectorsCollectionsListParameters['where']
                                .containsKey('AND') &&
                            collectorsCollectionsListParameters['where']['AND']
                                .isNotEmpty
                        ? 'Filtré'
                        : 'Filtrer',
                light:
                    collectorsCollectionsListParameters.containsKey('where') &&
                        collectorsCollectionsListParameters['where']
                            .containsKey('AND') &&
                        collectorsCollectionsListParameters['where']['AND']
                            .isNotEmpty,
                onTap: () async {
                  final random = Random();
                  // reset added filter paramters provider
                  ref.invalidate(
                      collectorsCollectionsListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (collectorsCollectionsListParameters
                      .containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in collectorsCollectionsListParameters['where']
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
                    alertDialog: const CollectorsCollectionsFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !collectorsCollectionsListParameters
                            .containsKey('orderBy') ||
                        !collectorsCollectionsListParameters['orderBy']
                            .isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: collectorsCollectionsListParameters
                        .containsKey('orderBy') &&
                    collectorsCollectionsListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CollectorsCollectionsortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[
                          PermissionsValues.printCollectorsStatistics]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const CollectorsCollectionsPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[
                          PermissionsValues.exportCollectorsStatistics]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const CollectorsCollectionsExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              SizedBox(
                width: 200.0,
                child: DropdownButtonFormField(
                  dropdownColor: RSTColors.backgroundColor,
                  value: collectorCollectionType,
                  items: const [
                    DropdownMenuItem(
                      value: CollectorCollectionType.day,
                      child: RSTText(
                        text: 'Journalière',
                        fontSize: 10.0,
                      ),
                    ),
                    DropdownMenuItem(
                      value: CollectorCollectionType.week,
                      child: RSTText(
                        text: 'Hebdomadaire',
                        fontSize: 10.0,
                      ),
                    ),
                    DropdownMenuItem(
                      value: CollectorCollectionType.month,
                      child: RSTText(
                        text: 'Mensuelle',
                        fontSize: 10.0,
                      ),
                    ),
                    DropdownMenuItem(
                      value: CollectorCollectionType.year,
                      child: RSTText(
                        text: 'Annuelle',
                        fontSize: 10.0,
                      ),
                    ),
                    DropdownMenuItem(
                      value: CollectorCollectionType.global,
                      child: RSTText(
                        text: 'Globale',
                        fontSize: 10.0,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    ref.read(collectorCollectionTypeProvider.notifier).state =
                        value!;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
