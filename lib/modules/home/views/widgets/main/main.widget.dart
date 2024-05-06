import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/home/views/widgets/main/appbar/appbar.widget.dart';
import 'package:rst/modules/home/views/widgets/main/body/body.widget.dart';

class Main extends ConsumerStatefulWidget {
  const Main({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainState();
}

class _MainState extends ConsumerState<Main> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
      ),
      width: MediaQuery.of(context).size.width * 7 / 8,
      child: const Column(
        children: [
          MainAppbar(),
          MainBody(),
        ],
      ),
    );
  }
}
