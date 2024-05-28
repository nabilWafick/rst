import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/categories/views/widgets/categories.widget.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CategoriesPageHeader(),
        CategoriesPageBody(),
        CategoriesPageFooter()
      ],
    );
  }
}
