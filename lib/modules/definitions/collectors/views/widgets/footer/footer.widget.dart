import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/collectors/providers/collectors.provider.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/utils/utils.dart';

class CollectorsPageFooter extends ConsumerWidget {
  const CollectorsPageFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authPermissions = ref.watch(authPermissionsProvider);
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
            authPermissions![PermissionsValues.admin] ||
                    authPermissions[PermissionsValues.showCollectorsActivities]
                ? Row(
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
                  )
                : const SizedBox(),
            Consumer(
              builder: (context, ref, child) {
                final count = ref.watch(specificCollectorsCountProvider);
                return count.when(
                  data: (data) {
                    return Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final collectorsListParameters =
                                ref.watch(collectorsListParametersProvider);

                            return collectorsListParameters['skip'] != 0
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(collectorsListParametersProvider
                                              .notifier)
                                          .update((state) {
                                        // decrease the pagination
                                        state = {
                                          ...state,
                                          'skip': state['skip'] -= 25,
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
                            final collectorsListParameters =
                                ref.watch(collectorsListParametersProvider);
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: RSTText(
                                text: data != 0
                                    ? '${((collectorsListParameters['skip'] + 25) / 25).toInt()}'
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
                            final collectorsListParameters =
                                ref.watch(collectorsListParametersProvider);

                            return collectorsListParameters['skip'] + 25 < data
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(collectorsListParametersProvider
                                              .notifier)
                                          .update((state) {
                                        // increase the pagination
                                        state = {
                                          ...state,
                                          'skip': state['skip'] += 25,
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
            authPermissions[PermissionsValues.admin] ||
                    authPermissions[PermissionsValues.showCollectorsMoreInfos]
                ? Row(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final collectorsListParameters =
                              ref.watch(collectorsListParametersProvider);
                          final collectorList =
                              ref.watch(collectorsListStreamProvider);
                          return RSTText(
                            text: collectorList.when(
                              data: (data) => data.isNotEmpty
                                  ? '${collectorsListParameters['skip'] + 1}'
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
                          final collectorsListParameters =
                              ref.watch(collectorsListParametersProvider);
                          final collectorList =
                              ref.watch(collectorsListStreamProvider);
                          return RSTText(
                            text: collectorList.when(
                              data: (data) =>
                                  '${collectorsListParameters['skip'] + data.length}',
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
                              ref.watch(specificCollectorsCountProvider);

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
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
