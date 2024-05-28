import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/personal_status/views/widgets/personal_status.widget.dart';

class PersonalStatusPage extends ConsumerWidget {
  const PersonalStatusPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        PersonalStatusPageHeader(),
        PersonalStatusPageBody(),
        PersonalStatusPageFooter()
      ],
    );
  }
}
