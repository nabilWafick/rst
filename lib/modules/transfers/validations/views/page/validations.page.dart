import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/transfers/validations/views/widgets/validations.widget.dart';

class TransfersValidationPage extends ConsumerWidget {
  const TransfersValidationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        TransfersValidationPageHeader(),
        TransfersValidationPageBody(),
        TransfersValidationPageFooter(),
      ],
    );
  }
}
