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
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(filterToolFieldDropdownProvider(widget.providerName));

    // Set initial value if not set
    if (selectedDropdownItem.back.isEmpty &&
        widget.dropdownMenuEntriesValues.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(filterToolFieldDropdownProvider(widget.providerName).notifier)
            .state = widget.dropdownMenuEntriesValues[0];
      });
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: DropdownMenu<Field>(
        width: widget.width,
        menuHeight: widget.menuHeigth,
        enabled: widget.enabled ?? true,
        enableFilter: true,
        label: RSTText(text: widget.label),
        hintText: widget.label,
        initialSelection: selectedDropdownItem,
        dropdownMenuEntries: widget.dropdownMenuEntriesLabels.map(
          (field) {
            return DropdownMenuEntry<Field>(
              value: field,
              label: field.front,
              style: const ButtonStyle(
                textStyle: MaterialStatePropertyAll(
                  TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            );
          },
        ).toList(),
        trailingIcon: const Icon(Icons.arrow_drop_down),
        onSelected: (value) {
          if (value == null) return;

          ref
              .read(
                  filterToolFieldDropdownProvider(widget.providerName).notifier)
              .state = value;

          ref
              .read(widget.filterParametersAddedProvider.notifier)
              .update((state) {
            final newState = Map<int, Map<String, dynamic>>.from(state);
            final newFilterToolMap = value.isRelation
                ? _handleRelationField(value)
                : _handleNonRelationField(value);
            newState[widget.filterToolIndex] = newFilterToolMap;
            return newState;
          });

          if (value.isRelation) {
            _buildNestedFieldDropdown(value);
          } else {
            _updateLastSelectedField(value);
          }
        },
      ),
    );
  }

  Map<String, dynamic> _handleRelationField(Field value) {
    final newNestedMap = generateNestedMap(field: value);
    return splitMap(
      map: ref.read(
              widget.filterParametersAddedProvider)[widget.filterToolIndex] ??
          {},
      depth: 0,
      targetDepth: widget.subFieldIndex,
      newNestedMap: newNestedMap,
      isRelation: true,
    );
  }

  Map<String, dynamic> _handleNonRelationField(Field value) {
    return splitMap(
      map: ref.read(
              widget.filterParametersAddedProvider)[widget.filterToolIndex] ??
          {},
      depth: 0,
      targetDepth: widget.subFieldIndex,
      newNestedMap: generateNestedMap(field: value),
      isRelation: false,
    );
  }

  void _buildNestedFieldDropdown(Field value) {
    final newNestedMap = generateNestedMap(field: value);
    tryBuildFieldDropDown(
      ref: ref,
      filterToolIndex: widget.filterToolIndex,
      subFieldIndex: widget.subFieldIndex + 1,
      fields: value.fields!,
      filterToolFieldsDropdowns: widget.filterToolFieldsDropdowns,
      subEntryValue: newNestedMap[value.back],
      filterParametersAddedProvider: widget.filterParametersAddedProvider,
    );
  }

  void _updateLastSelectedField(Field value) {
    ref
        .read(filterToolLastSubFieldProvider(widget.filterToolIndex).notifier)
        .state = value;
    widget.filterToolFieldsDropdowns.value = widget
        .filterToolFieldsDropdowns.value
        .take(widget.subFieldIndex + 1)
        .toList();
  }
}
