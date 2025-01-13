import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/models/permissions_group/permissions_group.model.dart';
import 'package:rst/modules/auth/functions/auth.function.dart';
import 'package:rst/modules/definitions/agents/controllers/agents.controller.dart';
import 'package:rst/modules/definitions/agents/models/agent/agent.model.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';

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
    'orderBy': [
      {
        'id': 'desc',
      }
    ]
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

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? List<Agent>.from(controllerResponse.data) : <Agent>[];
});

// used for storing all agents of database count
final agentsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await AgentsController.countAll();

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing all agents of database count
final yearAgentsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await AgentsController.countAll(listParameters: {
    'where': {
      'createdAt': {
        'gte': '${DateTime(DateTime.now().year).toIso8601String()}Z',
        'lt': '${DateTime(DateTime.now().year + 1).toIso8601String()}Z',
      },
    }
  });

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

// used for storing fetched agents (agents respecting filter options) count
final specificAgentsCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(agentsListParametersProvider);

  final controllerResponse = await AgentsController.countSpecific(
    listParameters: listParameters,
  );

  await AuthFunctions.autoDisconnectAfterUnauthorizedException(
    ref: ref,
    statusCode: controllerResponse.statusCode,
  );

  return controllerResponse.data != null ? controllerResponse.data.count as int : 0;
});

final agentsPermissionsGroupsProvider = StateProvider<List<PermissionsGroup>>((ref) {
  return [
    /// **** CRUD PERMISSIONS **** ///

    /// * ADMIN
    PermissionsGroup(
      name: 'Administration',
      permissions: [
        Permission(
          isGranted: false,
          front: 'Administrateur',
          back: PermissionsValues.admin,
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
          back: PermissionsValues.addProduct,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un produit',
          back: PermissionsValues.readProduct,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un produit',
          back: PermissionsValues.updateProduct,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un produit',
          back: PermissionsValues.deleteProduct,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de produits',
          back: PermissionsValues.printProductsList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de produits',
          back: PermissionsValues.exportProductsList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des produits',
          back: PermissionsValues.showProductsMoreInfos,
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
          back: PermissionsValues.addType,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un type',
          back: PermissionsValues.readType,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un type',
          back: PermissionsValues.updateType,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un type',
          back: PermissionsValues.deleteType,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de types',
          back: PermissionsValues.printTypesList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de types',
          back: PermissionsValues.exportTypesList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des types',
          back: PermissionsValues.showTypesMoreInfos,
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
          back: PermissionsValues.addAgent,
        ),
        Permission(
          isGranted: false,
          front: 'Lire les informations d\'un agent',
          back: PermissionsValues.readAgent,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un agent',
          back: PermissionsValues.updateAgent,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un agent',
          back: PermissionsValues.deleteAgent,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de agents',
          back: PermissionsValues.printAgentsList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de agents',
          back: PermissionsValues.exportAgentsList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des agents',
          back: PermissionsValues.showAgentsMoreInfos,
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
          back: PermissionsValues.addCollector,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un collecteur',
          back: PermissionsValues.readCollector,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un collecteur',
          back: PermissionsValues.updateCollector,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un collecteur',
          back: PermissionsValues.deleteCollector,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de collecteurs',
          back: PermissionsValues.printCollectorsList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de collecteurs',
          back: PermissionsValues.exportCollectorsList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des collecteurs',
          back: PermissionsValues.showCollectorsMoreInfos,
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
          back: PermissionsValues.addCustomer,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un client',
          back: PermissionsValues.readCustomer,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un client',
          back: PermissionsValues.updateCustomer,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un client',
          back: PermissionsValues.deleteCustomer,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de clients',
          back: PermissionsValues.printCustomersList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de clients',
          back: PermissionsValues.exportCustomersList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des clients',
          back: PermissionsValues.showCustomersMoreInfos,
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
          back: PermissionsValues.addCard,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'une carte',
          back: PermissionsValues.readCard,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'une carte',
          back: PermissionsValues.updateCard,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer une carte',
          back: PermissionsValues.deleteCard,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de cartes',
          back: PermissionsValues.printCardsList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de cartes',
          back: PermissionsValues.exportCardsList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des cartes',
          back: PermissionsValues.showCardsMoreInfos,
        ),
      ],
    ),

    /// * COLLECTIONS
    PermissionsGroup(
      name: 'Collectes',
      permissions: [
        Permission(
          isGranted: true,
          front: 'Ajouter une collecte',
          back: PermissionsValues.addCollection,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'une collecte',
          back: PermissionsValues.readCollection,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'une collecte',
          back: PermissionsValues.updateCollection,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer une collecte',
          back: PermissionsValues.deleteCollection,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de collectes',
          back: PermissionsValues.printCollectionsList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de collectes',
          back: PermissionsValues.exportCollectionsList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des collectes',
          back: PermissionsValues.showCollectionsMoreInfos,
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
          back: PermissionsValues.addSettlement,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un règlement',
          back: PermissionsValues.readSettlement,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un règlement',
          back: PermissionsValues.updateSettlement,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un règlement',
          back: PermissionsValues.deleteSettlement,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de règlements',
          back: PermissionsValues.printSettlementsList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de règlements',
          back: PermissionsValues.exportSettlementsList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des règlements',
          back: PermissionsValues.showSettlementsMoreInfos,
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
          back: PermissionsValues.showCash,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher toutes les cartes (satisfaites ou non)',
          back: PermissionsValues.showAllCustomerCardsCash,
        ),
        Permission(
          isGranted: true,
          front: 'Afficher la situation d\'une carte',
          back: PermissionsValues.showCardSituationCash,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer la situation d\'une carte',
          back: PermissionsValues.printCardSituationCash,
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
          back: PermissionsValues.showCustomersActivities,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher toutes les cartes (satisfaites ou non)',
          back: PermissionsValues.showAllCustomerCardsCustomersActivities,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer la situation d\'une carte',
          back: PermissionsValues.printCardSituationCustomersActivities,
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
          back: PermissionsValues.showCollectorsActivities,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer l\'activité d\'un collecteur',
          back: PermissionsValues.printCollectorsActivities,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter l\'activité d\'un collecteur',
          back: PermissionsValues.exportCollectorsActivities,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires de l\'activité d\'un collecteur',
          back: PermissionsValues.showCollectorsActivitiesMoreInfos,
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
          back: PermissionsValues.showTypesStatistics,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer les statistiques des types',
          back: PermissionsValues.printTypesStatistics,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter les statistiques des types',
          back: PermissionsValues.exportTypesStatistics,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des statistiques des types',
          back: PermissionsValues.showTypesStatisticsMoreInfos,
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
          back: PermissionsValues.showCollectorsStatistics,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer les statistiques des collecteurs',
          back: PermissionsValues.printCollectorsStatistics,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter les statistiques des collecteurs',
          back: PermissionsValues.exportCollectorsStatistics,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des statistiques des colecteurs',
          back: PermissionsValues.showCollectorsStatisticsMoreInfos,
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
          back: PermissionsValues.printProductsForecasts,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer les prévisions des produits',
          back: PermissionsValues.printProductsForecasts,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter les prévisions des produits',
          back: PermissionsValues.exportProductsForecasts,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des prévisions des produits',
          back: PermissionsValues.showProductsForecastsMoreInfos,
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
          back: PermissionsValues.addCategory,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'une catégorie',
          back: PermissionsValues.readCategory,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'une catégorie',
          back: PermissionsValues.updateCategory,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer une catégorie',
          back: PermissionsValues.deleteCategory,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de catégories',
          back: PermissionsValues.printCategoriesList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de catégories',
          back: PermissionsValues.exportCategoriesList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des catégories',
          back: PermissionsValues.showCategoriesMoreInfos,
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
          back: PermissionsValues.addLocality,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'une localité',
          back: PermissionsValues.readLocality,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'une localité',
          back: PermissionsValues.updateLocality,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer une localité',
          back: PermissionsValues.deleteLocality,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de localités',
          back: PermissionsValues.printLocalitiesList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de localités',
          back: PermissionsValues.exportLocalitiesList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des localités',
          back: PermissionsValues.showLocalitiesMoreInfos,
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
          back: PermissionsValues.addEconomicalActivity,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'une activité économique',
          back: PermissionsValues.readEconomicalActivity,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'une activité économique',
          back: PermissionsValues.updateEconomicalActivity,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer une activité économique',
          back: PermissionsValues.deleteEconomicalActivity,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste d\'activités économiques',
          back: PermissionsValues.printEconomicalActivitesList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste d\'activités économiques',
          back: PermissionsValues.exportEconomicalActivitiesList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires de\'activités économiques',
          back: PermissionsValues.showEconomicalActivitiesMoreInfos,
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
          back: PermissionsValues.addPersonalStatus,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un statut personnel',
          back: PermissionsValues.readPersonalStatus,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un statut personnel',
          back: PermissionsValues.updatePersonalStatus,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un statut personnel',
          back: PermissionsValues.deletePersonalStatus,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de statuts personnels',
          back: PermissionsValues.printPersonalStatusList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de statuts personnels',
          back: PermissionsValues.exportPersonalStatusList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des statuts personnels',
          back: PermissionsValues.showPersonalStatusMoreInfos,
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
          back: PermissionsValues.addStock,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un stock',
          back: PermissionsValues.readStock,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un stock',
          back: PermissionsValues.updateStock,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un stock',
          back: PermissionsValues.deleteStock,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de stocks',
          back: PermissionsValues.printStocksList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de stocks',
          back: PermissionsValues.exportStocksList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des stocks',
          back: PermissionsValues.showStocksMoreInfos,
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
          back: PermissionsValues.addTransfer,
        ),
        Permission(
          isGranted: true,
          front: 'Lire les informations d\'un transfert',
          back: PermissionsValues.readTransfer,
        ),
        Permission(
          isGranted: false,
          front: 'Modifier les informations d\'un transfert',
          back: PermissionsValues.updateTransfer,
        ),
        Permission(
          isGranted: false,
          front: 'Supprimer un transfert',
          back: PermissionsValues.deleteTransfer,
        ),
        Permission(
          isGranted: false,
          front: 'Imprimer une liste de transferts',
          back: PermissionsValues.printTransfersList,
        ),
        Permission(
          isGranted: false,
          front: 'Exporter une liste de transferts',
          back: PermissionsValues.exportTransfersList,
        ),
        Permission(
          isGranted: false,
          front: 'Afficher les infos supplémentaires des transferts',
          back: PermissionsValues.showTransfersMoreInfos,
        ),
      ],
    ),
  ];
});
