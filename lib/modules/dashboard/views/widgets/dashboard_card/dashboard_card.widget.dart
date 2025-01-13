import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class DashboardCard extends HookWidget {
  final String label;
  final num value;
  final bool ceil;
  final String? period;
  final bool? isVisible;

  const DashboardCard(
      {super.key,
      required this.label,
      required this.value,
      required this.ceil,
      this.period,
      this.isVisible = true});
  @override
  Widget build(BuildContext context) {
    final showData = useState(isVisible ?? true);
    return Stack(
      children: [
        InkWell(
          onTap: () {
            showData.value = !showData.value;
          },
          child: Container(
            decoration: BoxDecoration(
              color: RSTColors.sidebarTextColor.withOpacity(.3),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(
              // vertical: 20.0,
              horizontal: 20.0,
            ),
            height: 170.0,
            width: 250.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Tooltip(
                  message: showData.value ? value.toString() : '',
                  height: 25,
                  child: RSTText(
                    text: showData.value
                        ? FunctionsController.formatLargeNumber(
                            number: value,
                            ceil: ceil,
                          )
                        : '',
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                RSTText(
                  text: label,
                  fontSize: 12.5,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: RSTText(
            text: period ?? "",
            fontSize: 10.0,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}
