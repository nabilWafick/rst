import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/statistics/types_stat/views/widgets/types_stat.widget.dart';

class TypesStatsPage extends ConsumerWidget {
  const TypesStatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        TypesStatsPageHeader(),
        TypesStatsPageBody(),
        TypesStatsPageFooter(),
      ],
    );
  }
}
