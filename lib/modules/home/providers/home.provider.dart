import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/activities/collector/views/page/collector_activities.page.dart';
import 'package:rst/modules/activities/customer/views/page/customer_activities.page.dart';
import 'package:rst/modules/auth/empty/views/page/empty.page.dart';
import 'package:rst/modules/cash/cash_operations/views/page/cash_operations.page.dart';
import 'package:rst/modules/cash/collections/views/page/collections.page.dart';
import 'package:rst/modules/cash/settlements/views/page/settlements.page.dart';
import 'package:rst/modules/dashboard/views/page/dashboard.page.dart';
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
import 'package:rst/modules/home/models/sidebar_option/sidebar_option.model.dart';
import 'package:rst/modules/home/models/suboption/suboption.model.dart';
import 'package:rst/modules/statistics/collectors_collections/views/page/collectors_collections.page.dart';
import 'package:rst/modules/statistics/types_stat/views/page/types_stat.page.dart';
import 'package:rst/modules/stocks/stocks/views/page/stocks.page.dart';
import 'package:rst/modules/transfers/between_customer_cards/views/page/transfers_bcc.page.dart';
import 'package:rst/modules/transfers/between_customers/views/page/transfers_bc.page.dart';
import 'package:rst/modules/transfers/validations/views/page/validations.page.dart';
import 'package:rst/widget.test.dart';

final authEmailProvider = StateProvider<String?>((ref) {
  return;
});

final authNameProvider = StateProvider<String?>((ref) {
  return;
});
final authFirstnamesProvider = StateProvider<String?>((ref) {
  return;
});

final authPermissionsProvider = StateProvider<Map<String, dynamic>?>((ref) {
  return;
});

final authAccesTokenProvider = StateProvider<String?>((ref) {
  return;
});

final modulesVisibilityConditionsProvider = Provider<List<bool>>((ref) {
  final authPermissions = ref.watch(authPermissionsProvider);
  final primaryModulesVisibilityConditions = [
    // Dashboard
    authPermissions!['admin'],

    // Definitions
    true,

    // Cash
    authPermissions['admin'] || authPermissions['add-collection'],

    // Activities
    authPermissions['admin'] ||
        authPermissions['show-customers-activities'] ||
        authPermissions['show-collectors-activities'],

    // Statistiques
    authPermissions['admin'] ||
        authPermissions['show-types-statistics'] ||
        authPermissions['show-collectors-statistics'] ||
        authPermissions['show-products-forecasts'],

    // Transfers
    authPermissions['admin'] || authPermissions['add-transfer'],

    // Stocks
    authPermissions['admin'] || authPermissions['add-stock']
  ];

  return [
    ...primaryModulesVisibilityConditions,

    // Empty
    primaryModulesVisibilityConditions.every(
      (condition) => !condition,
    ),
  ];
});

final sidebarOptionsProvider = Provider<List<SidebarOptionModel>>(
  (ref) {
    final modulesVisibilityConditions =
        ref.watch(modulesVisibilityConditionsProvider);

    final authPermissions = ref.watch(authPermissionsProvider);

    final modulesSidebarOptionModel = [
      SidebarOptionModel(
        icon: Icons.dashboard_outlined,
        name: 'Dashboard',
        subOptions: [
          SidebarSubOptionModel(
            index: 0,
            icon: Icons.stacked_bar_chart_outlined,
            name: 'Dashboard',
          ),
        ],
        subOptionsVisibility: [
          authPermissions!['admin'],
        ],
      ),
      SidebarOptionModel(
        icon: Icons.table_chart_outlined,
        name: 'Définitions',
        subOptions: [
          /* SidebarSubOptionModel(
                  index: 25,
                  icon: Icons.account_balance,
                  name: 'Agences',
                ),*/
          SidebarSubOptionModel(
            index: 1,
            icon: Icons.inventory_2_outlined,
            name: 'Produits',
          ),
          SidebarSubOptionModel(
            index: 2,
            icon: Icons.cases_rounded,
            name: 'Types',
          ),
          SidebarSubOptionModel(
            index: 3,
            icon: Icons.group_outlined,
            name: 'Catégories',
          ),
          SidebarSubOptionModel(
            index: 4,
            icon: Icons.work_outlined,
            name: 'Activités Économiques',
          ),
          SidebarSubOptionModel(
            index: 5,
            icon: Icons.person_outlined,
            name: 'Statuts Personnels',
          ),
          SidebarSubOptionModel(
            index: 6,
            icon: Icons.location_city_outlined,
            name: 'Localités',
          ),
          SidebarSubOptionModel(
            index: 7,
            icon: Icons.credit_card,
            name: 'Cartes',
          ),
          SidebarSubOptionModel(
            index: 8,
            icon: Icons.account_circle_outlined,
            name: 'Clients',
          ),
          SidebarSubOptionModel(
            index: 9,
            icon: Icons.supervised_user_circle_outlined,
            name: 'Collecteurs',
          ),
          SidebarSubOptionModel(
            index: 10,
            icon: Icons.admin_panel_settings_outlined,
            name: 'Agents',
          ),
        ],
        subOptionsVisibility: [
          // Products
          authPermissions['admin'] || authPermissions['read-product'],

          // Types
          authPermissions['admin'] || authPermissions['read-type'],

          // Categories
          authPermissions['admin'] || authPermissions['read-category'],

          // Economical Activities
          authPermissions['admin'] ||
              authPermissions['read-economical-activity'],

          // Personal Status
          authPermissions['admin'] || authPermissions['read-personal-status'],

          // Localities
          authPermissions['admin'] || authPermissions['read-locality'],

          // Cards
          authPermissions['admin'] || authPermissions['read-card'],

          // Customers
          authPermissions['admin'] || authPermissions['read-customer'],

          // Collectors
          authPermissions['admin'] || authPermissions['read-collector'],

          // Agents
          authPermissions['admin'] || authPermissions['read-agent']
        ],
      ),
      SidebarOptionModel(
        icon: Icons.account_balance_outlined,
        name: 'Caisse',
        subOptions: [
          SidebarSubOptionModel(
            index: 11,
            icon: Icons.payments_outlined,
            name: 'Versements Collectes',
          ),
          SidebarSubOptionModel(
            index: 12,
            icon: Icons.account_balance_outlined,
            name: 'Opérations Caisse',
          ),
          SidebarSubOptionModel(
            index: 13,
            icon: Icons.money_outlined,
            name: 'Règlements',
          ),
        ],
        subOptionsVisibility: [
          // Collection
          authPermissions['admin'] || authPermissions['read-collection'],

          // Cash
          authPermissions['admin'] || authPermissions['show-cash'],

          // Settlement
          authPermissions['admin'] || authPermissions['read-settlement']
        ],
      ),
      SidebarOptionModel(
        icon: Icons.analytics_outlined,
        name: 'Activités',
        subOptions: [
          SidebarSubOptionModel(
            index: 14,
            icon: Icons.analytics_outlined,
            name: 'Client',
          ),
          SidebarSubOptionModel(
            index: 15,
            icon: Icons.analytics_outlined,
            name: 'Chargé de Compte',
          ),
        ],
        subOptionsVisibility: [
          // Customers activities
          authPermissions['admin'] ||
              authPermissions['show-customers-activities'],

          // Collectors activities
          authPermissions['admin'] ||
              authPermissions['show-collectors-activities'],
        ],
      ),
      SidebarOptionModel(
        icon: Icons.language,
        name: 'Statistiques',
        subOptions: [
          SidebarSubOptionModel(
            index: 16,
            icon: Icons.language,
            name: 'Types',
          ),
          SidebarSubOptionModel(
            index: 17,
            icon: Icons.language,
            name: 'Collectes Périodiques',
          ),
          SidebarSubOptionModel(
            index: 18,
            icon: Icons.language,
            name: 'Prévisions',
          ),
        ],
        subOptionsVisibility: [
          // Types
          authPermissions['admin'] || authPermissions['show-types-statistics'],

          // Periodic Collections
          authPermissions['admin'] ||
              authPermissions['show-collectors-statistics'],

          // Products Forecast
          authPermissions['admin'] ||
              authPermissions['show-products-forecasts'],
        ],
      ),
      SidebarOptionModel(
        icon: Icons.swap_vert_outlined,
        name: 'Transferts',
        subOptions: [
          SidebarSubOptionModel(
            index: 19,
            icon: Icons.swap_vert_outlined,
            name: 'Entre Cartes',
          ),
          SidebarSubOptionModel(
            index: 20,
            icon: Icons.swap_vert_outlined,
            name: 'Entre Comptes',
          ),
          SidebarSubOptionModel(
            index: 21,
            icon: Icons.published_with_changes_outlined,
            name: 'Validations',
          ),
        ],
        subOptionsVisibility: [
          // transfer between card
          authPermissions['admin'] || authPermissions['add-transfer'],

          // transfer between account
          authPermissions['admin'] || authPermissions['add-transfer'],

          // transfers validations
          authPermissions['admin'] || authPermissions['read-transfer'],
        ],
      ),
      SidebarOptionModel(
        icon: Icons.widgets_outlined,
        name: 'Stocks',
        subOptions: [
          SidebarSubOptionModel(
            index: 22,
            icon: Icons.widgets_outlined,
            name: 'Stocks',
          ),
        ],
        subOptionsVisibility: [
          // stock
          authPermissions['admin'] || authPermissions['read-stock'],
        ],
      ),
      SidebarOptionModel(
        icon: Icons.hourglass_empty,
        name: 'Empty',
        subOptions: [
          SidebarSubOptionModel(
            index: 23,
            icon: Icons.hourglass_empty,
            name: 'Empty',
          ),
        ],
        subOptionsVisibility: [true],
      )
    ];
    // return only modules where display condition is true,
    return modulesVisibilityConditions
        .where(
          (modulesDisplayCondition) => modulesDisplayCondition,
        )
        .map(
          (modulesDisplayCondition) => modulesSidebarOptionModel[
              modulesVisibilityConditions.indexOf(modulesDisplayCondition)],
        )
        .toList();
  },
);

final pagesProvider = Provider<List<Widget>>((ref) {
  return [
    const DashboardPage(),
    const ProductsPage(),
    const TypesPage(),
    const CategoriesPage(),
    const EconomicalActivitiesPage(),
    const PersonalStatusPage(),
    const LocalitiesPage(),
    const CardsPage(),
    const CustomersPage(),
    const CollectorsPage(),
    const AgentsPage(),
    const CollectionsPage(),
    const CashOperationsPage(),
    const SettlementsPage(),
    const CustomerActivitiesPage(),
    const CollectorActivitiesPage(),

    const TypesStatsPage(),

    const CollectorsCollectionsPage(),
    //  ProductsForecastsPage(),
    const WidgetTest(),

    const TransfersBCCPage(),
    const TransfersBCPage(),
    const TransfersValidationPage(),
    const StocksPage(),
    const EmptyPage()
  ];
});

final selectedSidebarOptionProvider = StateProvider<SidebarOptionModel>((ref) {
  final sidebarOption = ref.watch(sidebarOptionsProvider).firstOrNull ??
      SidebarOptionModel(
        icon: Icons.hourglass_empty,
        name: 'Empty',
        subOptions: [
          SidebarSubOptionModel(
            index: 23,
            icon: Icons.hourglass_empty,
            name: 'Empty',
          ),
        ],
        subOptionsVisibility: [true],
      );

  // check null because at least definition can be displayed
  return sidebarOption;
});

final selectedSidebarSubOptionProvider =
    StateProvider<SidebarSubOptionModel>((ref) {
  final sidebarOption = ref.watch(selectedSidebarOptionProvider);

  return sidebarOption.subOptions.firstWhere(
    (subOption) {
      final subOptionIndex = sidebarOption.subOptions.indexOf(subOption);

      return sidebarOption.subOptionsVisibility[subOptionIndex];
    },
    orElse: () => SidebarSubOptionModel(
      index: 23,
      icon: Icons.hourglass_empty,
      name: 'Empty',
    ),
  );
});
