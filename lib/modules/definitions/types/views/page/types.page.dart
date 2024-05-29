import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/types/views/widgets/types.widget.dart';

class TypesPage extends ConsumerWidget {
  const TypesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        TypesPageHeader(),
        TypesPageBody(),
        TypesPageFooter(),
      ],
    );
  }
}
