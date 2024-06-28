import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/selection_tools/collector/providers/selection.provider.dart';
import 'package:rst/modules/cash/collections/providers/collections.provider.dart';
import 'package:rst/modules/cash/collections/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/cash/collections/views/widgets/forms/addition/collection_addition.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class CollectionsPageHeader extends StatefulHookConsumerWidget {
  const CollectionsPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionsPageHeaderState();
}

class _CollectionsPageHeaderState extends ConsumerState<CollectionsPageHeader> {
  @override
  Widget build(BuildContext context) {
    final collectionsListParameters =
        ref.watch(collectionsListParametersProvider);
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
                  // refresh providers counts and the collections list
                  ref.invalidate(collectionsListStreamProvider);
                  ref.invalidate(collectionsCountProvider);
                  ref.invalidate(specificCollectionsCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: collectionsListParameters.containsKey('where') &&
                        collectionsListParameters['where'].containsKey('AND') &&
                        collectionsListParameters['where']['AND'].isNotEmpty
                    ? 'Filtré'
                    : 'Filtrer',
                light: collectionsListParameters.containsKey('where') &&
                    collectionsListParameters['where'].containsKey('AND') &&
                    collectionsListParameters['where']['AND'].isNotEmpty,
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(collectionsListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (collectionsListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in collectionsListParameters['where']
                            .entries
                            .first
                            .value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch;

                      // add it to added filter parameters
                      ref
                          .read(
                        collectionsListFilterParametersAddedProvider.notifier,
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
                    alertDialog: const CollectionFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !collectionsListParameters.containsKey('orderBy') ||
                        !collectionsListParameters['orderBy'].isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: collectionsListParameters.containsKey('orderBy') &&
                    collectionsListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const CollectionSortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportCollectionsList]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CollectionPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportCollectionsList]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              const CollectionExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.addCollection]
                  ? RSTAddButton(
                      onTap: () {
                        ref.invalidate(collectorSelectionToolProvider(
                            'collection-addition'));
                        ref.read(collectionDateProvider.notifier).state = null;
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CollectionAdditionForm(),
                        );
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
