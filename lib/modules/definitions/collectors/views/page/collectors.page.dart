import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/collectors/views/widgets/collectors.widget.dart';

class CollectorsPage extends ConsumerWidget {
  const CollectorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CollectorsPageHeader(),
        CollectorsPageBody(),
        CollectorsPageFooter(),
      ],
    );
  }
}
