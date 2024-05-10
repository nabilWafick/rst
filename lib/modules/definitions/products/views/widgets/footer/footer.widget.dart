import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';

class ProductsPageFooter extends ConsumerWidget {
  const ProductsPageFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
            color: Colors.grey,
          ),
        ),
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
                    final count = ref.watch(productsCountProvider);

                    return RSTText(
                      text: count.when(
                          data: (data) =>
                              data != 1 ? '$data produits' : '$data produit',
                          error: (error, stackTrace) {
                            return ' produits';
                          },
                          loading: () => ' produits'),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    );
                  },
                ),
              ],
            ),
            Consumer(
              builder: (context, ref, child) {
                final count = ref.watch(productsCountProvider);
                return count.when(
                  data: (data) => Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          ref
                              .read(productsFilterOptionsProvider.notifier)
                              .update((state) {
                            // do anything if it the first list of product
                            if (state['skip'] == 0) {
                              return state;
                            }

                            // decrease the pagination
                            state = {
                              ...state,
                              'skip': state['skip'] -= 25,
                            };

                            return state;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 20.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final productsFilterOptions =
                              ref.watch(productsFilterOptionsProvider);
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 30.0,
                            ),
                            child: RSTText(
                              text:
                                  '${((productsFilterOptions['skip'] + 25) / 25).toInt()}',
                              fontSize: 15.0,
                              fontWeight: FontWeight.w700,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        onPressed: () {
                          ref
                              .read(productsFilterOptionsProvider.notifier)
                              .update((state) {
                            // should do nothing if the last products
                            // have been getted or if the skip >= products count
                            if (state['skip'] >= data) {
                              return state;
                            }

                            // increase the pagination
                            state = {
                              ...state,
                              'skip': state['skip'] += 25,
                            };

                            return state;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 20.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  error: (error, stackTrace) => const SizedBox(),
                  loading: () => const SizedBox(),
                );
              },
            ),
            Row(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final productsFilterOptions =
                        ref.watch(productsFilterOptionsProvider);
                    final productList = ref.watch(productsListStreamProvider);
                    return RSTText(
                      text: productList.when(
                        data: (data) => '${productsFilterOptions['skip'] + 1}',
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
                    final productsFilterOptions =
                        ref.watch(productsFilterOptionsProvider);
                    final productList = ref.watch(productsListStreamProvider);
                    return RSTText(
                      text: productList.when(
                        data: (data) =>
                            '${productsFilterOptions['skip'] + data.length}',
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
                    final count = ref.watch(specificProductsCountProvider);

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
