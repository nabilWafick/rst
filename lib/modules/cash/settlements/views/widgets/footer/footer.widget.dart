import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/utils/utils.dart';

class SettlementsPageFooter extends ConsumerWidget {
  const SettlementsPageFooter({super.key});

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
                    authPermissions[PermissionsValues.showSettlementsMoreInfos]
                ? Row(
                    children: [
                      const RSTText(
                        text: 'Total: ',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final count = ref.watch(settlementsCountProvider);

                          return RSTText(
                            text: count.when(
                              data: (data) => data != 1
                                  ? '$data règlements'
                                  : '$data règlement',
                              error: (error, stackTrace) {
                                return ' règlements';
                              },
                              loading: () => ' règlements',
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
                final count = ref.watch(specificSettlementsCountProvider);
                return count.when(
                  data: (data) {
                    return Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final settlementsListParameters =
                                ref.watch(settlementsListParametersProvider);

                            return settlementsListParameters['skip'] != 0
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              settlementsListParametersProvider
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
                            final settlementsListParameters =
                                ref.watch(settlementsListParametersProvider);
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: RSTText(
                                text: data != 0
                                    ? '${((settlementsListParameters['skip'] + 15) / 15).toInt()}'
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
                            final settlementsListParameters =
                                ref.watch(settlementsListParametersProvider);

                            return settlementsListParameters['skip'] + 15 < data
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              settlementsListParametersProvider
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
            authPermissions[PermissionsValues.admin] ||
                    authPermissions[PermissionsValues.showSettlementsMoreInfos]
                ? Row(
                    children: [
                      Consumer(
                        builder: (context, ref, child) {
                          final settlementsListParameters =
                              ref.watch(settlementsListParametersProvider);
                          final settlementList =
                              ref.watch(settlementsListStreamProvider);
                          return RSTText(
                            text: settlementList.when(
                              data: (data) => data.isNotEmpty
                                  ? '${settlementsListParameters['skip'] + 1}'
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
                          final settlementsListParameters =
                              ref.watch(settlementsListParametersProvider);
                          final settlementList =
                              ref.watch(settlementsListStreamProvider);
                          return RSTText(
                            text: settlementList.when(
                              data: (data) =>
                                  '${settlementsListParameters['skip'] + data.length}',
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
                              ref.watch(specificSettlementsCountProvider);

                          return RSTText(
                            text: count.when(
                              data: (data) => data != 1
                                  ? '$data règlements'
                                  : '$data règlement',
                              error: (error, stackTrace) => ' règlements',
                              loading: () => ' règlements',
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
