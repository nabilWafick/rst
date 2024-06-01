import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/common.model.dart';

class SelectionToolSearchInputOnChanged {
  static void stringInput({
    required WidgetRef ref,
    required Field field,
    required String value,
    required StateProvider<Map<String, dynamic>>
        selectionListParametersProvider,
  }) {
    final parameters = ref.read(selectionListParametersProvider);

    if (parameters.containsKey('where') &&
        parameters['where'].containsKey('AND')) {
      ref.read(selectionListParametersProvider.notifier).update((state) {
        List<Map<String, dynamic>> filters = state['where']['AND'];

        // remove field filter
        filters.removeWhere(
          (filter) => filter.entries.first.key == field.back,
        );

        if (value != '') {
          Map<String, dynamic> newFieldFilter = {
            field.back: {
              'contains': value,
              'mode': 'insensitive',
            }
          };

          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                ...filters,
                newFieldFilter,
              ],
            }
          };
        } else {
          // update state
          state = {
            ...state,
            'where': {
              'AND': filters,
            }
          };
        }

        return state;
      });
    } else {
      if (value != '') {
        ref.read(selectionListParametersProvider.notifier).update((state) {
          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                {
                  field.back: {
                    'contains': value,
                    'mode': 'insensitive',
                  }
                },
              ],
            }
          };

          return state;
        });
      }
    }
  }

  static void intInput({
    required WidgetRef ref,
    required Field field,
    required String value,
    required StateProvider<Map<String, dynamic>>
        selectionListParametersProvider,
  }) {
    final parameters = ref.read(selectionListParametersProvider);

    if (parameters.containsKey('where') &&
        parameters['where'].containsKey('AND')) {
      ref.read(selectionListParametersProvider.notifier).update((state) {
        List<Map<String, dynamic>> filters = state['where']['AND'];

        // remove field filter
        filters.removeWhere(
          (filter) => filter.entries.first.key == field.back,
        );

        if (value != '') {
          Map<String, dynamic> newFieldFilter = {
            field.back: {
              'equals': int.tryParse(value) ?? 0,
            }
          };

          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                ...filters,
                newFieldFilter,
              ],
            }
          };
        } else {
          // update state
          state = {
            ...state,
            'where': {
              'AND': filters,
            }
          };
        }

        return state;
      });
    } else {
      if (value != '') {
        ref.read(selectionListParametersProvider.notifier).update((state) {
          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                {
                  field.back: {
                    'equals': int.tryParse(value) ?? 0,
                  }
                },
              ],
            }
          };

          return state;
        });
      }
    }
  }

  static void doubleInput({
    required WidgetRef ref,
    required Field field,
    required String value,
    required StateProvider<Map<String, dynamic>>
        selectionListParametersProvider,
  }) {
    final parameters = ref.read(selectionListParametersProvider);

    if (parameters.containsKey('where') &&
        parameters['where'].containsKey('AND')) {
      ref.read(selectionListParametersProvider.notifier).update((state) {
        List<Map<String, dynamic>> filters = state['where']['AND'];

        // remove field filter
        filters.removeWhere(
          (filter) => filter.entries.first.key == field.back,
        );

        if (value != '') {
          Map<String, dynamic> newFieldFilter = {
            field.back: {
              'equals': double.tryParse(value) ?? 0,
            }
          };

          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                ...filters,
                newFieldFilter,
              ],
            }
          };
        } else {
          // update state
          state = {
            ...state,
            'where': {
              'AND': filters,
            }
          };
        }

        return state;
      });
    } else {
      if (value != '') {
        ref.read(selectionListParametersProvider.notifier).update((state) {
          // update state
          state = {
            ...state,
            'where': {
              'AND': [
                {
                  field.back: {
                    'equals': double.tryParse(value) ?? 0,
                  }
                },
              ],
            }
          };

          return state;
        });
      }
    }
  }
}
