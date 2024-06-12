import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/stocks/stocks/views/widgets/stocks.widget.dart';

class StocksPage extends ConsumerWidget {
  const StocksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        StocksPageHeader(),
        StocksPageBody(),
        StocksPageFooter(),
      ],
    );
  }
}
