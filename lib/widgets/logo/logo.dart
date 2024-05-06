import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/widgets/text/text.widget.dart';

class RSTLogo extends ConsumerWidget {
  final double fontSize;
  final Color bankColor;
  const RSTLogo({
    super.key,
    required this.fontSize,
    required this.bankColor,
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
      child: Wrap(
        runSpacing: 5.0,
        spacing: .0,
        children: [
          RSTText(
            text: 'Community',
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: RSTColors.primaryColor,
          ),
          const SizedBox(
            width: 10.0,
          ),
          RSTText(
            text: 'Bank',
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: bankColor,
          ),
        ],
      ),
    );
  }
}
