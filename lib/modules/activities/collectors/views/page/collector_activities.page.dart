import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/activities/collectors/views/widgets/collector_activities.widget.dart';

class CollectorActivitiesPage extends ConsumerWidget {
  const CollectorActivitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CollectorsActivitiesPageHeader(),
        CollectorsActivitiesPageBody(),
        CollectorsActivitiesPageFooter(),
      ],
    );
  }
}
