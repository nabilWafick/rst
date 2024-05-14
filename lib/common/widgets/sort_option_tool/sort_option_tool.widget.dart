import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class SortOptionTool extends HookConsumerWidget {
  final Map<String, String> sortOption;
  final StateProvider<Map<String, dynamic>> filterOptionsProvider;
  const SortOptionTool({
    super.key,
    required this.sortOption,
    required this.filterOptionsProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showWidget = useState<bool>(true);

    // get the field of the sort option
    final field = ProductStructure.fields.firstWhere(
      (field) {
        // get first  due to {..., 'nulls':'last'}
        return field.back == sortOption.entries.first.key;
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
                  text: field.front,
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
                      value: sortOption[field.back] == 'asc',
                      onChanged: (value) {
                        ref.read(filterOptionsProvider.notifier).update(
                          (state) {
                            // get th index of the sort option in the list
                            final index = state['orderBy'].indexOf(sortOption);

                            // update the sort method
                            state['orderBy'][index][field.back] =
                                value ? 'asc' : 'desc';

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
                ref
                    .read(
                  filterOptionsProvider.notifier,
                )
                    .update(
                  (state) {
                    // get th index of the sort option in the list
                    final index = state['orderBy'].indexOf(sortOption);

                    // remove the sort option
                    state['orderBy'].removeAt(index);

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
