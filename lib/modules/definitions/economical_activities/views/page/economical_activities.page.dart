import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/economical_activities/views/widgets/economical_activities.widget.dart';

class EconomicalActivitiesPage extends ConsumerWidget {
  const EconomicalActivitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        EconomicalActivitiesPageHeader(),
        EconomicalActivitiesPageBody(),
        EconomicalActivitiesPageFooter()
      ],
    );
  }
}
