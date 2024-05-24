import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/models/field/field.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';

final filterToolFieldDropdownProvider = StateProvider.family<Field, String>(
  (ref, dropdown) {
    return Field(
      front: '',
      back: '',
      type: String,
      isNullable: false,
      isRelation: false,
    );
  },
);

class RSTFilterToolFieldDropdown extends RSTFieldDropdown {
  /// the index of the filter tool
  /// ex. index: 0 is the first added filter tool
  final int filterToolIndex;

  /// the index of the nested subField
  /// since it can be relation field, this is used
  /// for knowing the positon of subField, so as to perform
  /// provider name
  /// like ex. `filter_tool_field_${filterToolIndex}_$subFieldIndex`
  /// also used to update the tool parameter when the field dropdown value is
  /// changed
  final int subFieldIndex;

  /// used for storing every nested field dropdown builded
  /// it used in filter tool for diplaying all subField dropdown builded
  final ValueNotifier<List<RSTFilterToolFieldDropdown>>
      filterToolFieldsDropdowns;

  /// the value of the first entry of the parent entry
  /// ex: `parameter = {'product': {'name': '1'}}`
  /// for `subField 0`, parameter as subEntryValue is parsed,
  /// since product is a relation
  /// `subField 1` will get as subEntry `{'name': '1'}`
  final Map<String, dynamic> subEntryValue;

  /// the provider of the filter tool, used for storing the tool parameter
  // final StateProvider<Map<String, dynamic>> filterToolParameterProvider;

  /// the provider of the filter tools added (Map<int, Map<String,dynamic>>)
  /// used for storing alls tools parameters aded
  final StateProvider<Map<int, Map<String, dynamic>>>
      filterParametersAddedProvider;
  const RSTFilterToolFieldDropdown({
    super.key,
    super.width,
    super.menuHeigth,
    super.enabled,
    required super.label,
    required super.providerName,
    required super.dropdownMenuEntriesLabels,
    required super.dropdownMenuEntriesValues,
    required this.filterToolIndex,
    required this.subFieldIndex,
    required this.filterToolFieldsDropdowns,
    required this.subEntryValue,
    //  required this.filterToolParameterProvider,
    required this.filterParametersAddedProvider,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RSTFilterToolFieldDropdownState();
}

class _RSTFilterToolFieldDropdownState
    extends ConsumerState<RSTFilterToolFieldDropdown> {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        // check if dropdown item is not empty so as to avoid error
        // while setting the  the first item as the selectedItem
        if (widget.dropdownMenuEntriesValues.isNotEmpty) {
          ref
              .read(
                  filterToolFieldDropdownProvider(widget.providerName).notifier)
              .state = widget.dropdownMenuEntriesValues[0];
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(filterToolFieldDropdownProvider(widget.providerName));

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: DropdownMenu(
        width: widget.width,
        menuHeight: widget.menuHeigth,
        enabled: widget.enabled ?? true,
        enableFilter: true,
        label: RSTText(
          text: widget.label,
        ),
        hintText: widget.label,
        initialSelection: selectedDropdownItem,
        dropdownMenuEntries: widget.dropdownMenuEntriesLabels
            .map(
              (dropdownMenuEntryLabel) => DropdownMenuEntry(
                value: widget.dropdownMenuEntriesValues[widget
                    .dropdownMenuEntriesLabels
                    .indexOf(dropdownMenuEntryLabel)],
                label: dropdownMenuEntryLabel.front,
                style: const ButtonStyle(
                  textStyle: MaterialStatePropertyAll(
                    TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        trailingIcon: const Icon(
          Icons.arrow_drop_down,
        ),
        onSelected: (value) {
          ref
              .read(
                  filterToolFieldDropdownProvider(widget.providerName).notifier)
              .state = value!;

          ///* MAIN TOOL LOGIC

          // check if the the new field is a relation
          if (value.isRelation) {
            // generate a new nested map
            final newNestedMap = generateNestedMap(
              field: value,
            );

            /// * === TEST ===

            debugPrint(
              'Relation => nestedMap: $newNestedMap',
            );

            /// * === TEST ===

            // split and perfom the filterToolParameter add field  subField
            // in filterParameter
            final newFilterToolMap = splitMap(
              map: ref.watch(
                    widget.filterParametersAddedProvider,
                  )[widget.filterToolIndex] ??
                  {},
              depth: 0,
              targetDepth: widget.subFieldIndex,
              newNestedMap: newNestedMap,
              isRelation: true,
            );

            // update added filter tools parameters
            ref
                .read(
              widget.filterParametersAddedProvider.notifier,
            )
                .update((state) {
              state = {
                ...state,
                widget.filterToolIndex: newFilterToolMap,
              };
              return state;
            });

            /// * === TEST ===

            debugPrint(
              'Relation => newFilterToolMap: $newFilterToolMap',
            );

            /// * === TEST ===

            // build nested field dropdown
            tryBuildFieldDropDown(
              ref: ref,
              filterToolIndex: widget.filterToolIndex,
              subFieldIndex: widget.subFieldIndex + 1,
              fields: value.fields!,
              filterToolFieldsDropdowns: widget.filterToolFieldsDropdowns,
              // newNestedMap[value.back] because nested is generated
              // containing value but on subField is need
              subEntryValue: newNestedMap[value.back],
              filterParametersAddedProvider:
                  widget.filterParametersAddedProvider,
            );
          } else {
            // set the field as the lastSelected of the tool
            ref
                .read(
                  filterToolLastSubFieldProvider(widget.filterToolIndex)
                      .notifier,
                )
                .state = value;

            // split and perfom the filterToolParameter
            final newFilterToolMap = splitMap(
              map: ref.watch(
                    widget.filterParametersAddedProvider,
                  )[widget.filterToolIndex] ??
                  {},
              depth: 0,
              targetDepth: widget.subFieldIndex,
              newNestedMap: generateNestedMap(
                field: value,
              ),
              isRelation: false,
            );

            // update added filter tools parameters
            ref
                .read(
              widget.filterParametersAddedProvider.notifier,
            )
                .update(
              (state) {
                state = {...state, widget.filterToolIndex: newFilterToolMap};
                return state;
              },
            );

            // reduce the subField dropdowns and stop at this one

            widget.filterToolFieldsDropdowns.value = widget
                .filterToolFieldsDropdowns.value
                .take(widget.subFieldIndex + 1)
                .toList();
          }
        },
      ),
    );
  }
}
