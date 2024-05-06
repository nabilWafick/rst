import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/widgets/text/text.widget.dart';

class RSTElevatedButton extends ConsumerWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final Function() onPressed;

  const RSTElevatedButton({
    super.key,
    required this.text,
    this.textColor,
    this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          /* shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(.0),),*/
          //   elevation: 5.0,
          backgroundColor: backgroundColor,
          // minimumSize: const Size(50.0, 45.0),
        ),
        child: RSTText(
          text: text,
          textAlign: TextAlign.center,
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}
