import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/statistics/products_improvidence/views/widgets/body/body.widget.dart';
import 'package:rst/modules/statistics/products_improvidence/views/widgets/footer/footer.widget.dart';
import 'package:rst/modules/statistics/products_improvidence/views/widgets/header/header.widget.dart';

class ProductsImprovidencePage extends ConsumerWidget {
  const ProductsImprovidencePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        ProductsImprovidencePageHeader(),
        ProductsImprovidencePageBody(),
        ProductsImprovidencePageFooter(),
      ],
    );
  }
}
