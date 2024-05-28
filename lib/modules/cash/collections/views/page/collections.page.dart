import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/collections/views/widgets/collections.widget.dart';

class CollectionsPage extends ConsumerWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CollectionsPageHeader(),
        CollectionsPageBody(),
        CollectionsPageFooter(),
      ],
    );
  }
}
