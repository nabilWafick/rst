import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class MainBody extends ConsumerStatefulWidget {
  const MainBody({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainBodyState();
}

class _MainBodyState extends ConsumerState<MainBody> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sidebarOptions = ref.watch(sidebarOptionsProvider);
    final selectedSidebarOption = ref.watch(selectedSidebarOptionProvider);
    final selectedSidebarSubOption =
        ref.watch(selectedSidebarSubOptionProvider);
    final pages = ref.watch(pagesProvider);

    return SizedBox(
      // padding: const EdgeInsets.only(bottom: 200.0),

      height: screenSize.height * 7 / 8,
      child: PageView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          //  debugPrint('onPageChanged Index: $index');

          // Find the sidebarOption which contains the sidebarSubOption having index equal to pageView index
          final selectedOption = sidebarOptions.firstWhere(
            (option) =>
                option.subOptions.any((subOption) => subOption.index == index),
            orElse: () => selectedSidebarOption,
          );

          // Update sidebarOption provider
          ref.read(selectedSidebarOptionProvider.notifier).state =
              selectedOption;

          // Find sidebarSubOption having index equal to pageView index
          final selectedSubOption = selectedOption.subOptions.firstWhere(
            (subOption) => subOption.index == index,
            orElse: () => selectedSidebarSubOption,
          );

          // Update the sidebarSubOption provider
          ref.read(selectedSidebarSubOptionProvider.notifier).state =
              selectedSubOption;
        },
        children: pages
            .map(
              (page) => pages[selectedSidebarSubOption.index],
            )
            .toList(),
      ),
    );
  }
}
