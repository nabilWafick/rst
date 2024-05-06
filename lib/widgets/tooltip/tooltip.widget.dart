import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/widgets/text/text.widget.dart';
import 'package:super_tooltip/super_tooltip.dart';

class RSTToolTip extends StatefulHookConsumerWidget {
  final List<Widget> options;
  const RSTToolTip({
    super.key,
    required this.options,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSTToolTipState();
}

class _RSTToolTipState extends ConsumerState<RSTToolTip> {
  @override
  Widget build(BuildContext context) {
    return SuperTooltip(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            width: 120.0,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.close,
                  size: 20.0,
                  //  color: RSTColors.sidebarTextColor,
                  color: RSTColors.primaryColor,
                ),

                /*  RSTText(
                  text: 'Fermer',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),*/
              ],
            ),
          ),
          ...widget.options,
        ],
      ),
      hideTooltipOnTap: true,
      arrowLength: 10,
      showBarrier: false,
      borderColor: Colors.transparent,
      //RSTColors.primaryColor,
      // shadowColor: RSTColors.primaryColor,
      shadowBlurRadius: 1,
      shadowSpreadRadius: .5,
      elevation: 10.0,
      arrowTipDistance: 10,
      popupDirection: TooltipDirection.right,
      child: const Icon(
        Icons.more_vert,
        color: RSTColors.primaryColor,
      ),
    );
  }
}

class RSTToolTipOption extends ConsumerWidget {
  final IconData icon;
  final Color iconColor;
  final String name;
  final Function() onTap;
  const RSTToolTipOption({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 7.0,
        ),
        width: 120.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size: 20.0,
              color: iconColor,
            ),
            const SizedBox(
              width: 10.0,
            ),
            RSTText(
              text: name,
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
