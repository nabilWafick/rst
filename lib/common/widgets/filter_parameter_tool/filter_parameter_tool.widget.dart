import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/filter_parameter_tool/boolfield/boolfield.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/datetimefield/datetimefield.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/field_dopdown/filter_field_dopdown.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/intformfield%20/intformfield.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/textformfield/textformfield.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

// used for storing filter parameter tool value,
// indexing by the parameter index in added parameter list
final filterToolParameterProvider =
    StateProvider.family<Map<String, dynamic>, int>((ref, index) {
  return {};
});

void tryBuildFieldDropDown({
  required WidgetRef ref,

  /// the index of the filter tool
  /// ex. index: 0 is the first added filter tool
  required int filterToolIndex,

  /// the index of the nested subField
  /// since it can be relation field, this is used
  /// for knowing the positon of subField, so as to perform
  /// provider name
  /// like ex. `filter_tool_field_${filterToolIndex}_$subFieldIndex`
  /// also used to update the tool parameter when the field dropdown value is
  /// changed
  required int subFieldIndex,

  /// used for storing the last subField added in the filter tool
  /// in order to display the equivalent operator
  required ValueNotifier<Field> lastSubField,

  /// the list of field of the nested field group
  required List<Field> fields,

  /// used for storing every nested field dropdown builded
  /// it used in filter tool for diplaying all subField dropdown builded
  required ValueNotifier<List<Widget>> filterToolFieldsDropdowns,

  /// the value of the first entry of the parent entry
  /// ex: `parameter = {'product': {'name': '1'}}`
  /// for `subField 0`, parameter as subEntryValue is parsed,
  /// since product is a relation
  /// `subField 1` will get as subEntry `{'name': '1'}`
  required Map<String, dynamic> subEntryValue,

  /// the provider of the filter tool, used for storing the tool parameter
  required StateProvider<Map<String, dynamic>> filterToolParameterProvider,
}) {
  // check if the first entry value is an  operator
  if (!FilterOperators.allOperators.any(
    (operatore) => operatore.back != subEntryValue.entries.first.key,
  )) {
    // field back
    String subFieldBackValue = subEntryValue.entries.first.key;

    // get the equivalent field
    // loop in the list of field
    // for getting the equivalent field

    final subField = fields.firstWhere(
      (field) => field.back == subFieldBackValue,
    );

    // create field dropdown
    filterToolFieldsDropdowns.value.add(
      RSTFilterToolFieldDropdown(
        width: 250.0,
        menuHeigth: 300.0,
        label: 'Champ',
        providerName: 'filter_tool_field_${filterToolIndex}_$subFieldIndex',
        filterToolIndex: filterToolIndex,
        subFieldIndex: subFieldIndex,
        lastSubField: lastSubField,
        filterToolFieldsDropdowns: filterToolFieldsDropdowns,
        subEntryValue: subEntryValue.entries.first.value,
        // the provider create in the filter tool use for storing
        // it's parameter
        filterToolParameterProvider: filterToolParameterProvider,
        dropdownMenuEntriesLabels: {
          subField,
          ...fields,
        }.toList(),
        dropdownMenuEntriesValues: {
          subField,
          ...fields,
        }.toList(),
      ),
    );

    // check if the field is a relation
    if (subField.isRelation) {
      // call the function for building nested field
      tryBuildFieldDropDown(
        ref: ref,
        filterToolIndex: filterToolIndex,
        subFieldIndex: subFieldIndex + 1,
        lastSubField: lastSubField,
        fields: subField.fields!,
        filterToolFieldsDropdowns: filterToolFieldsDropdowns,
        subEntryValue: subEntryValue.entries.first.value,
        filterToolParameterProvider: filterToolParameterProvider,
      );
    } else {
      // define the last subfield
      lastSubField.value = subField;
    }
  }
}

class FilterParameterTool extends StatefulHookConsumerWidget {
  // used for identifying the the index of the filter in filter parameters list
  final int index;
  // list of fields of the specific object
  final List<Field> fields;
  // used for storing all filter parameters added
  final StateProvider<Map<int, Map<String, dynamic>>>
      filterParametersAddedProvider;
  // used for storing all filter parameters tools added
  final StateProvider<Map<int, bool>> filterParametersToolsAddedProvider;

  const FilterParameterTool({
    super.key,
    required this.index,
    required this.fields,
    required this.filterParametersAddedProvider,
    required this.filterParametersToolsAddedProvider,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterParameterToolState();
}

class _FilterParameterToolState extends ConsumerState<FilterParameterTool> {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        // set the filter tool parameter
        ref.read(filterToolParameterProvider(widget.index).notifier).state =
            // read the parameter store with key index (tool index)
            ref.read(widget.filterParametersAddedProvider)[widget.index]!;
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showWidget = useState<bool>(true);

    final lastSubField = useState<Field>(
      Field(
        front: 'init',
        back: 'init',
        type: String,
        isNullable: false,
        isRelation: false,
      ),
    );

    final filterToolFieldsDropdowns = useState<List<Widget>>([]);

    return showWidget.value
        ? Container(
            margin: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Wrap(
              runSpacing: 5,
              spacing: 5,
              children: [
                // build fields dropdowns
                Consumer(
                  builder: (context, ref, child) {
                    tryBuildFieldDropDown(
                      ref: ref,
                      filterToolIndex: widget.index,
                      subFieldIndex: 0,
                      lastSubField: lastSubField,
                      fields: widget.fields,
                      filterToolFieldsDropdowns: filterToolFieldsDropdowns,
                      // due initState state update stability problems,
                      // prefer watch the filter parameters added instead of
                      // of the tool provider
                      subEntryValue: ref.watch(
                          widget.filterParametersAddedProvider)[widget.index]!,
                      filterToolParameterProvider:
                          filterToolParameterProvider(widget.index),
                    );

                    return Column(
                      children: filterToolFieldsDropdowns.value,
                    );
                  },
                ),

                // build operator dropdown
                Consumer(
                  builder: (context, ref, child) {
                    List<Operator> filterParameterToolOperators = [];

                    // check lastSubFiled type and add equivalent operators
                    // to common type operators

                    if (lastSubField.value.type == int ||
                        lastSubField.value.type == double ||
                        lastSubField.value.type == num) {
                      filterParameterToolOperators = [
                        ...FilterOperators.commonOperators,
                        ...FilterOperators.numberOperators,
                      ];
                    }

                    if (lastSubField.value.type == String) {
                      filterParameterToolOperators = [
                        ...FilterOperators.commonOperators,
                        ...FilterOperators.stringOperators,
                      ];
                    }

                    if (lastSubField.value.type == DateTime) {
                      filterParameterToolOperators = [
                        ...FilterOperators.commonOperators,
                        ...FilterOperators.datesOperators,
                      ];
                    }

                    if (lastSubField.value.isNullable) {
                      filterParameterToolOperators = [
                        ...FilterOperators.commonOperators,
                        ...FilterOperators.nullOperators,
                      ];
                    }

                    // remove repeated operators
                    filterParameterToolOperators =
                        filterParameterToolOperators.toSet().toList();

                    return RSTOperatorDropdown(
                      width: 250.0,
                      menuHeigth: 300.0,
                      label: 'Opération',
                      providerName:
                          'filter_parameter_tool_operator_${widget.index}',
                      dropdownMenuEntriesLabels: filterParameterToolOperators,
                      dropdownMenuEntriesValues: filterParameterToolOperators,
                    );
                  },
                ),
                SizedBox(
                  width: 250.0,
                  child: Consumer(
                    builder: (context, ref, child) {
                      // watch the tool operator so as to dispalay, show or use
                      // the correct formfiel (text, date, bool, )
                      final selectedOperator = ref.watch(
                        operatorDropdownProvider(
                          'filter_parameter_tool_operator_${widget.index}',
                        ),
                      );

                      if (FilterOperators.nullOperators
                          .contains(selectedOperator)) {
                        return FilterParameterToolBoolField(
                          providerName:
                              'filter_parametr_tool_null_input_${widget.index}',
                        );
                      }

                      if (lastSubField.value.type == bool) {
                        return FilterParameterToolBoolField(
                          providerName:
                              'filter_parametr_tool_bool_input_${widget.index}',
                        );
                      }

                      if (lastSubField.value.type == int ||
                          lastSubField.value.type == double ||
                          lastSubField.value.type == num) {
                        return FilterParameterToolNumberFormField(
                          inputProvider:
                              'filter_parametr_tool_number_input_${widget.index}',
                          label: 'Nombre',
                          hintText: 'Nombre',
                          textInputType: TextInputType.text,
                          validator: (value, inputProvider, ref) {
                            return;
                          },
                          onChanged: (value, inputProvider, ref) {},
                        );
                      }

                      if (lastSubField.value.type == DateTime) {
                        return FilterParameterToolDateTimeField(
                          providerName:
                              'filter_parametr_tool_datetime_input_${widget.index}',
                        );
                      }

                      return FilterParameterToolTextFormField(
                        inputProvider:
                            'filter_parametr_tool_text_input_${widget.index}',
                        label: 'Texte',
                        hintText: 'Texte',
                        textInputType: TextInputType.text,
                        validator: (value, inputProvider, ref) {
                          return;
                        },
                        onChanged: (value, inputProvider, ref) {},
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: IconButton(
                    onPressed: () {
                      // set the the filter tool visibility to false in
                      // added filter tool
                      ref
                          .read(
                        widget.filterParametersToolsAddedProvider.notifier,
                      )
                          .update((state) {
                        state = {
                          ...state,
                          widget.index: state[widget.index]!,
                        };
                        return state;
                      });

                      // remove the filter parameter from the filter parameters
                      // added

                      ref
                          .read(widget.filterParametersAddedProvider.notifier)
                          .update(
                        (state) {
                          Map<int, Map<String, dynamic>> newState = {};

                          for (MapEntry<int, Map<String, dynamic>> entry
                              in state.entries) {
                            if (entry.key != widget.index) {
                              newState[entry.key] = entry.value;
                            }
                          }
                          state = newState;

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
            ),
          )
        : const SizedBox();
  }
}
