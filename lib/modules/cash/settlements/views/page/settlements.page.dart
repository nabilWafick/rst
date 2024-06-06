import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/settlements/views/widgets/settlements.widget.dart';

class SettlementsPage extends ConsumerWidget {
  const SettlementsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        SettlementsPageHeader(),
        SettlementsPageBody(),
        SettlementsPageFooter(),
      ],
    );
  }
}
