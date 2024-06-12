import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/activities/customer/views/widgets/body/body.widget.dart';
import 'package:rst/modules/activities/customer/views/widgets/header/header.widget.dart';
import 'package:rst/modules/activities/customer/views/widgets/settlements/settlements.widget.dart';

class CustomerActivitiesPage extends ConsumerWidget {
  const CustomerActivitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CustomerActivitiesPageHeader(),
        CustomerActivitiesPageBody(),
        CustomerActivitiesSettlements()
      ],
    );
  }
}
