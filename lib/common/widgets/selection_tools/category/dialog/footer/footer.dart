import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/category/providers/selection.provider.dart';
import 'package:rst/utils/utils.dart';

class CategorySelectionDialogFooter extends ConsumerWidget {
  const CategorySelectionDialogFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      width: double.maxFinite,
      height: 50.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 1.0,
            ),
            Consumer(
              builder: (context, ref, child) {
                final count =
                    ref.watch(specificcategoriesSelectionCountProvider);
                return count.when(
                  data: (data) {
                    return Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final categoriesSelectionListParameters = ref.watch(
                                categoriesSelectionListParametersProvider);

                            return categoriesSelectionListParameters['skip'] !=
                                    0
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              categoriesSelectionListParametersProvider
                                                  .notifier)
                                          .update((state) {
                                        // decrease the pagination
                                        state = {
                                          ...state,
                                          'skip': state['skip'] -= 15,
                                        };

                                        return state;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back_ios_rounded,
                                      size: 20.0,
                                      color: RSTColors.primaryColor,
                                      //  color: Colors.grey.shade700,
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final categoriesSelectionListParameters = ref.watch(
                                categoriesSelectionListParametersProvider);
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: RSTText(
                                text: data != 0
                                    ? '${((categoriesSelectionListParameters['skip'] + 15) / 15).toInt()}'
                                    : '0',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: RSTColors.primaryColor,
                              ),
                            );
                          },
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final categoriesSelectionListParameters = ref.watch(
                                categoriesSelectionListParametersProvider);

                            return categoriesSelectionListParameters['skip'] +
                                        15 <
                                    data
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              categoriesSelectionListParametersProvider
                                                  .notifier)
                                          .update((state) {
                                        // increase the pagination
                                        state = {
                                          ...state,
                                          'skip': state['skip'] += 15,
                                        };

                                        return state;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20.0,
                                      color: RSTColors.primaryColor,
                                      //   color: Colors.grey.shade700,
                                    ),
                                  )
                                : const SizedBox();
                          },
                        ),
                      ],
                    );
                  },
                  error: (error, stackTrace) {
                    debugPrint(error.toString());
                    return const SizedBox();
                  },
                  loading: () => const SizedBox(),
                );
              },
            ),
            Row(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final categoriesSelectionListParameters =
                        ref.watch(categoriesSelectionListParametersProvider);
                    final categoriesSelectionList =
                        ref.watch(categoriesSelectionListStreamProvider);
                    return RSTText(
                      text: categoriesSelectionList.when(
                        data: (data) => data.isNotEmpty
                            ? '${categoriesSelectionListParameters['skip'] + 1}'
                            : '0',
                        error: (error, stackTrace) => '',
                        loading: () => '',
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    );
                  },
                ),
                const RSTText(
                  text: ' - ',
                  fontSize: 10.0,
                  fontWeight: FontWeight.w400,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final categoriesSelectionListParameters =
                        ref.watch(categoriesSelectionListParametersProvider);
                    final categoriesSelectionList =
                        ref.watch(categoriesSelectionListStreamProvider);
                    return RSTText(
                      text: categoriesSelectionList.when(
                        data: (data) =>
                            '${categoriesSelectionListParameters['skip'] + data.length}',
                        error: (error, stackTrace) => '',
                        loading: () => '',
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    );
                  },
                ),
                const RSTText(
                  text: ' sur ',
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final count =
                        ref.watch(specificcategoriesSelectionCountProvider);

                    return RSTText(
                      text: count.when(
                          data: (data) =>
                              data != 1 ? '$data produits' : '$data produit',
                          error: (error, stackTrace) => ' produits',
                          loading: () => ' produits'),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
