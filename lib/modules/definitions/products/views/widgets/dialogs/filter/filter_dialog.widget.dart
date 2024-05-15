// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class ProductFilterDialog extends HookConsumerWidget {
  const ProductFilterDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;

    final productFilterOptions = ref.watch(productsFilterOptionsProvider);

    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Filtre',
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close_rounded,
              color: RSTColors.primaryColor,
              size: 30.0,
            ),
          ),
        ],
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),

        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 280.0,
                minHeight: .0,
              ),
              child: productFilterOptions.containsKey('orderBy')
                  ? Consumer(
                      builder: (context, ref, child) {
                        List<Map<String, String>> sortConditions =
                            productFilterOptions['orderBy'];
                        return SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: sortConditions
                                .map(
                                  (sortOption) => SortOptionTool(
                                    sortOption: sortOption,
                                    filterOptionsProvider:
                                        productsFilterOptionsProvider,
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      },
                    )
                  : const SizedBox(),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(
                top: 15.0,
                bottom: 10.0,
              ),
              child: InkWell(
                onTap: () {},
                splashColor: RSTColors.primaryColor.withOpacity(.15),
                hoverColor: RSTColors.primaryColor.withOpacity(.1),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RSTText(
                        text: 'Ajouter un filtre',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Icon(
                        Icons.add_circle_outline_rounded,
                        color: RSTColors.primaryColor,
                        size: 25.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            productFilterOptions['where']?.isNotEmpty ?? false
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Réinitialiser',
                      backgroundColor: RSTColors.primaryColor,
                      onPressed: () {
                        // remove the sort option
                        ref.read(productsFilterOptionsProvider.notifier).update(
                          (state) {
                            Map<String, dynamic> newState = {};

                            for (MapEntry<String, dynamic> entry
                                in state.entries) {
                              if (entry.key != 'where ') {
                                newState[entry.key] = entry.value;
                              }
                            }

                            state = newState;

                            return state;
                          },
                        );
                      },
                    ),
                  )
                : const SizedBox(),
            const SizedBox(
              width: 20.0,
            ),
            SizedBox(
              width: 170.0,
              child: RSTElevatedButton(
                text: 'Valider',
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
