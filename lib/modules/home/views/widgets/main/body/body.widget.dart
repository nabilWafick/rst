import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/cash/collections/views/page/collections.page.dart';
import 'package:rst/modules/cash/settlements/views/page/settlements.page.dart';
import 'package:rst/modules/definitions/agents/views/page/agents.page.dart';
import 'package:rst/modules/definitions/cards/views/page/cards.page.dart';
import 'package:rst/modules/definitions/categories/views/page/categories.page.dart';
import 'package:rst/modules/definitions/collectors/views/page/collectors.page.dart';
import 'package:rst/modules/definitions/customers/views/page/customers.page.dart';
import 'package:rst/modules/definitions/economical_activities/views/page/economical_activities.page.dart';
import 'package:rst/modules/definitions/localities/views/page/localities.page.dart';
import 'package:rst/modules/definitions/personal_status/views/page/personal_status.page.dart';
import 'package:rst/modules/definitions/products/views/page/products.page.dart';
import 'package:rst/modules/definitions/types/views/page/types.page.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/widget.test.dart';

class MainBody extends ConsumerStatefulWidget {
  const MainBody({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainBodyState();
}

class _MainBodyState extends ConsumerState<MainBody> {
  final pages = const <Widget>[
    WidgetTest(),
    // DashboardPage(),
    ProductsPage(),
    TypesPage(),
    CategoriesPage(),
    EconomicalActivitiesPage(),
    PersonalStatusPage(),
    LocalitiesPage(),
    CardsPage(),
    CustomersPage(),
    CollectorsPage(),
    AgentsPage(),
    CollectionsPage(),
    WidgetTest(),
    // CashOperationsPage(),
    SettlementsPage(),
    /*CustomerPeriodicActivityPage(),
    CollectorPeriodicActivityPage(),
    SatisfiedCustomersCardsPage(),
    CustomersTypesPage(),
    CustomersProductsPage(),
    ProductsForecastsPage(),
    TransfersBetweenCustomerCardsPage(),
    TransfersBetweenCustomersAccountsPage(),
    TransfersValidationsPage(),
    StocksPage(),*/
    //  EntriesPage(),
    //  FilesPage(),
    //  LogoutPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sidebarOptions = ref.watch(sidebarOptionsProvider);
    final selectedSidebarOption = ref.watch(selectedSidebarOptionProvider);
    final selectedSidebarSubOption =
        ref.watch(selectedSidebarSubOptionProvider);

    return SizedBox(
      // padding: const EdgeInsets.only(bottom: 200.0),

      height: screenSize.height * 7 / 8,
      child:
          // const LocalitiesPage(),
          // const PersonnalStatusPage(),
          // const EconomicalActivitiesPage(),
          // const CustomersCategoriesPage(),
          // const CollectorsPage(),
          // const CustomersPage(),
          // const ProductsPage(),
          // const TypesPage(),

          PageView(
        scrollDirection: Axis.vertical,
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
