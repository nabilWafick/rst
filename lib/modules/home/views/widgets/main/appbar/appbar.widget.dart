import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/modules/home/views/widgets/main/appbar/horizontal_scroller/horizontal_scroller.widget.dart';
import 'package:rst/modules/home/views/widgets/sidebar/suboptions/suboption.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';
//import 'package:rst/utils/constants/constants.util.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
//import 'package:shared_preferences/shared_preferences.dart';

final authenticatedAgentNameProvider = FutureProvider<String>((ref) async {
  //  set user data in shared preferences
  // final prefs = await SharedPreferences.getInstance();
  const agentFistnames =
      'TESTER'; // prefs.getString(RSTConstants.agentFirstnamesPrefKey);
  const agentName = 'Tester'; // prefs.getString(RSTConstants.agentNamePrefKey);

  return '$agentFistnames $agentName';
});

class MainAppbar extends ConsumerStatefulWidget {
  const MainAppbar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainAppbarState();
}

class _MainAppbarState extends ConsumerState<MainAppbar> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final authenticatedAgentName = ref.watch(authenticatedAgentNameProvider);
    final screenSize = MediaQuery.of(context).size;
    final selectedSidebarOption = ref.watch(selectedSidebarOptionProvider);

    return Container(
      height: screenSize.height / 8,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RSTText(
                text: selectedSidebarOption.name,
                //   color: RSTColors.sidebarTextColor,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /*  Icon(
                    Icons.notifications,
                    size: 25.0,
                    color: RSTColors.tertiaryColor,
                  ),
                  SizedBox(
                    width: 30.0,
                  ),*/
                  RSTText(
                    text: authenticatedAgentName.when(
                        data: (data) => data,
                        error: (error, stakTrace) => '',
                        loading: () => ''),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  InkWell(
                    onTap: () async {
                      /*  final lastTryResult =await
                                      InternetConnectionChecker()
                                          .connectionStatus;

                                        //  InternetConnectionChecker()
                                        */
                    },
                    child: const Card(
                      color: RSTColors.primaryColor,
                      elevation: 5.0,
                      child: SizedBox(
                        height: 20.0,
                        width: 20.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: AppBarHorizontalScroller(
              children: selectedSidebarOption.subOptions
                  .map(
                    (subOption) =>
                        SidebarSubOption(sidebarSubOptionData: subOption),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
