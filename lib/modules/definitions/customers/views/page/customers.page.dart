import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/customers/views/widgets/customers.widget.dart';

class CustomersPage extends ConsumerWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CustomersPageHeader(),
        CustomersPageBody(),
        CustomersPageFooter(),
      ],
    );
  }
}
