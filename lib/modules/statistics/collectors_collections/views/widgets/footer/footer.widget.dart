import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/definitions/collectors/providers/collectors.provider.dart';
import 'package:rst/modules/statistics/collectors_collections/providers/collectors_collections.provider.dart';
import 'package:rst/utils/utils.dart';

class CollectorsCollectionsPageFooter extends ConsumerWidget {
  const CollectorsCollectionsPageFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: RSTColors.backgroundColor,
      ),
      width: double.maxFinite,
      height: 50.0,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const RSTText(
                  text: 'Total: ',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final count = ref.watch(collectorsCountProvider);

                    return RSTText(
                      text: count.when(
                        data: (data) => data != 1
                            ? '$data collecteurs'
                            : '$data collecteur',
                        error: (error, stackTrace) {
                          return ' collecteurs';
                        },
                        loading: () => ' collecteurs',
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    );
                  },
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                final count =
                    ref.watch(specificCollectorsCollectionsCountProvider);
                return count.when(
                  data: (data) {
                    return Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final collectorsCollectionsListParameters =
                                ref.watch(
                                    collectorsCollectionsListParametersProvider);

                            return collectorsCollectionsListParameters[
                                        'skip'] !=
                                    0
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              collectorsCollectionsListParametersProvider
                                                  .notifier)
                                          .update((state) {
                                        // decrease the pagination
                                        state = {
                                          ...state,
                                          'skip': state['skip'] -= 20,
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
                            final collectorsCollectionsListParameters =
                                ref.watch(
                                    collectorsCollectionsListParametersProvider);
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: RSTText(
                                text: data != 0
                                    ? '${((collectorsCollectionsListParameters['skip'] + 20) / 20).toInt()}'
                                    : '0',
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: RSTColors.primaryColor,
                              ),
                            );
                          },
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final collectorsCollectionsListParameters =
                                ref.watch(
                                    collectorsCollectionsListParametersProvider);

                            return collectorsCollectionsListParameters['skip'] +
                                        20 <
                                    data
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              collectorsCollectionsListParametersProvider
                                                  .notifier)
                                          .update((state) {
                                        // increase the pagination
                                        state = {
                                          ...state,
                                          'skip': state['skip'] += 20,
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
                    final collectorsCollectionsListParameters =
                        ref.watch(collectorsCollectionsListParametersProvider);
                    final typeList =
                        ref.watch(collectorsCollectionsListStreamProvider);
                    return RSTText(
                      text: typeList.when(
                        data: (data) => data.isNotEmpty
                            ? '${collectorsCollectionsListParameters['skip'] + 1}'
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
                    final collectorsCollectionsListParameters =
                        ref.watch(collectorsCollectionsListParametersProvider);
                    final typeList =
                        ref.watch(collectorsCollectionsListStreamProvider);
                    return RSTText(
                      text: typeList.when(
                        data: (data) =>
                            '${collectorsCollectionsListParameters['skip'] + data.length}',
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
                    final count = ref.watch(specificCollectorsCountProvider);

                    return RSTText(
                      text: count.when(
                        data: (data) => data != 1
                            ? '$data collecteurs'
                            : '$data collecteur',
                        error: (error, stackTrace) => ' collecteurs',
                        loading: () => ' collecteurs',
                      ),
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
