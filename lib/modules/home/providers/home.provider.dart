import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/activities/collectors/views/page/collector_activities.page.dart';
import 'package:rst/modules/activities/customer/views/page/customer_activities.page.dart';
import 'package:rst/modules/auth/empty/views/page/empty.page.dart';
import 'package:rst/modules/cash/cash_operations/views/page/cash_operations.page.dart';
import 'package:rst/modules/cash/collections/views/page/collections.page.dart';
import 'package:rst/modules/cash/settlements/views/page/settlements.page.dart';
import 'package:rst/modules/dashboard/views/page/dashboard.page.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
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
import 'package:rst/modules/statistics/products_forecasts/views/page/products_forecasts.page.dart';
import 'package:rst/modules/statistics/products_improvidence/views/page/products_improvidence.page.dart';
import 'package:rst/modules/statistics/types_stat/views/page/types_stat.page.dart';
import 'package:rst/modules/stocks/stocks/views/page/stocks.page.dart';
import 'package:rst/modules/transfers/between_customer_cards/views/page/transfers_bcc.page.dart';
import 'package:rst/modules/transfers/between_customers/views/page/transfers_bc.page.dart';
import 'package:rst/modules/transfers/validations/views/page/validations.page.dart';

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

final modulesVisibilityConditionsProvider = Provider<Map<int, bool>>((ref) {
  final authPermissions = ref.watch(authPermissionsProvider);
  Map<int, bool> primaryModulesVisibilityConditions = {
    // Dashboard
    0: authPermissions?[PermissionsValues.admin],

    // Definitions
    1: (authPermissions?[PermissionsValues.admin] ?? false) ||
        (authPermissions?[PermissionsValues.readProduct] ?? false) ||
        (authPermissions?[PermissionsValues.readType] ?? false) ||
        (authPermissions?[PermissionsValues.readCategory] ?? false) ||
        (authPermissions?[PermissionsValues.readLocality] ?? false) ||
        (authPermissions?[PermissionsValues.readEconomicalActivity] ?? false) ||
        (authPermissions?[PermissionsValues.readPersonalStatus] ?? false) ||
        (authPermissions?[PermissionsValues.readCustomer] ?? false) ||
        (authPermissions?[PermissionsValues.readCard] ?? false) ||
        (authPermissions?[PermissionsValues.readCollector] ?? false) ||
        (authPermissions?[PermissionsValues.readAgent] ?? false),

    // Cash
    2: (authPermissions?[PermissionsValues.admin] ?? false) ||
        (authPermissions?[PermissionsValues.readCollection] ?? false),

    // Activities
    3: (authPermissions?[PermissionsValues.admin] ?? false) ||
        (authPermissions?[PermissionsValues.showCustomersActivities] ?? false) ||
        (authPermissions?[PermissionsValues.showCollectorsActivities] ?? false),

    // Statistiques
    4: (authPermissions?[PermissionsValues.admin] ?? false) ||
        (authPermissions?[PermissionsValues.showTypesStatistics] ?? false) ||
        (authPermissions?[PermissionsValues.showCollectorsStatistics] ?? false) ||
        (authPermissions?[PermissionsValues.showProductsForecasts] ?? false),

    // Transfers
    5: (authPermissions?[PermissionsValues.admin] ?? false) ||
        (authPermissions?[PermissionsValues.addTransfer] ?? false),

    // Stocks
    6: (authPermissions?[PermissionsValues.admin] ?? false) ||
        (authPermissions?[PermissionsValues.readStock] ?? false)
  };

  return {
    ...primaryModulesVisibilityConditions,

    // Empty
    7: primaryModulesVisibilityConditions.values.every(
      (value) => !value,
    ),
  };
});

final sidebarOptionsProvider = Provider<List<SidebarOptionModel>>(
  (ref) {
    final modulesVisibilityConditions = ref.watch(modulesVisibilityConditionsProvider);

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
        subOptionsVisibility: {
          0: (authPermissions?[PermissionsValues.admin] ?? false),
        },
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
        subOptionsVisibility: {
          // Products
          0: ((authPermissions?[PermissionsValues.admin] ?? false)) ||
              (authPermissions?[PermissionsValues.readProduct] ?? false),

          // Types
          1: ((authPermissions?[PermissionsValues.admin] ?? false)) ||
              (authPermissions?[PermissionsValues.readType] ?? false),

          // Categories
          2: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readCategory] ?? false),

          // Economical Activities
          3: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readEconomicalActivity] ?? false),

          // Personal Status
          4: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readPersonalStatus] ?? false),

          // Localities
          5: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readLocality] ?? false),

          // Cards
          6: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readCard] ?? false),

          // Customers
          7: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readCustomer] ?? false),

          // Collectors
          8: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readCollector] ?? false),

          // Agents
          9: (authPermissions?[PermissionsValues.admin] ?? false),
        },
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
        subOptionsVisibility: {
          // Collection
          0: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readCollection] ?? false),

          // Cash
          1: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.showCash] ?? false),

          // Settlement
          2: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readSettlement] ?? false)
        },
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
        subOptionsVisibility: {
          // Customers activities
          0: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.showCustomersActivities] ?? false),

          // Collectors activities
          1: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.showCollectorsActivities] ?? false),
        },
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
          SidebarSubOptionModel(
            index: 19,
            icon: Icons.language,
            name: 'Exclusions',
          ),
        ],
        subOptionsVisibility: {
          // Types
          0: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.showTypesStatistics] ?? false),

          // Periodic Collections
          1: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.showCollectorsStatistics] ?? false),

          // Products Forecast
          2: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.showProductsForecasts] ?? false),
          // Products Exclusion
          3: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.showProductsForecasts] ?? false),
        },
      ),
      SidebarOptionModel(
        icon: Icons.swap_vert_rounded,
        name: 'Transferts',
        subOptions: [
          SidebarSubOptionModel(
            index: 20,
            icon: Icons.swap_vert_rounded,
            name: 'Entre Cartes',
          ),
          SidebarSubOptionModel(
            index: 21,
            icon: Icons.swap_vert_rounded,
            name: 'Entre Comptes',
          ),
          SidebarSubOptionModel(
            index: 22,
            icon: Icons.published_with_changes_outlined,
            name: 'Validations',
          ),
        ],
        subOptionsVisibility: {
          // transfer between card
          0: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.addTransfer] ?? false),

          // transfer between account
          1: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.addTransfer] ?? false),

          // transfers validations
          2: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readTransfer] ?? false),
        },
      ),
      SidebarOptionModel(
        icon: Icons.widgets_outlined,
        name: 'Stocks',
        subOptions: [
          SidebarSubOptionModel(
            index: 23,
            icon: Icons.widgets_outlined,
            name: 'Stocks',
          ),
        ],
        subOptionsVisibility: {
          // stock
          0: (authPermissions?[PermissionsValues.admin] ?? false) ||
              (authPermissions?[PermissionsValues.readStock] ?? false),
        },
      ),
      SidebarOptionModel(
        icon: Icons.hourglass_empty,
        name: 'Empty',
        subOptions: [
          SidebarSubOptionModel(
            index: 24,
            icon: Icons.hourglass_empty,
            name: 'Empty',
          ),
        ],
        subOptionsVisibility: {
          0: true,
        },
      )
    ];

    // return only modules where display condition is true,
    return modulesVisibilityConditions.entries
        .where(
          (modulesVisibilityCondition) => modulesVisibilityCondition.value,
        )
        .map((modulesVisibilityCondition1) =>
            modulesSidebarOptionModel[modulesVisibilityCondition1.key])
        .toList();
  },
);

final pagesProvider = Provider<List<Widget>>((ref) {
  return const [
    DashboardPage(),
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
    CashOperationsPage(),
    SettlementsPage(),
    CustomerActivitiesPage(),
    CollectorActivitiesPage(),
    TypesStatsPage(),
    CollectorsCollectionsPage(),
    ProductsForecastsPage(),
    ProductsImprovidencePage(),
    TransfersBCCPage(),
    TransfersBCPage(),
    TransfersValidationPage(),
    StocksPage(),
    EmptyPage()
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
        subOptionsVisibility: {0: true},
      );

  // check null because at least definition can be displayed
  return sidebarOption;
});

final selectedSidebarSubOptionProvider = StateProvider<SidebarSubOptionModel>((ref) {
  final sidebarOption = ref.watch(selectedSidebarOptionProvider);

  final firstSubOptionVisible = sidebarOption.subOptionsVisibility.entries.firstWhereOrNull(
    (subOption) {
      return subOption.value;
    },
  );

  return firstSubOptionVisible != null
      ? sidebarOption.subOptions[firstSubOptionVisible.key]
      : SidebarSubOptionModel(
          index: 23,
          icon: Icons.hourglass_empty,
          name: 'Empty',
        );
});
