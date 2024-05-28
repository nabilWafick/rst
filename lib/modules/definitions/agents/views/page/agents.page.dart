import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/agents/views/widgets/agents.widget.dart';

class AgentsPage extends ConsumerWidget {
  const AgentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        AgentsPageHeader(),
        AgentsPageBody(),
        AgentsPageFooter(),
      ],
    );
  }
}
