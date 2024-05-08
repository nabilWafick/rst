import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

class RSTIconButton extends ConsumerWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const RSTIconButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(
          //   vertical: 10.0,
          ),
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 5.0,
          color: RSTColors.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                icon,
                color: RSTColors.backgroundColor,
              ),
              const SizedBox(
                width: 15.0,
              ),
              RSTText(
                text: text,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: RSTColors.backgroundColor,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
