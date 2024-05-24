import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/filter_parameter_tool/boolfield/boolfield.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/datetimefield/datetimefield.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/field_dopdown/filter_field_dopdown.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/textformfield/on_changed/filter_tool_on_changed.dart';
import 'package:rst/common/widgets/filter_parameter_tool/textformfield/textformfield.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/textformfield/validator/filter_tool_validator.dart';
import 'package:rst/utils/colors/colors.util.dart';

// used for storing the lastSubField of the filter tool
final filterToolLastSubFieldProvider = StateProvider.family<Field, int>(
  (ref, index) {
    return Field(
      front: '',
      back: '',
      type: String,
      isNullable: false,
      isRelation: false,
    );
  },
);

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

  /// the list of field of the nested field group
  required List<Field> fields,

  /// used for storing every nested field dropdown builded
  /// it used in filter tool for diplaying all subField dropdown builded
  required ValueNotifier<List<RSTFilterToolFieldDropdown>>
      filterToolFieldsDropdowns,

  /// the value of the first entry of the parent entry
  /// ex: `parameter = {'product': {'name': '1'}}`
  /// for `subField 0`, parameter as subEntryValue is parsed,
  /// since product is a relation
  /// `subField 1` will get as subEntry `{'name': '1'}`
  required Map<String, dynamic> subEntryValue,

  /// the provider of the filter tools added (Map<int, Map<String,dynamic>>)
  /// used for storing alls tools parameters aded
  required StateProvider<Map<int, Map<String, dynamic>>>
      filterParametersAddedProvider,
}) {
  //debugPrint('')
  // check if the first entry value is an  operator
  if (subEntryValue.isNotEmpty &&
      !FilterOperators.allOperators.any(
        (operatore) => operatore.back == subEntryValue.entries.first.key,
      )) {
    // field back
    String subFieldBackValue = subEntryValue.entries.first.key;

    // get the equivalent field
    // loop in the list of field
    // for getting the equivalent field

    final subField = fields.firstWhere(
      (field) => field.back == subFieldBackValue,
    );

    // build field dropdown
    // * === IMPORTANT  === * //
    // In cause of rebuilding, it necessary if check if the filter tool field
    // have been build (Check if filterToolFields containsn a RSTFilterToolFieldDropdown with a
    // subFieldIndex equal to the index parsed)
    // * === IMPORTANT  === * //

    if (!filterToolFieldsDropdowns.value
        .any((fieldDropdown) => fieldDropdown.subFieldIndex == subFieldIndex)) {
      filterToolFieldsDropdowns.value.add(
        RSTFilterToolFieldDropdown(
          width: 250.0,
          menuHeigth: 300.0,
          label: 'Champ',
          providerName: 'filter_tool_field_${filterToolIndex}_$subFieldIndex',
          filterToolIndex: filterToolIndex,
          subFieldIndex: subFieldIndex,

          filterToolFieldsDropdowns: filterToolFieldsDropdowns,
          subEntryValue: subEntryValue.entries.first.value,
          // the provider create in the filter tool use for storing
          // it's parameter

          filterParametersAddedProvider: filterParametersAddedProvider,
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
    }

    // check if the field is a relation
    if (subField.isRelation) {
      // call the function for building nested field
      tryBuildFieldDropDown(
        ref: ref,
        filterToolIndex: filterToolIndex,
        subFieldIndex: subFieldIndex + 1,
        fields: subField.fields!,
        filterToolFieldsDropdowns: filterToolFieldsDropdowns,
        subEntryValue: subEntryValue.entries.first.value,
        filterParametersAddedProvider: filterParametersAddedProvider,
      );
    } else {
      // define the last subfield
      ref.read(filterToolLastSubFieldProvider(filterToolIndex).notifier).state =
          subField;
    }
  }
}

class FilterParameterTool extends StatefulHookConsumerWidget {
  /// used for identifying the the index of the filter in filter parameters list
  final int index;

  /// list of fields of the specific object
  final List<Field> fields;

  /// used for storing all filter parameters added
  final StateProvider<Map<int, Map<String, dynamic>>>
      filterParametersAddedProvider;

  const FilterParameterTool({
    super.key,
    required this.index,
    required this.fields,
    required this.filterParametersAddedProvider,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterParameterToolState();
}

class _FilterParameterToolState extends ConsumerState<FilterParameterTool> {
  @override
  Widget build(BuildContext context) {
    // for show or hide the filter tool
    final showWidget = useState<bool>(true);

    // use for detecting the last subField in order
    // to display the correspording operator
    final lastSubField =
        ref.watch(filterToolLastSubFieldProvider(widget.index));

    // use to store all fields dropdowns
    final filterToolFieldsDropdowns =
        useState<List<RSTFilterToolFieldDropdown>>([]);

    return showWidget.value
        ? Container(
            margin: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Wrap(
              runSpacing: 5,
              spacing: 5,
              children: [
                /*   RSTText(
                  text:
                      'subField Number: ${filterToolFieldsDropdowns.value.length}',
                  fontSize: 12,
                ),*/
                // build fields dropdowns
                Consumer(
                  builder: (context, ref, child) {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () {
                        // if(ref.watch(f))
                        tryBuildFieldDropDown(
                          ref: ref,
                          filterToolIndex: widget.index,
                          subFieldIndex: 0,

                          fields: widget.fields,
                          filterToolFieldsDropdowns: filterToolFieldsDropdowns,
                          // due initState state update stability problems,
                          // prefer watch the filter parameters added instead of
                          // of the tool provider
                          subEntryValue:
                              ref.watch(widget.filterParametersAddedProvider)[
                                      widget.index] ??
                                  {},

                          filterParametersAddedProvider:
                              widget.filterParametersAddedProvider,
                        );
                      },
                    );

                    return Wrap(
                      runSpacing: 5,
                      spacing: 5,
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

                    if (lastSubField.type == int ||
                        lastSubField.type == double ||
                        lastSubField.type == num) {
                      filterParameterToolOperators = [
                        ...FilterOperators.commonOperators,
                        ...FilterOperators.numberOperators,
                      ];
                    }

                    if (lastSubField.type == String) {
                      filterParameterToolOperators = [
                        ...FilterOperators.commonOperators,
                        ...FilterOperators.stringOperators,
                      ];
                    }

                    if (lastSubField.type == DateTime) {
                      filterParameterToolOperators = [
                        ...FilterOperators.commonOperators,
                        ...FilterOperators.datesOperators,
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
                      if (lastSubField.type == bool) {
                        return FilterParameterToolBoolField(
                          providerName:
                              'filter_parameter_tool_bool_input_${widget.index}',
                        );
                      }

                      if (lastSubField.type == int ||
                          lastSubField.type == double ||
                          lastSubField.type == num) {
                        return FilterParameterToolTextFormField(
                          inputProvider:
                              'filter_parameter_tool_number_input_${widget.index}',
                          label: 'Nombre',
                          hintText: 'Nombre',
                          textInputType: TextInputType.number,
                          validator:
                              FilterParameterToolValidator.textFieldValue,
                          onChanged:
                              FilterParameterToolOnChanged.textFieldValue,
                        );
                      }

                      if (lastSubField.type == DateTime) {
                        return FilterParameterToolDateTimeField(
                          providerName:
                              'filter_parameter_tool_datetime_input_${widget.index}',
                        );
                      }

                      return FilterParameterToolTextFormField(
                        inputProvider:
                            'filter_parameter_tool_text_input_${widget.index}',
                        label: 'Texte',
                        hintText: 'Texte',
                        textInputType: TextInputType.text,
                        validator: FilterParameterToolValidator.textFieldValue,
                        onChanged: FilterParameterToolOnChanged.textFieldValue,
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: IconButton(
                    onPressed: () {
                      // hide the widget
                      showWidget.value = false;

                      // empty the filter tool parameter
                      ref
                          .read(widget.filterParametersAddedProvider.notifier)
                          .update(
                        (state) {
                          state = {
                            ...state,
                            widget.index: {},
                          };

                          return state;
                        },
                      );
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
