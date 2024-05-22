import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/models/field/field.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

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

  /// used for storing the last subField added in the filter tool
  /// in order to display the equivalent operator
  final ValueNotifier<Field> lastSubField;

  /// used for storing every nested field dropdown builded
  /// it used in filter tool for diplaying all subField dropdown builded
  final ValueNotifier<List<Widget>> filterToolFieldsDropdowns;

  /// the value of the first entry of the parent entry
  /// ex: `parameter = {'product': {'name': '1'}}`
  /// for `subField 0`, parameter as subEntryValue is parsed,
  /// since product is a relation
  /// `subField 1` will get as subEntry `{'name': '1'}`
  final Map<String, dynamic> subEntryValue;

  /// the provider of the filter tool, used for storing the tool parameter
  final StateProvider<Map<String, dynamic>> filterToolParameterProvider;
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
    required this.lastSubField,
    required this.filterToolFieldsDropdowns,
    required this.subEntryValue,
    required this.filterToolParameterProvider,
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

    //*  === === === TEST === === ===
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

    ///*  === === === TEST === === ===

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
            // created a new nested map

            tryBuildFieldDropDown(
              ref: ref,
              filterToolIndex: widget.filterToolIndex,
              subFieldIndex: widget.subFieldIndex + 1,
              lastSubField: widget.lastSubField,
              fields: value.fields!,
              filterToolFieldsDropdowns: widget.filterToolFieldsDropdowns,
              subEntryValue: {},
              filterToolParameterProvider: widget.filterToolParameterProvider,
            );
          } else {
            // set the field as the lastSelected of the tool
            widget.lastSubField.value = value;

            // split and perfom the filterToolParameter
            final newFilterToolMap = splitMap(
              map: ref.watch(
                widget.filterToolParameterProvider,
              ),
              depth: 0,
              targetDepth: widget.subFieldIndex,
              newNestedMap: {
                value.back: {
                  'equals': '',
                },
              },
            );

            // update filter toolMap provider
            ref.read(widget.filterToolParameterProvider.notifier).state =
                newFilterToolMap;

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

Map<String, dynamic> splitMap({
  required Map<String, dynamic> map,
  required int depth,
  required int targetDepth,
  required Map<String, dynamic> newNestedMap,
}) {
  Map<String, dynamic> result = {};

  map.forEach((key, value) {
    // check if the targetDepth is reached
    if (depth == targetDepth) {
      // remove all key without 'include' key
      // this because, filter parameter map an sub map
      // contain only two key (currently)
      if (key != 'include') {
        result.remove(key);
      } else {
        result[key] = value;
      }

      // populate the subField
    } else if (value is Map) {
      // continue the nesting if the goal is not reached
      result[key] = splitMap(
        map: value as Map<String, dynamic>,
        depth: depth + 1,
        targetDepth: targetDepth,
        newNestedMap: newNestedMap,
      );
    } else {
      // store all keys
      result[key] = value;
    }
  });

  return result;
}

Map<String, dynamic> generateNestedMap({
  required Field field,
}) {
  Map<String, dynamic> nestedMap = {};

  if (field.isRelation) {
    // get the first sub field which is not a relation
    final subField = field.fields!.firstWhere(
      (field) => !field.isRelation,
      orElse: () {
        return Field(
          front: '_',
          back: '_',
          type: String,
          isNullable: false,
          isRelation: false,
        );
      },
    );

    if (subField.back == '_') {
    } else {
      // generate a nested rel
      nestedMap = {
        field.back: generateNestedMap(
          field: subField,
        ),
        'include': true,
      };
    }
  } else {
    nestedMap = {
      field.back: {
        'equals': '',
      }
    };
  }

  return nestedMap;
}
