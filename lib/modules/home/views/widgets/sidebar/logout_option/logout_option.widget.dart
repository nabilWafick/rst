import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/home/models/sidebar_option/sidebar_option.model.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

class LogoutSidebarOption extends ConsumerWidget {
  final SidebarOptionModel sidebarOptionData;

  const LogoutSidebarOption({
    super.key,
    required this.sidebarOptionData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSidebarOption = ref.watch(selectedSidebarOptionProvider);
    return InkWell(
      onTap: () async {
        await AuthFunctions.disconnect(
          ref: ref,
          context: context,
        );
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
