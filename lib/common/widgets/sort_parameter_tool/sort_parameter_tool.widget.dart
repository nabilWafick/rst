import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class SortParameterTool extends HookConsumerWidget {
  final Map<String, String> sortParameter;
  final StateProvider<Map<String, dynamic>> listParametersProvider;
  const SortParameterTool({
    super.key,
    required this.sortParameter,
    required this.listParametersProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showWidget = useState<bool>(true);

    // get the field of the sort option
    final field = ProductStructure.fields.firstWhere(
      (field) {
        return field.back == sortParameter.entries.first.key;
      },
    );
    return showWidget.value
        ? ListTile(
            leading: const Icon(
              Icons.format_list_bulleted_sharp,
              color: RSTColors.primaryColor,
              size: 20,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RSTText(
                  text: FunctionsController.truncateText(
                    text: field.front,
                    maxLength: 15,
                  ),
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
                Row(
                  children: [
                    const RSTText(
                      text: 'ascendant:',
                      fontSize: 12.0,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Switch(
                      value: sortParameter[field.back] == 'asc',
                      onChanged: (value) {
                        ref.read(listParametersProvider.notifier).update(
                          (state) {
                            // get th index of the sort option in the list
                            final index =
                                state['orderBy'].indexOf(sortParameter);

                            // update the sort method
                            state['orderBy'][index][field.back] =
                                value ? 'asc' : 'desc';

                            state = {
                              ...state,
                              'orderBy': state['orderBy'],
                            };

                            return state;
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                // remove the sort option
                ref.read(listParametersProvider.notifier).update(
                  (state) {
                    if (state['orderBy'].length > 1) {
                      // get th index of the sort option in the list
                      final index = state['orderBy'].indexOf(sortParameter);

                      // remove the sort option
                      state['orderBy'].removeAt(index);

                      state = {
                        ...state,
                        'orderBy': state['orderBy'],
                      };
                    } else {
                      Map<String, dynamic> newState = {};

                      for (MapEntry<String, dynamic> entry in state.entries) {
                        if (entry.key != 'orderBy') {
                          newState[entry.key] = entry.value;
                        }
                      }
                      state = newState;
                    }
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
          )
        : const SizedBox();
  }
}
