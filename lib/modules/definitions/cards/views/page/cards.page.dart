import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/cards/views/widgets/cards.widget.dart';

class CardsPage extends ConsumerWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        CardsPageHeader(),
        CardsPageBody(),
        CardsPageFooter(),
      ],
    );
  }
}
