import 'package:flutter/material.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

class RSTOutlinedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function() onPressed;

  const RSTOutlinedButton(
      {super.key,
      required this.text,
      required this.textColor,
      required this.backgroundColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(.0),
          side: const BorderSide(width: 1.5, color: RSTColors.primaryColor),
        ),
        color: Colors.white,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(.0),
              side: const BorderSide(width: .0, color: RSTColors.primaryColor),
            ),
            //elevation: 2.0,
            // backgroundColor: backgroundColor,
            //  minimumSize: const Size(double.maxFinite, 45.0)
          ),
          child: RSTText(
              text: text,
              textAlign: TextAlign.center,
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
              color: textColor),
        ),
      ),
    );
  }
}
