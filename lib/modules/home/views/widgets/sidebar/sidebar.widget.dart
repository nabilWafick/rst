import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/home/models/sidebar_option/sidebar_option.model.dart';
import 'package:rst/modules/home/models/suboption/suboption.model.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/modules/home/views/widgets/sidebar/logout_option/logout_option.widget.dart';
import 'package:rst/modules/home/views/widgets/sidebar/options/option.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/widgets/logo/logo.dart';

class Sidebar extends ConsumerStatefulWidget {
  const Sidebar({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sidebarOptions = ref.watch(sidebarOptionsProvider);
    return Container(
      width: screenSize.width / 8,
      color: RSTColors.secondaryColor,
      child: Column(
        //  crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: screenSize.height / 6,
            width: double.infinity,
            child: const RSTLogo(
              fontSize: 15.0,
              bankColor: RSTColors.backgroundColor,
            ),
          ),
          SizedBox(
            height: screenSize.height * 5 / 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: sidebarOptions
                      .map(
                        (sidebarOption) =>
                            SidebarOption(sidebarOptionData: sidebarOption),
                      )
                      .toList(),
                ),
                LogoutSidebarOption(
                  sidebarOptionData: SidebarOptionModel(
                    icon: Icons.logout,
                    name: 'Déconnexion',
                    subOptions: [
                      SidebarSubOptionModel(
                        index: 16,
                        icon: Icons.logout,
                        name: 'Déconnexion',
                      )
                    ],
                    showSubOptions: true,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
