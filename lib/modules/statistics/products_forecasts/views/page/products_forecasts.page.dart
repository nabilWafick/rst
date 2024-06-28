import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/statistics/products_forecasts/views/widgets/products_forecasts.widget.dart';

class ProductsForecastsPage extends ConsumerWidget {
  const ProductsForecastsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        ProductsForecastsPageHeader(),
        ProductsForecastsPageBody(),
        ProductsForecastsPageFooter(),
      ],
    );
  }
}
