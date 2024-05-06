import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/home/models/sidebar_option/sidebar_option.model.dart';
import 'package:rst/modules/home/models/suboption/suboption.model.dart';

final sidebarOptionsProvider = Provider<List<SidebarOptionModel>>(
  (ref) {
    return [
      SidebarOptionModel(
        icon: Icons.stacked_bar_chart,
        name: 'Dashboard',
        subOptions: [
          SidebarSubOptionModel(
            index: 0,
            icon: Icons.stacked_bar_chart,
            name: 'Dashboard',
          ),
        ],
        showSubOptions: false,
      ),
      SidebarOptionModel(
        icon: Icons.dataset,
        name: 'Définitions',
        subOptions: [
          /* SidebarSubOptionModel(
                  index: 25,
                  icon: Icons.account_balance,
                  name: 'Agences',
                ),*/
          SidebarSubOptionModel(
            index: 1,
            icon: Icons.inventory,
            name: 'Produits',
          ),
          SidebarSubOptionModel(
            index: 2,
            icon: Icons.cases_rounded,
            name: 'Types',
          ),
          SidebarSubOptionModel(
            index: 3,
            icon: Icons.supervised_user_circle,
            name: 'Chargés de comptes',
          ),
          SidebarSubOptionModel(
            index: 4,
            icon: Icons.group,
            name: 'Catégories Client',
          ),
          SidebarSubOptionModel(
            index: 5,
            icon: Icons.work,
            name: 'Activités Économiques',
          ),
          SidebarSubOptionModel(
            index: 6,
            icon: Icons.person,
            name: 'Statuts Personnels',
          ),
          SidebarSubOptionModel(
            index: 7,
            icon: Icons.location_city,
            name: 'Localités',
          ),
          SidebarSubOptionModel(
            index: 8,
            icon: Icons.account_circle,
            name: 'Clients',
          ),
          SidebarSubOptionModel(
            index: 9,
            icon: Icons.admin_panel_settings,
            name: 'Agents',
          ),
          SidebarSubOptionModel(
            index: 10,
            icon: Icons.account_box,
            name: 'Comptes Clients',
          ),
          SidebarSubOptionModel(
            index: 11,
            icon: Icons.payment,
            name: 'Cartes',
          ),
        ],
        showSubOptions: true,
      ),
      SidebarOptionModel(
        icon: Icons.account_balance,
        name: 'Caisse',
        subOptions: [
          SidebarSubOptionModel(
            index: 12,
            icon: Icons.payments,
            name: 'Versements Collectes',
          ),
          SidebarSubOptionModel(
            index: 13,
            icon: Icons.account_balance,
            name: 'Opérations Caisse',
          ),
          SidebarSubOptionModel(
            index: 14,
            icon: Icons.money,
            name: 'Règlements',
          ),
        ],
        showSubOptions: true,
      ),
      SidebarOptionModel(
        icon: Icons.analytics,
        name: 'Activités',
        subOptions: [
          SidebarSubOptionModel(
            index: 15,
            icon: Icons.analytics,
            name: ' Client',
          ),
          SidebarSubOptionModel(
            index: 16,
            icon: Icons.analytics,
            name: 'Chargé de Compte',
          ),
          SidebarSubOptionModel(
            index: 17,
            icon: Icons.analytics,
            name: 'Cartes Satisfaites',
          ),
        ],
        showSubOptions: true,
      ),
      SidebarOptionModel(
        icon: Icons.stacked_line_chart,
        name: 'Statistiques',
        subOptions: [
          SidebarSubOptionModel(
            index: 18,
            icon: Icons.stacked_line_chart,
            name: 'Types',
          ),
          SidebarSubOptionModel(
            index: 19,
            icon: Icons.stacked_line_chart,
            name: 'Produits',
          ),
          SidebarSubOptionModel(
            index: 20,
            icon: Icons.query_stats,
            name: 'Prévisions',
          ),
        ],
        showSubOptions: true,
      ),
      SidebarOptionModel(
        icon: Icons.swap_vert,
        name: 'Transferts',
        subOptions: [
          SidebarSubOptionModel(
            index: 21,
            icon: Icons.swap_vert,
            name: 'Entre Cartes',
          ),
          SidebarSubOptionModel(
            index: 22,
            icon: Icons.swap_vert,
            name: 'Entre Comptes',
          ),
          SidebarSubOptionModel(
            index: 23,
            icon: Icons.published_with_changes,
            name: 'Validations',
          ),
        ],
        showSubOptions: true,
      ),
      SidebarOptionModel(
        icon: Icons.inventory_2,
        name: 'Stocks',
        subOptions: [
          SidebarSubOptionModel(
            index: 24,
            icon: Icons.stacked_bar_chart,
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
