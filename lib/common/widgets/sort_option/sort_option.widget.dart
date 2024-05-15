import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class SortOption extends ConsumerWidget {
  final Field field;
  final StateProvider<Map<String, dynamic>> filterOptionsProvider;
  const SortOption({
    super.key,
    required this.field,
    required this.filterOptionsProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: RSTColors.primaryColor.withOpacity(.1),
      margin: const EdgeInsets.only(
        right: 8.0,
        bottom: 8.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          final filterOptions = ref.read(filterOptionsProvider);

          // if there is a sort option
          // add a new sort option
          if (!filterOptions.containsKey('orderBy')) {
            // add
            ref.read(filterOptionsProvider.notifier).update(
              (state) {
                state = {
                  ...state,
                  "orderBy": [
                    {
                      field.back: 'asc',
                    },
                  ]
                };

                return state;
              },
            );
          } else {
            // there is any sort option before
            // add sort option
            ref.read(filterOptionsProvider.notifier).update(
              (state) {
                List<Map<String, String>> sortConditions = state['orderBy'];
                state = {
                  ...state,
                  "orderBy": [
                    ...sortConditions,
                    {
                      field.back: 'asc',
                    },
                  ]
                };
                return state;
              },
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10.0,
            horizontal: 15.0,
          ),
          child: RSTText(
            text: field.front,
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
