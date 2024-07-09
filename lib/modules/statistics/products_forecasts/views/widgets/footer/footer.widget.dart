import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/statistics/products_forecasts/providers/products_forecasts.provider.dart';
import 'package:rst/utils/utils.dart';

class ProductsForecastsPageFooter extends ConsumerWidget {
  const ProductsForecastsPageFooter({super.key});

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
                    final count = ref.watch(productsForecastsCountProvider);

                    return RSTText(
                      text: count.when(
                        data: (data) =>
                            data != 1 ? '$data produits' : '$data produit',
                        error: (error, stackTrace) {
                          return ' produits';
                        },
                        loading: () => ' produits',
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                const RSTText(
                  text: 'Montant: ',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final count =
                        ref.watch(productsForecastsTotalAmountProvider);

                    return RSTText(
                      text: count.when(
                        data: (data) => '${data}f',
                        error: (error, stackTrace) {
                          return ' f';
                        },
                        loading: () => ' f',
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
                final count = ref.watch(specificProductsForecastsCountProvider);
                return count.when(
                  data: (data) {
                    return Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final productsForecastsListParameters = ref
                                .watch(productsForecastsListParametersProvider);

                            return productsForecastsListParameters.offset != 0
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              productsForecastsListParametersProvider
                                                  .notifier)
                                          .update((state) {
                                        // decrease the pagination
                                        state = state.copyWith(
                                          offset: state.offset - 20,
                                        );

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
                            final productsForecastsListParameters = ref
                                .watch(productsForecastsListParametersProvider);
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: RSTText(
                                text: data != 0
                                    ? '${(productsForecastsListParameters.offset + 20) ~/ 20}'
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
                            final productsForecastsListParameters = ref
                                .watch(productsForecastsListParametersProvider);

                            return productsForecastsListParameters.offset + 20 <
                                    data
                                ? IconButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                              productsForecastsListParametersProvider
                                                  .notifier)
                                          .update((state) {
                                        // increase the pagination
                                        state = state.copyWith(
                                          offset: state.offset + 20,
                                        );

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
                const RSTText(
                  text: 'Montant: ',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final count =
                        ref.watch(specificProductsForecastsAmountProvider);

                    return RSTText(
                      text: count.when(
                        data: (data) => '${data}f',
                        error: (error, stackTrace) {
                          return ' f';
                        },
                        loading: () => ' f',
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final productsForecastsListParameters =
                        ref.watch(productsForecastsListParametersProvider);
                    final typeList =
                        ref.watch(productsForecastsListStreamProvider);
                    return RSTText(
                      text: typeList.when(
                        data: (data) => data.isNotEmpty
                            ? '${productsForecastsListParameters.offset + 1}'
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
                    final productsForecastsListParameters =
                        ref.watch(productsForecastsListParametersProvider);
                    final typeList =
                        ref.watch(productsForecastsListStreamProvider);
                    return RSTText(
                      text: typeList.when(
                        data: (data) =>
                            '${productsForecastsListParameters.offset + data.length}',
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
                        ref.watch(specificProductsForecastsCountProvider);

                    return RSTText(
                      text: count.when(
                        data: (data) =>
                            data != 1 ? '$data produits' : '$data produit',
                        error: (error, stackTrace) => ' produits',
                        loading: () => ' produits',
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
