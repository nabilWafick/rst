import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/home/models/sidebar_option.model.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/widgets/text/text.widget.dart';

class SidebarOption extends ConsumerWidget {
  final SidebarOptionModel sidebarOptionData;

  const SidebarOption({
    super.key,
    required this.sidebarOptionData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSidebarOption = ref.watch(selectedSidebarOptionProvider);
    return InkWell(
      onTap: () {
        ref.read(selectedSidebarOptionProvider.notifier).state =
            sidebarOptionData;
        ref.read(selectedSidebarSubOptionProvider.notifier).state =
            sidebarOptionData.subOptions[0];
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        padding: const EdgeInsets.symmetric(
          // vertical: 5.0,
          horizontal: 20.0,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            left: BorderSide(
              width: selectedSidebarOption.name == sidebarOptionData.name
                  ? 5.0
                  : 0,
              color: selectedSidebarOption.name == sidebarOptionData.name
                  ? RSTColors.primaryColor
                  : RSTColors.sidebarTextColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              sidebarOptionData.icon,
              size: selectedSidebarOption.name == sidebarOptionData.name
                  ? 25.0
                  : 20.0,
              color: selectedSidebarOption.name == sidebarOptionData.name
                  ? RSTColors.primaryColor
                  : RSTColors.sidebarTextColor,
            ),
            const SizedBox(
              width: 10.0,
            ),
            RSTText(
              text: sidebarOptionData.name,
              fontSize: 14.0,
              fontWeight: selectedSidebarOption.name == sidebarOptionData.name
                  ? FontWeight.w600
                  : FontWeight.w500,
              color: selectedSidebarOption.name == sidebarOptionData.name
                  ? RSTColors.primaryColor
                  : RSTColors.sidebarTextColor,
            )
          ],
        ),
      ),
    );
  }
}
