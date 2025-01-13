import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/cash/collections/providers/collections.provider.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/dashboard/views/widgets/dashboard_card/dashboard_card.widget.dart';
import 'package:rst/modules/definitions/agents/providers/agents.provider.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';
import 'package:rst/modules/definitions/collectors/providers/collectors.provider.dart';
import 'package:rst/modules/definitions/customers/providers/customers.provider.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class DashboardOverview extends StatefulHookConsumerWidget {
  const DashboardOverview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardOverviewState();
}

class _DashboardOverviewState extends ConsumerState<DashboardOverview> {
  @override
  Widget build(BuildContext context) {
    final totalCollections = ref.watch(collectionsSumProvider);
    //  final yearTotalCollections = ref.watch(yearCollectionsSumProvider);
    final totalCollectionsRest = ref.watch(collectionsRestSumProvider);
    final dayTotalCollectionsRest = ref.watch(dayCollectionsRestSumProvider);
    final weekTotalCollectionsRest = ref.watch(weekCollectionsRestSumProvider);
    final monthTotalCollectionsRest = ref.watch(monthCollectionsRestSumProvider);
    final yearTotalCollectionsRest = ref.watch(yearCollectionsRestSumProvider);
    final collectionsProfit = ref.watch(collectionsProfitProvider);
    final yearCollectionsProfit = ref.watch(yearCollectionsProfitProvider);
    final totalCustomers = ref.watch(customersCountProvider);
    final yearTotalCustomers = ref.watch(yearCustomersCountProvider);
    final totalCollectors = ref.watch(collectorsCountProvider);
    final yearTotalCollectors = ref.watch(yearCollectorsCountProvider);
    final totalCards = ref.watch(cardsCountProvider);
    final yearTotalCards = ref.watch(yearCardsCountProvider);
    final totalAgents = ref.watch(agentsCountProvider);
    final yearTotalAgents = ref.watch(yearAgentsCountProvider);
    final totalTypes = ref.watch(typesCountProvider);
    final yearTotalTypes = ref.watch(yearTypesCountProvider);
    final totalProducts = ref.watch(productsCountProvider);
    final yearTotalProducts = ref.watch(yearProductsCountProvider);
    final totalSettlements = ref.watch(settlementsCountProvider);
    final yearTotalSettlements = ref.watch(yearSettlementsCountProvider);
    final dayCollection = ref.watch(dayCollectionProvider);
    final weekCollection = ref.watch(weekCollectionProvider);
    final monthCollection = ref.watch(monthCollectionProvider);
    final yearCollection = ref.watch(yearCollectionProvider);

    return // *** GLOBAL VIEW ***
        Container(
      margin: const EdgeInsets.symmetric(
        vertical: 30.0,
      ),
      child: Column(
        children: [
          RSTIconButton(
            icon: Icons.refresh,
            text: 'Rafraîchir',
            onTap: () {
              ref.invalidate(collectionsSumProvider);
              ref.invalidate(yearCollectionsSumProvider);
              ref.invalidate(collectionsProfitProvider);
              ref.invalidate(yearCollectionsProfitProvider);
              ref.invalidate(collectionsRestSumProvider);
              ref.invalidate(dayCollectionsRestSumProvider);
              ref.invalidate(weekCollectionsRestSumProvider);
              ref.invalidate(monthCollectionsRestSumProvider);
              ref.invalidate(yearCollectionsRestSumProvider);
              ref.invalidate(customersCountProvider);
              ref.invalidate(yearCustomersCountProvider);
              ref.invalidate(collectorsCountProvider);
              ref.invalidate(yearCollectorsCountProvider);
              ref.invalidate(cardsCountProvider);
              ref.invalidate(yearCardsCountProvider);
              ref.invalidate(agentsCountProvider);
              ref.invalidate(yearAgentsCountProvider);
              ref.invalidate(settlementsCountProvider);
              ref.invalidate(yearSettlementsCountProvider);
              ref.invalidate(typesCountProvider);
              ref.invalidate(yearTypesCountProvider);
              ref.invalidate(productsCountProvider);
              ref.invalidate(yearProductsCountProvider);
              ref.invalidate(dayCollectionProvider);
              ref.invalidate(monthCollectionProvider);
              ref.invalidate(weekCollectionProvider);
              ref.invalidate(yearCollectionProvider);

              /* ref.invalidate(collectorsMonthlyCollectionsProvider);
              ref.invalidate(collectorsYearlyCollectionsProvider);
              ref.invalidate(customersTypesStatisticsDataStreamProvider);
              ref.invalidate(customersProductsStatisticsDataStreamProvider);
              ref.invalidate(productsForecastsStatisticsDataStreamProvider);
              ref.invalidate(
                searchProvider(
                  'products-forecasts-dashboard-settlements-number',
                ),
              );*/
            },
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const RSTText(
              text: 'Vue d\'ensemble',
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            height: .5,
            width: double.infinity,
            color: RSTColors.sidebarTextColor,
            margin: const EdgeInsets.only(
              top: 10.0,
              bottom: 17.0,
            ),
          ),
          Wrap(
            runSpacing: 10.0,
            spacing: 20.0,
            runAlignment: WrapAlignment.center,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              DashboardCard(
                label: 'Collecte',
                value: totalCollections.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
                isVisible: false,
              ),
              DashboardCard(
                label: 'Reste',
                value: totalCollectionsRest.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
                isVisible: false,
              ),
              DashboardCard(
                period: "Aujourd'hui",
                label: 'Collecte',
                value: dayCollection.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                period: "Aujourd'hui",
                label: 'Reste',
                value: dayTotalCollectionsRest.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                period: "Cette semaine",
                label: 'Collecte',
                value: weekCollection.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                period: "Cette semaine",
                label: 'Reste',
                value: weekTotalCollectionsRest.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                period: "Ce mois",
                label: 'Collecte',
                value: monthCollection.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                period: "Ce mois",
                label: 'Reste',
                value: monthTotalCollectionsRest.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                period: "Cette année",
                label: 'Collecte',
                value: yearCollection.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
                isVisible: false,
              ),
              DashboardCard(
                period: "Cette année",
                label: 'Reste',
                value: yearTotalCollectionsRest.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
                isVisible: false,
              ),
              DashboardCard(
                label: 'Compte',
                value: collectionsProfit.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) {
                    return 0;
                  },
                  loading: () => 0,
                ),
                ceil: true,
                isVisible: false,
              ),
              DashboardCard(
                period: "Cette année",
                label: 'Compte',
                value: yearCollectionsProfit.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) {
                    return 0;
                  },
                  loading: () => 0,
                ),
                ceil: true,
                isVisible: false,
              ),
              DashboardCard(
                label: 'Règlements',
                value: totalSettlements.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
                isVisible: false,
              ),
              DashboardCard(
                period: "Cette année",
                label: 'Règlements',
                value: yearTotalSettlements.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
                isVisible: false,
              ),
              DashboardCard(
                label: 'Clients',
                value: totalCustomers.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
                isVisible: false,
              ),
              DashboardCard(
                period: "Cette année",
                label: 'Clients',
                value: yearTotalCustomers.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Cartes',
                value: totalCards.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
                isVisible: false,
              ),
              DashboardCard(
                period: "Cette année",
                label: 'Cartes',
                value: yearTotalCards.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Agents',
                value: totalAgents.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                period: "Cette année",
                label: 'Agents',
                value: yearTotalAgents.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Collecteurs',
                value: totalCollectors.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                period: "Cette année",
                label: 'Collecteurs',
                value: yearTotalCollectors.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Types',
                value: totalTypes.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                period: "Cette année",
                label: 'Types',
                value: yearTotalTypes.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Produits',
                value: totalProducts.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                period: "Cette année",
                label: 'Produits',
                value: yearTotalProducts.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
