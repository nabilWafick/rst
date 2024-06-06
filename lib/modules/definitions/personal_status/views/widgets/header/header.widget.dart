import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/personal_status/providers/personal_status.provider.dart';
import 'package:rst/modules/definitions/personal_status/views/widgets/dialogs/excel/excel_dialog.widget.dart';
import 'package:rst/modules/definitions/personal_status/views/widgets/dialogs/filter/filter_dialog.widget.dart';
import 'package:rst/modules/definitions/personal_status/views/widgets/dialogs/pdf/pdf_dialog.widget.dart';
import 'package:rst/modules/definitions/personal_status/views/widgets/dialogs/sort/sort_dialog.widget.dart';
import 'package:rst/modules/definitions/personal_status/views/widgets/forms/addition/personal_status_addition.widget.dart';

class PersonalStatusPageHeader extends StatefulHookConsumerWidget {
  const PersonalStatusPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonalStatusPageHeaderState();
}

class _PersonalStatusPageHeaderState
    extends ConsumerState<PersonalStatusPageHeader> {
  @override
  Widget build(BuildContext context) {
    final personalStatusListParameters =
        ref.watch(personalStatusListParametersProvider);
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
                  // refresh providers counts and the personalStatus list
                  ref.invalidate(personalStatusListStreamProvider);
                  ref.invalidate(personalStatusCountProvider);
                  ref.invalidate(specificPersonalStatusCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: !personalStatusListParameters.containsKey('where')
                    ? 'Filtrer'
                    : 'Filtré',
                onTap: () async {
                  // reset added filter paramters provider
                  ref.invalidate(
                      personalStatusListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (personalStatusListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in personalStatusListParameters['where']
                            .entries
                            .first
                            .value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch;

                      // add it to added filter parameters
                      ref
                          .read(
                        personalStatusListFilterParametersAddedProvider
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
                    alertDialog: const PersonalStatusFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !personalStatusListParameters.containsKey('orderBy')
                    ? 'Trier'
                    : 'Trié',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const PersonalStatusSortDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.print_outlined,
                text: 'Imprimer',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const PersonalStatusPdfGenerationDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.view_module_outlined,
                text: 'Exporter',
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog:
                        const PersonalStatusExcelFileGenerationDialog(),
                  );
                },
              ),
              RSTAddButton(
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const PersonalStatusAdditionForm(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
