import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class SortParameter extends ConsumerWidget {
  final Field field;
  final StateProvider<Map<String, dynamic>> listParametersProvider;
  const SortParameter({
    super.key,
    required this.field,
    required this.listParametersProvider,
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
          final listParameters = ref.watch(listParametersProvider);

          // if there is a sort option
          // add a new sort option
          if (!listParameters.containsKey('orderBy')) {
            // add
            ref.read(listParametersProvider.notifier).update(
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
            ref.read(listParametersProvider.notifier).update(
              (state) {
                List<Map<String, String>> sortParameters = state['orderBy'];
                state = {
                  ...state,
                  "orderBy": [
                    ...sortParameters,
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
