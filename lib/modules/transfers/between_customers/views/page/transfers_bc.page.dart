import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/transfers/between_customers/views/widgets/body/body.widget.dart';

class TransfersBCPage extends ConsumerWidget {
  const TransfersBCPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TransfersBCPageBody(),
      ],
    );
  }
}
