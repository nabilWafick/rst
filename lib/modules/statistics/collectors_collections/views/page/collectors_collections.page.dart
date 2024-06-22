import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/statistics/collectors_collections/views/widgets/collectors_collections.widget.dart';

class CollectorsCollectionsPage extends ConsumerWidget {
  const CollectorsCollectionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CollectorsCollectionsPageHeader(),
        CollectorsCollectionsPageBody(),
        CollectorsCollectionsPageFooter(),
      ],
    );
  }
}
