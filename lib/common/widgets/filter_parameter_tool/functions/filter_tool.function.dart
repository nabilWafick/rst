import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/filter_parameter_tool/boolfield/boolfield.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/datetimefield/datetimefield.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/textformfield/validator/filter_tool_validator.dart';

Map<String, dynamic> splitMap({
  required Map<String, dynamic> map,
  required int depth,
  required int targetDepth,
  required Map<String, dynamic> newNestedMap,
  required bool isRelation,
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
      result[newNestedMap.entries.first.key] = newNestedMap.entries.first.value;

      // add include key if it is a relation
      /*  if (isRelation) {
        result['include'] = true;
      }*/
    } else if (value is Map) {
      // continue the nesting if the goal is not reached
      result[key] = splitMap(
        map: value as Map<String, dynamic>,
        depth: depth + 1,
        targetDepth: targetDepth,
        newNestedMap: newNestedMap,
        isRelation: isRelation,
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
      // generate a nested relation
      nestedMap = {
        field.back: generateNestedMap(
          field: field.fields!.first,
        ),
        // 'include': true,
      };
    } else {
      // subField found and isn't a relation
      // generate a nested relation
      nestedMap = {
        field.back: generateNestedMap(
          field: subField,
        ),
        //  'include': true,
      };
    }
  } else {
    // field isn't a relation
    nestedMap = {
      field.back: {
        'equals': '',
      }
    };
  }

  return nestedMap;
}

Map<String, dynamic> performFilterParameter({
  required WidgetRef ref,
  required int filterToolIndex,
  required Map<String, dynamic> filterParameter,
}) {
  Map<String, dynamic> result = {};

  filterParameter.forEach((key, value) {
    // check if the key is an operator
    if (FilterOperators.allOperators
        .any((operatore) => operatore.back == key)) {
      // watch the last subField of the filterTool
      final filterToolLastSubField =
          ref.watch(filterToolLastSubFieldProvider(filterToolIndex));

      // watch the tool operator
      final filterToolOperator = ref.watch(operatorDropdownProvider(
          'filter_parameter_tool_operator_$filterToolIndex'));

      // store input value

      dynamic filterValue;

      if (FilterOperators.commonOperators.contains(filterToolOperator)) {
        if (filterToolLastSubField.type == String) {
          filterValue = ref.watch(
            filterParameterToolTextFieldValueProvider(
              'filter_parameter_tool_text_input_$filterToolIndex',
            ),
          );
        } else if (filterToolLastSubField.type == bool) {
          filterValue = ref.watch(
            filterParameterToolBoolFieldValueProvider(
              'filter_parameter_tool_bool_input_$filterToolIndex',
            ),
          );
        } else if (filterToolLastSubField.type == int ||
            filterToolLastSubField.type == double ||
            filterToolLastSubField.type == num) {
          filterValue = ref.watch(
            filterParameterToolTextFieldValueProvider(
              'filter_parameter_tool_number_input_$filterToolIndex',
            ),
          );

          filterValue = double.tryParse(filterValue) ?? 0;
        } else if (filterToolLastSubField.type == DateTime) {
          filterValue = ref.watch(
            filterParameterToolDateTimeFieldValueProvider(
              'filter_parameter_tool_datetime_input_$filterToolIndex',
            ),
          );

          filterValue = '${filterValue.toIso8601String()}Z';
        }
      } else if (FilterOperators.numberOperators.contains(filterToolOperator) &&
          (filterToolLastSubField.type == int ||
              filterToolLastSubField.type == double ||
              filterToolLastSubField.type == num)) {
        filterValue = ref.watch(
          filterParameterToolTextFieldValueProvider(
            'filter_parameter_tool_number_input_$filterToolIndex',
          ),
        );

        filterValue = double.tryParse(filterValue) ?? 0;
      } else if (FilterOperators.stringOperators.contains(filterToolOperator)) {
        filterValue = ref.watch(
          filterParameterToolTextFieldValueProvider(
            'filter_parameter_tool_text_input_$filterToolIndex',
          ),
        );
      } else if (FilterOperators.datesOperators.contains(filterToolOperator)) {
        filterValue = ref.watch(
          filterParameterToolDateTimeFieldValueProvider(
            'filter_parameter_tool_datetime_input_$filterToolIndex',
          ),
        );

        filterValue = '${filterValue.toIso8601String()}Z';
      }

      // remove the default operator 'equals'
      result.remove(key);

      // add insensitive mode in case of text search
      if (FilterOperators.stringOperators.contains(filterToolOperator)) {
        result[filterToolOperator.back] = filterValue;
        result['mode'] = 'insensitive';
      } else {
        result[filterToolOperator.back] = filterValue;
      }
    } else if (value is Map) {
      // continue the nesting if the goal is not reached
      result[key] = performFilterParameter(
        ref: ref,
        filterToolIndex: filterToolIndex,
        filterParameter: value as Map<String, dynamic>,
      );
    } else {
      // store all keys
      result[key] = value;
    }
  });

  return result;
}

void defineFilterToolOperatorAndValue({
  required WidgetRef ref,
  required int filterToolIndex,
  required Map<String, dynamic> filterParameter,
}) {
  filterParameter.forEach((key, value) {
    // check if the key is an operator
    if (FilterOperators.allOperators
        .any((operatore) => operatore.back == key)) {
      // update  tool operator
      ref
          .read(operatorDropdownProvider(
                  'filter_parameter_tool_operator_$filterToolIndex')
              .notifier)
          .state = FilterOperators.allOperators.firstWhere(
        (operatore) => operatore.back == key,
      );

      // update tool value
      ref.read(filterToolValueProvider(filterToolIndex).notifier).state = value;
    } else if (value is Map) {
      // continue the nesting if the goal is not reached
      defineFilterToolOperatorAndValue(
        ref: ref,
        filterToolIndex: filterToolIndex,
        filterParameter: value as Map<String, dynamic>,
      );
    }
  });
}
