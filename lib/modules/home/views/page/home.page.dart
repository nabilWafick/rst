import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/home/views/widgets/main/main.widget.dart';
import 'package:rst/modules/home/views/widgets/sidebar/sidebar.widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Main(),
        ],
      ),
    );
  }
}
