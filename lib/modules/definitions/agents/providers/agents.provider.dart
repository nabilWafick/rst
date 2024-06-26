import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/models/permissions_group/permissions_group.model.dart';
import 'package:rst/modules/definitions/agents/controllers/agents.controller.dart';
import 'package:rst/modules/definitions/agents/models/agent/agent.model.dart';

// used for storing agent name (form)
final agentNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent firstnames (form)
final agentFirstnamesProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent email (form)
final agentEmailProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent phoneNumber (form)
final agentPhoneNumberProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent address (form)
final agentAddressProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent photo (form)
final agentProfileProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

// used for storing agent permissions (form)
final agentPermissionsProvider = StateProvider<Map<String, bool>>(
  (ref) {
    return {};
  },
);

// used for storing agent permissions (form)
final agentViewsPermissionsProvider = StateProvider<Map<String, bool>>(
  (ref) {
    return {};
  },
);

// used for storing agents filter options
final agentsListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
  };
});

// used for storing added filter tool
final agentsListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched agents
final agentsListStreamProvider = FutureProvider<List<Agent>>((ref) async {
  final listParameters = ref.watch(agentsListParametersProvider);

  final controllerResponse = await AgentsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Agent>.from(controllerResponse.data)
      : <Agent>[];
});

// used for storing all agents of database count
final agentsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await AgentsController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched agents (agents respecting filter options) count
final specificAgentsCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(agentsListParametersProvider);

  final controllerResponse = await AgentsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

final agentsPermissionsGroupsProvider =
    StateProvider<List<PermissionsGroup>>((ref) {
  return [
    /// **** CRUD PERMISSIONS **** ///

    /// * ADMIN
    PermissionsGroup(
      name: 'Administration',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Administrateur',
          back: 'admin',
        ),
      ],
    ),

    /// * PRODUCTS
    PermissionsGroup(
      name: 'Produits',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter un produit',
          back: 'add-product',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un produit',
          back: 'read-product',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un produit',
          back: 'update-product',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un produit',
          back: 'delete-product',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de produits',
          back: 'print-products-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de produits',
          back: 'export-products-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des produits',
          back: 'show-products-more-infos',
        ),
      ],
    ),

    /// * TYPES
    PermissionsGroup(
      name: 'Types',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter un type',
          back: 'add-type',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un type',
          back: 'read-type',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un type',
          back: 'update-type',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un type',
          back: 'delete-type',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de types',
          back: 'print-types-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de types',
          back: 'export-types-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des types',
          back: 'show-types-more-infos',
        ),
      ],
    ),

    ///* AGENTS
    PermissionsGroup(
      name: 'Agents',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter un agent',
          back: 'add-agent',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un agent',
          back: 'read-agent',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un agent',
          back: 'update-agent',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un agent',
          back: 'delete-agent',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de agents',
          back: 'print-agents-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de agents',
          back: 'export-agents-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des agents',
          back: 'show-agents-more-infos',
        ),
      ],
    ),

    ///* COLLECTORS
    PermissionsGroup(
      name: 'Collecteurs',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter un collecteur',
          back: 'add-collector',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un collecteur',
          back: 'read-collector',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un collecteur',
          back: 'update-collector',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un collecteur',
          back: 'delete-collector',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de collecteurs',
          back: 'print-collectors-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de collecteurs',
          back: 'export-collectors-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des collecteurs',
          back: 'show-collectors-more-infos',
        ),
      ],
    ),

    /// * CUSTOMERS
    PermissionsGroup(
      name: 'Clients',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter un client',
          back: 'add-customer',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un client',
          back: 'read-customer',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un client',
          back: 'update-customer',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un client',
          back: 'delete-customer',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de clients',
          back: 'print-customers-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de clients',
          back: 'export-customers-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des clients',
          back: 'show-customers-more-infos',
        ),
      ],
    ),

    /// * CARTES
    PermissionsGroup(
      name: 'Cartes',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter une carte',
          back: 'add-card',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'une carte',
          back: 'read-card',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'une carte',
          back: 'update-card',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer une carte',
          back: 'delete-card',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de cartes',
          back: 'print-cards-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de cartes',
          back: 'export-cards-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des cartes',
          back: 'show-cards-more-infos',
        ),
      ],
    ),

    /// * COLLECTIONS
    PermissionsGroup(
      name: 'Collectes',
      permissions: [
        Permission(
          isGranted: true,
          front: 'Ajouter un collecte',
          back: 'add-collection',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un collecte',
          back: 'read-collection',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un collecte',
          back: 'update-collection',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un collecteur',
          back: 'delete-collection',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de collectes',
          back: 'print-collections-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de collectes',
          back: 'export-collections-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des collectes',
          back: 'show-collections-more-infos',
        ),
      ],
    ),

    /// * SETTLEMENTS
    PermissionsGroup(
      name: 'Règlements',
      permissions: [
        Permission(
          isGranted: true,
          front: 'Ajouter un règlement',
          back: 'add-settlement',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un règlement',
          back: 'read-settlement',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un règlement',
          back: 'update-settlement',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un règlement',
          back: 'delete-settlement',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de règlements',
          back: 'print-settlements-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de règlements',
          back: 'export-settlements-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des règlements',
          back: 'show-settlements-more-infos',
        ),
      ],
    ),

    /// * CASH
    PermissionsGroup(
      name: 'Caisse',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Afficher la caisse',
          back: 'show-cash',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher toutes les cartes (satisfaites ou non)',
          back: 'show-all-customer-cards-cash',
        ),
        Permission(
          isGranted: true,
          front: 'Afficher la situation d\'une carte',
          back: 'show-card-situation-cash',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer la situation d\'une carte',
          back: 'print-card-situation-cash',
        ),
      ],
    ),

    /// * CUSTOMERS ACTIVITIES
    PermissionsGroup(
      name: 'Activités Clients',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Afficher l\'activité d\'un client',
          back: 'show-customers-activities',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher toutes les cartes (satisfaites ou non)',
          back: 'show-all-customer-cards-customers-activities',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer la situation d\'une carte',
          back: 'print-card-situation-customers-activities',
        ),
      ],
    ),

    /// * COLLECTORS ACTIVITIES
    PermissionsGroup(
      name: 'Activités Collecteurs',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Afficher l\'activité d\'un collecteur',
          back: 'show-collectors-activities',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer l\'activité d\'un collecteur',
          back: 'print-collectors-activities',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter l\'activité d\'un collecteur',
          back: 'export-collectors-activities',
        ),
        Permission(
          isGranted: false,
          front:
              'Afficher les infos supplémentaires de l\'activité d\'un collecteur',
          back: 'show-collectors-activities-more-infos',
        ),
      ],
    ),

    /// * TYPES STATISTICS
    PermissionsGroup(
      name: 'Statistiques Types',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Afficher les statistiques des types',
          back: 'show-types-statistics',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer les statistiques des types',
          back: 'print-types-statistics',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter les statistiques des types',
          back: 'export-types-statistics',
        ),
        Permission(
          isGranted: false,
          front:
              'Afficher les infos supplémentaires des statistiques des types',
          back: 'show-types-statistics-more-infos',
        ),
      ],
    ),

    /// * COLLECTORS STATISTICS
    PermissionsGroup(
      name: 'Statistiques Collecteurs',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Afficher les statistiques des collecteurs',
          back: 'show-collectors-statistics',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer les statistiques des collecteurs',
          back: 'print-collectors-statistics',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter les statistiques des collecteurs',
          back: 'export-collectors-statistics',
        ),
        Permission(
          isGranted: false,
          front:
              'Afficher les infos supplémentaires des statistiques des types',
          back: 'show-types-statistics-more-infos',
        ),
      ],
    ),

    /// * PRODUCTS STATISTICS
    PermissionsGroup(
      name: 'Prévisions Produits',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Afficher les prévisions des produits',
          back: 'show-products-forecasts',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer les prévisions des produits',
          back: 'print-products-forecasts',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter les prévisions des produits',
          back: 'export-products-forecasts',
        ),
        Permission(
          isGranted: false,
          front:
              'Afficher les infos supplémentaires des prévisions des produits',
          back: 'show-products-forecasts-more-infos',
        ),
      ],
    ),

    /// * CATEGORIES
    PermissionsGroup(
      name: 'Catégorie',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter une catégorie',
          back: 'add-category',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'une catégorie',
          back: 'read-category',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'une catégorie',
          back: 'update-category',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer une catégorie',
          back: 'delete-category',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de catégories',
          back: 'print-categories-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de catégories',
          back: 'export-categories-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des catégories',
          back: 'show-categories-more-infos',
        ),
      ],
    ),

    /// * LOCALITIES
    PermissionsGroup(
      name: 'Localités',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter une localité',
          back: 'add-locality',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'une localité',
          back: 'read-locality',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'une localité',
          back: 'update-locality',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer une localité',
          back: 'delete-locality',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de localités',
          back: 'print-localities-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de localités',
          back: 'export-localities-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des localités',
          back: 'show-localities-more-infos',
        ),
      ],
    ),

    /// * ECONOMICAL ACTIVITY
    PermissionsGroup(
      name: 'Activité Économique',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter une activité économique',
          back: 'add-economical-activity',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'une activité économique',
          back: 'read-economical-activity',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'une activité économique',
          back: 'update-economical-activity',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer une activité économique',
          back: 'delete-economical-activity',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste d\'activités économiques',
          back: 'print-economical-activities-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste d\'activités économiques',
          back: 'export-economical-activities-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires de\'activités économiques',
          back: 'show-economical-activities-more-infos',
        ),
      ],
    ),

    /// * PERSONAL STATUS
    PermissionsGroup(
      name: 'Statuts personnels',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter un statut personnel',
          back: 'add-personal-status',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un statut personnel',
          back: 'read-personal-status',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un statut personnel',
          back: 'update-personal-status',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un statut personnel',
          back: 'delete-personal-status',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de statuts personnels',
          back: 'print-personal-status-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de statuts personnels',
          back: 'export-personal-status-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des statuts personnels',
          back: 'show-personal-status-more-infos',
        ),
      ],
    ),

    /// * STOCKS
    PermissionsGroup(
      name: 'Stocks',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter un stock',
          back: 'add-stock',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un stock',
          back: 'read-stock',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un stock',
          back: 'update-stock',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un stock',
          back: 'delete-stock',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de stocks',
          back: 'print-stocks-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de stocks',
          back: 'export-stocks-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des stocks',
          back: 'show-stocks-more-infos',
        ),
      ],
    ),

    /// * TRANSFERS
    PermissionsGroup(
      name: 'Transferts',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Ajouter un transfert',
          back: 'add-transfer',
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un transfert',
          back: 'read-transfer',
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un transfert',
          back: 'update-transfer',
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un transfert',
          back: 'delete-transfer',
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de transferts',
          back: 'print-transfers-list',
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de transferts',
          back: 'export-transfers-list',
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des transferts',
          back: 'show-transfers-more-infos',
        ),
      ],
    ),
  ];
});
