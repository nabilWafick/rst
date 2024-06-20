import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

class RSTLogo extends ConsumerWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const RSTLogo({
    super.key,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  final pageController = ref.watch(pageControllerProvider);

    return InkWell(
      /*  onTap: () {
        // ref.read(currentPageIndexProvider.notifier).state = 0;
        /* pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeIn,
        );*/
      },
      */
      child: Center(
        child: RSTText(
          text: 'R S T',
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
      ),
    );
  }
}
