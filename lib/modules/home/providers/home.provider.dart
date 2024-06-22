import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/home/models/sidebar_option/sidebar_option.model.dart';
import 'package:rst/modules/home/models/suboption/suboption.model.dart';

final authEmailProvider = StateProvider<String?>((ref) {
  return;
});

final authNameProvider = StateProvider<String?>((ref) {
  return;
});
final authFirstnamesProvider = StateProvider<String?>((ref) {
  return;
});
final authAccesTokenProvider = StateProvider<String?>((ref) {
  return;
});

final sidebarOptionsProvider = Provider<List<SidebarOptionModel>>(
  (ref) {
    return [
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
        showSubOptions: false,
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
        showSubOptions: true,
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
        showSubOptions: true,
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
        showSubOptions: true,
      ),
      SidebarOptionModel(
        icon: Icons.language,
        name: 'Statistiques',
        subOptions: [
          SidebarSubOptionModel(
            index: 16,
            icon: Icons.cases_rounded,
            name: 'Types',
          ),
          SidebarSubOptionModel(
            index: 17,
            icon: Icons.money,
            name: 'Collectes Périodiques',
          ),
          SidebarSubOptionModel(
            index: 18,
            icon: Icons.query_stats_outlined,
            name: 'Prévisions',
          ),
        ],
        showSubOptions: true,
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
        showSubOptions: true,
      ),
      SidebarOptionModel(
        icon: Icons.widgets_outlined,
        name: 'Stocks',
        subOptions: [
          SidebarSubOptionModel(
            index: 22,
            icon: Icons.stacked_bar_chart_outlined,
            name: 'Stocks',
          ),
        ],
        showSubOptions: false,
      ),
    ];
  },
);

final selectedSidebarOptionProvider = StateProvider<SidebarOptionModel>((ref) {
  final sidebarOption = ref.watch(sidebarOptionsProvider)[0];
  return sidebarOption;
});

final selectedSidebarSubOptionProvider =
    StateProvider<SidebarSubOptionModel>((ref) {
  final sidebarSubOption = ref.watch(sidebarOptionsProvider)[0].subOptions[0];
  return sidebarSubOption;
});
