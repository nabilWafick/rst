import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

class RSTAddButton extends ConsumerWidget {
  final Function() onTap;
  const RSTAddButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: InkWell(
        onTap: onTap,
        child: const Card(
          elevation: 5.0,
          color: RSTColors.primaryColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(
                Icons.add_circle_outline,
                color: RSTColors.backgroundColor,
              ),
              SizedBox(
                width: 15.0,
              ),
              RSTText(
                text: 'Ajouter',
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
