import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/type/providers/selection.provider.dart';
import 'package:rst/utils/utils.dart';

class TypeSelectionDialogFooter extends ConsumerWidget {
  final String toolName;
  const TypeSelectionDialogFooter({
    super.key,
    required this.toolName,
  });

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
                    ref.watch(specificTypesSelectionCountProvider(toolName));
                return count.when(
                  data: (data) {
                    return Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final typesSelectionListParameters = ref.watch(
                                typesSelectionListParametersProvider(toolName));

                            return typesSelectionListParameters['skip'] != 0
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              typesSelectionListParametersProvider(
                                                      toolName)
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
                            final typesSelectionListParameters = ref.watch(
                                typesSelectionListParametersProvider(toolName));
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: RSTText(
                                text: data != 0
                                    ? '${((typesSelectionListParameters['skip'] + 15) / 15).toInt()}'
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
                            final typesSelectionListParameters = ref.watch(
                                typesSelectionListParametersProvider(toolName));

                            return typesSelectionListParameters['skip'] + 15 <
                                    data
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              typesSelectionListParametersProvider(
                                                      toolName)
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
                    final typesSelectionListParameters = ref
                        .watch(typesSelectionListParametersProvider(toolName));
                    final typesSelectionList =
                        ref.watch(typesSelectionListStreamProvider(toolName));
                    return RSTText(
                      text: typesSelectionList.when(
                        data: (data) => data.isNotEmpty
                            ? '${typesSelectionListParameters['skip'] + 1}'
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
                    final typesSelectionListParameters = ref
                        .watch(typesSelectionListParametersProvider(toolName));
                    final typesSelectionList =
                        ref.watch(typesSelectionListStreamProvider(toolName));
                    return RSTText(
                      text: typesSelectionList.when(
                        data: (data) =>
                            '${typesSelectionListParameters['skip'] + data.length}',
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
                    final count = ref
                        .watch(specificTypesSelectionCountProvider(toolName));

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
