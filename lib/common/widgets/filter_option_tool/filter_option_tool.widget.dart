import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/filter_option_tool/textformfield/textformfield.widget.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class FilterOptionTool extends HookConsumerWidget {
  final String logicalOperator;
  final List<Field> fields;
  final Map<String, dynamic> filterOption;

  final StateProvider<Map<String, dynamic>> filterOptionsProvider;
  const FilterOptionTool({
    super.key,
    required this.logicalOperator,
    required this.fields,
    required this.filterOption,
    required this.filterOptionsProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showWidget = useState<bool>(true);

    // get the field of the sort option
    final field = ProductStructure.fields.firstWhere(
      (field) {
        return field.back == filterOption.entries.first.key;
      },
    );
    return showWidget.value
        ? Row(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  // store field front values
                  final labelsData = fields.map(
                    (field) => field.front,
                  );
                  // add the front value of the selected field to previous value
                  // convert the collection to list so as to avoid repetition
                  final labels = {
                    field.front,
                    ...labelsData,
                  }.toList();

                  // do the same thing for back values of the fields
                  // store field front values
                  final valuesData = fields.map(
                    (field) => field.back,
                  );
                  // add the front value of the selected field to previous value
                  // convert the collection to list so as to avoid repetition
                  final values = {
                    field.back,
                    ...valuesData,
                  }.toList();
                  return RSTStringDropdown(
                    width: 250.0,
                    menuHeigth: 300.0,
                    label: 'Champ',
                    providerName: 'field',
                    dropdownMenuEntriesLabels: labels,
                    dropdownMenuEntriesValues: values,
                  );
                },
              ),
              const RSTStringDropdown(
                width: 200.0,
                menuHeigth: 300.0,
                label: 'Opération',
                providerName: 'operator',
                dropdownMenuEntriesLabels: [
                  'égal à',
                  'différent de',
                  'contenant',
                  'commençant par',
                  'finissant par',
                  'inférieur à',
                  'inférieur ou égal à',
                  'supérieur à',
                  'supérieur ou égal à',
                  'est null',
                  'n\'est pas null',
                ],
                dropdownMenuEntriesValues: [
                  'equals',
                  'not',
                  'contains',
                  'startsWith',
                  'endsWith',
                  'lt',
                  'lte',
                  'gt',
                  'gte',
                  'isNull',
                  'isNotNull',
                ],
              ),
              SizedBox(
                width: 239.0,
                child: FilterOptionToolTextFormField(
                  inputProvider: 'Value',
                  label: 'Value',
                  hintText: 'Valeur',
                  textInputType: TextInputType.text,
                  validator: (value, inputProvider, ref) {
                    return;
                  },
                  onChanged: (value, inputProvider, ref) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: IconButton(
                  onPressed: () {
                    // remove the sort option
                    ref.read(filterOptionsProvider.notifier).update(
                      (state) {
                        if (state['where'].length > 1) {
                          // get th index of the sort option in the list
                          final index = state['where'].indexOf(filterOption);

                          // remove the sort option
                          state['where'].removeAt(index);

                          state = {
                            ...state,
                            'where': state['where'],
                          };
                        } else {
                          Map<String, dynamic> newState = {};

                          for (MapEntry<String, dynamic> entry
                              in state.entries) {
                            if (entry.key != 'where') {
                              newState[entry.key] = entry.value;
                            }
                          }
                          state = newState;
                        }
                        return state;
                      },
                    );

                    // hide the widget
                    showWidget.value = false;
                  },
                  icon: const Icon(
                    Icons.close_rounded,
                    color: RSTColors.primaryColor,
                    size: 25.0,
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
