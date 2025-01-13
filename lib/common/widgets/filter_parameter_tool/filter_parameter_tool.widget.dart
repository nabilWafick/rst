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
import 'package:rst/utils/constants/api/api.constant.dart';

// used for storing the lastSubField of the filter tool
final filterToolLastSubFieldProvider = StateProvider.family<Field, int>(
  (ref, index) {
    return Field(
      front: '',
      back: '',
      type: dynamic,
      isNullable: false,
      isRelation: false,
    );
  },
);

// used for storing the lastSubField of the filter tool
final filterToolValueProvider = StateProvider.family<dynamic, int>(
  (ref, index) {
    return null;
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
  required ValueNotifier<List<RSTFilterToolFieldDropdown>> filterToolFieldsDropdowns,

  /// the value of the first entry of the parent entry
  /// ex: `parameter = {'product': {'name': '1'}}`
  /// for `subField 0`, parameter as subEntryValue is parsed,
  /// since product is a relation
  /// `subField 1` will get as subEntry `{'name': '1'}`
  required Map<String, dynamic> subEntryValue,

  /// the provider of the filter tools added (Map<int, Map<String,dynamic>>)
  /// used for storing alls tools parameters aded
  required StateProvider<Map<int, Map<String, dynamic>>> filterParametersAddedProvider,
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
      ref.read(filterToolLastSubFieldProvider(filterToolIndex).notifier).state = subField;
    }
  }
}

class FilterParameterTool extends StatefulHookConsumerWidget {
  /// used for identifying the the index of the filter in filter parameters list
  final int index;

  /// list of fields of the specific object
  final List<Field> fields;

  /// used for storing all filter parameters added
  final StateProvider<Map<int, Map<String, dynamic>>> filterParametersAddedProvider;

  const FilterParameterTool({
    super.key,
    required this.index,
    required this.fields,
    required this.filterParametersAddedProvider,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterParameterToolState();
}

class _FilterParameterToolState extends ConsumerState<FilterParameterTool> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFilterTool();
    });
  }

  void _initializeFilterTool() {
    final filterToolParameter = ref.read(widget.filterParametersAddedProvider)[widget.index] ?? {};

    tryBuildFieldDropDown(
      ref: ref,
      filterToolIndex: widget.index,
      subFieldIndex: 0,
      fields: widget.fields,
      filterToolFieldsDropdowns: filterToolFieldsDropdowns,
      subEntryValue: filterToolParameter,
      filterParametersAddedProvider: widget.filterParametersAddedProvider,
    );
  }

  final filterToolFieldsDropdowns = ValueNotifier<List<RSTFilterToolFieldDropdown>>([]);

  @override
  Widget build(BuildContext context) {
    final showWidget = useState<bool>(true);
    final lastSubField = ref.watch(filterToolLastSubFieldProvider(widget.index));
    //  final filterToolParameter =
    //      ref.watch(widget.filterParametersAddedProvider)[widget.index] ?? {};

    return showWidget.value
        ? Container(
            margin: const EdgeInsets.only(bottom: 20.0),
            child: Wrap(
              runSpacing: 7,
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(
                  Icons.format_list_bulleted_sharp,
                  color: RSTColors.primaryColor,
                  size: 20,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return ValueListenableBuilder<List<RSTFilterToolFieldDropdown>>(
                      valueListenable: filterToolFieldsDropdowns,
                      builder: (context, dropdowns, child) {
                        return Wrap(
                          runSpacing: 5,
                          spacing: 5,
                          children: dropdowns,
                        );
                      },
                    );
                  },
                ),
                _buildOperatorDropdown(lastSubField),
                _buildInputField(lastSubField),
                _buildCloseButton(showWidget),
              ],
            ),
          )
        : const SizedBox();
  }

  Widget _buildOperatorDropdown(Field lastSubField) {
    return Consumer(
      builder: (context, ref, child) {
        List<Operator> filterParameterToolOperators = _getOperatorsForField(lastSubField);
        final filterToolOperator =
            ref.watch(operatorDropdownProvider('filter_parameter_tool_operator_${widget.index}'));

        if (FilterOperators.allOperators.contains(filterToolOperator)) {
          filterParameterToolOperators =
              {filterToolOperator, ...filterParameterToolOperators}.toList();
        } else {
          filterParameterToolOperators = filterParameterToolOperators.toSet().toList();
        }

        return RSTOperatorDropdown(
          width: 250.0,
          menuHeigth: 300.0,
          label: 'Opération',
          providerName: 'filter_parameter_tool_operator_${widget.index}',
          dropdownMenuEntriesLabels: filterParameterToolOperators,
          dropdownMenuEntriesValues: filterParameterToolOperators,
        );
      },
    );
  }

  List<Operator> _getOperatorsForField(Field field) {
    if (field.type == int || field.type == double || field.type == num) {
      return [...FilterOperators.commonOperators, ...FilterOperators.numberOperators];
    } else if (field.type == String) {
      return [...FilterOperators.commonOperators, ...FilterOperators.stringOperators];
    } else if (field.type == DateTime) {
      return [...FilterOperators.commonOperators, ...FilterOperators.datesOperators];
    }
    return FilterOperators.commonOperators;
  }

  Widget _buildInputField(Field lastSubField) {
    return IntrinsicWidth(
      child: Container(
        //  width: 300.0,
        constraints: const BoxConstraints(
          minWidth: 250.0,
        ),

        child: Consumer(
          builder: (context, ref, child) {
            final filterToolValue = ref.watch(filterToolValueProvider(widget.index));

            final filterOperator = ref
                .watch(operatorDropdownProvider("filter_parameter_tool_operator_${widget.index}"));

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (lastSubField.isNullable &&
                    FilterOperators.commonOperators.contains(filterOperator) &&
                    (filterToolValue == RSTApiConstants.nullValue || filterToolValue == null))
                  const SizedBox(
                    width: 250.0,
                    child: RSTText(
                      text: "Null",
                      fontSize: 14.0,
                      color: RSTColors.tertiaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                else if (lastSubField.type == bool || filterToolValue.runtimeType == bool)
                  SizedBox(
                      width: 250.0,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final initialValue = ref.watch(filterParameterToolBoolFieldValueProvider(
                                  'filter_parameter_tool_bool_input_${widget.index}')) ??
                              (filterToolValue ?? true);
                          return FilterParameterToolBoolField(
                            initialValue: initialValue,
                            //  isNullable: lastSubField.isNullable,
                            providerName: 'filter_parameter_tool_bool_input_${widget.index}',
                          );
                        },
                      ))
                else if ((lastSubField.type == int ||
                        lastSubField.type == double ||
                        lastSubField.type == num) ||
                    (filterToolValue.runtimeType == int ||
                        filterToolValue.runtimeType == double ||
                        filterToolValue.runtimeType == num))
                  SizedBox(
                    width: 250.0,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final initialValue = ref.watch(filterParameterToolTextFieldValueProvider(
                                'filter_parameter_tool_number_input_${widget.index}')) ??
                            (filterToolValue != null ? '$filterToolValue' : '1');
                        return FilterParameterToolTextFormField(
                          initialValue: initialValue,
                          //  isNullable: lastSubField.isNullable,
                          inputProvider: 'filter_parameter_tool_number_input_${widget.index}',
                          label: 'Nombre',
                          hintText: 'Nombre',
                          textInputType: TextInputType.number,
                          validator: FilterParameterToolValidator.textFieldValue,
                          onChanged: FilterParameterToolOnChanged.textFieldValue,
                        );
                      },
                    ),
                  )
                else if ((lastSubField.type == DateTime) ||
                    (filterToolValue.runtimeType == String &&
                        DateTime.tryParse(filterToolValue.toString()).runtimeType == DateTime))
                  Column(
                    children: [
                      SizedBox(
                          width: 250.0,
                          child: Consumer(
                            builder: (context, ref, child) {
                              final initialValue = (ref.watch(
                                          filterParameterToolDateTimeFieldValueProvider(
                                              'filter_parameter_tool_datetime_input_${widget.index}')) !=
                                      null
                                  ? "${ref.watch(filterParameterToolDateTimeFieldValueProvider('filter_parameter_tool_datetime_input_${widget.index}'))!.toIso8601String()}Z"
                                  : (filterToolValue ?? "${DateTime.now().toIso8601String()}Z"));

                              return FilterParameterToolDateTimeField(
                                initialValue: initialValue,
                                providerName:
                                    'filter_parameter_tool_datetime_input_${widget.index}',
                                //  isNullable: lastSubField.isNullable,
                              );
                            },
                          )),
                    ],
                  )
                else
                  SizedBox(
                      width: 250.0,
                      child: Consumer(
                        builder: (context, ref, child) {
                          final initialValue = (ref.watch(filterParameterToolTextFieldValueProvider(
                                'filter_parameter_tool_text_input_${widget.index}',
                              )) ??
                              (filterToolValue ?? ""));
                          return FilterParameterToolTextFormField(
                            initialValue: initialValue,
                            //  isNullable: lastSubField.isNullable,
                            inputProvider: 'filter_parameter_tool_text_input_${widget.index}',
                            label: 'Texte',
                            hintText: 'Texte',
                            textInputType: TextInputType.text,
                            validator: FilterParameterToolValidator.textFieldValue,
                            onChanged: FilterParameterToolOnChanged.textFieldValue,
                          );
                        },
                      )),
                FilterOperators.commonOperators.contains(filterOperator) && lastSubField.isNullable
                    ? InkWell(
                        onTap: () {
                          if (filterToolValue == null ||
                              filterToolValue == RSTApiConstants.nullValue) {
                            if (lastSubField.type == bool) {
                              ref.read(filterToolValueProvider(widget.index).notifier).state = true;
                            }
                            if ((lastSubField.type == int ||
                                lastSubField.type == double ||
                                lastSubField.type == num)) {
                              ref.read(filterToolValueProvider(widget.index).notifier).state = 1;
                            } else if ((lastSubField.type == DateTime)) {
                              ref.read(filterToolValueProvider(widget.index).notifier).state =
                                  "${DateTime.now().toIso8601String()}Z";
                            } else {
                              ref.read(filterToolValueProvider(widget.index).notifier).state = '';
                            }
                          } else {
                            ref.read(filterToolValueProvider(widget.index).notifier).state = null;

                            // make filter value nullable
                            ref
                                .read(filterParameterToolTextFieldValueProvider(
                                  'filter_parameter_tool_text_input_${widget.index}',
                                ).notifier)
                                .state = null;

                            ref
                                .read(filterParameterToolTextFieldValueProvider(
                                        'filter_parameter_tool_number_input_${widget.index}')
                                    .notifier)
                                .state = null;

                            ref
                                .read(filterParameterToolDateTimeFieldValueProvider(
                                        'filter_parameter_tool_datetime_input_${widget.index}')
                                    .notifier)
                                .state = null;

                            ref
                                .read(filterParameterToolBoolFieldValueProvider(
                                        'filter_parameter_tool_bool_input_${widget.index}')
                                    .notifier)
                                .state = null;
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Icon(
                            filterToolValue == null ? Icons.data_saver_off : Icons.data_saver_on,
                            color: RSTColors.primaryColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            );
            // if (lastSubField.type == bool || filterToolValue.runtimeType == bool) {
            //   return FilterParameterToolBoolField(
            //     initialValue: filterToolValue,
            //     //  isNullable: lastSubField.isNullable,
            //     providerName: 'filter_parameter_tool_bool_input_${widget.index}',
            //   );
            // }
            // if ((lastSubField.type == int ||
            //         lastSubField.type == double ||
            //         lastSubField.type == num) ||
            //     (filterToolValue.runtimeType == int ||
            //         filterToolValue.runtimeType == double ||
            //         filterToolValue.runtimeType == num)) {
            //   return FilterParameterToolTextFormField(
            //     initialValue: filterToolValue?.toInt().toString(),
            //     //  isNullable: lastSubField.isNullable,
            //     inputProvider: 'filter_parameter_tool_number_input_${widget.index}',
            //     label: 'Nombre',
            //     hintText: 'Nombre',
            //     textInputType: TextInputType.number,
            //     validator: FilterParameterToolValidator.textFieldValue,
            //     onChanged: FilterParameterToolOnChanged.textFieldValue,
            //   );
            // } else if ((lastSubField.type == DateTime) ||
            //     (filterToolValue.runtimeType == String &&
            //         DateTime.tryParse(filterToolValue.toString()).runtimeType == DateTime)) {
            //   return FilterParameterToolDateTimeField(
            //     initialValue: filterToolValue,
            //     providerName: 'filter_parameter_tool_datetime_input_${widget.index}',
            //     //  isNullable: lastSubField.isNullable,
            //   );
            // }
            // return FilterParameterToolTextFormField(
            //   initialValue: filterToolValue,
            //   //  isNullable: lastSubField.isNullable,
            //   inputProvider: 'filter_parameter_tool_text_input_${widget.index}',
            //   label: 'Texte',
            //   hintText: 'Texte',
            //   textInputType: TextInputType.text,
            //   validator: FilterParameterToolValidator.textFieldValue,
            //   onChanged: FilterParameterToolOnChanged.textFieldValue,
            // );
          },
        ),
      ),
    );
  }

  Widget _buildCloseButton(ValueNotifier<bool> showWidget) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: IconButton(
        onPressed: () {
          showWidget.value = false;
          ref.read(widget.filterParametersAddedProvider.notifier).update(
                (state) => {...state, widget.index: {}},
              );
        },
        icon: const Icon(
          Icons.close_rounded,
          color: RSTColors.primaryColor,
          size: 25.0,
        ),
      ),
    );
  }

  @override
  void dispose() {
    filterToolFieldsDropdowns.dispose();
    super.dispose();
  }
}
