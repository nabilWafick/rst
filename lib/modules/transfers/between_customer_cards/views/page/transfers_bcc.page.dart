import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/transfers/between_customer_cards/views/widgets/transfers_bcc.widget.dart';

class TransfersBCCPage extends ConsumerWidget {
  const TransfersBCCPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        TransfersBCCPageBody(),
      ],
    );
  }
}
