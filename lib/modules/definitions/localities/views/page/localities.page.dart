import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/localities/views/widgets/localities.widget.dart';

class LocalitiesPage extends ConsumerWidget {
  const LocalitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        LocalitiesPageHeader(),
        LocalitiesPageBody(),
        LocalitiesPageFooter()
      ],
    );
  }
}
