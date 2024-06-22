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
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardOverviewState();
}

class _DashboardOverviewState extends ConsumerState<DashboardOverview> {
  @override
  Widget build(BuildContext context) {
    final totalCollections = ref.watch(collectionsSumProvider);
    final totalCollectionsRest = ref.watch(collectionsRestSumProvider);
    final totalCustomer = ref.watch(customersCountProvider);
    final totalCollectors = ref.watch(collectorsCountProvider);
    final totalCards = ref.watch(cardsCountProvider);
    final totalAgents = ref.watch(agentsCountProvider);
    final totalTypes = ref.watch(typesCountProvider);
    final totalProducts = ref.watch(productsCountProvider);
    final totalSettlements = ref.watch(settlementsCountProvider);
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
              ref.invalidate(collectionsRestSumProvider);
              ref.invalidate(customersCountProvider);
              ref.invalidate(collectorsCountProvider);
              ref.invalidate(cardsCountProvider);
              ref.invalidate(agentsCountProvider);
              ref.invalidate(settlementsCountProvider);
              ref.invalidate(typesCountProvider);
              ref.invalidate(productsCountProvider);
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
                label: 'Collectes',
                value: totalCollections.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Restes',
                value: totalCollectionsRest.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
              ),
              DashboardCard(
                label: 'Collecte Journalière',
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
                label: 'Collecte Hebdomadaire',
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
                label: 'Collecte Mensuelle',
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
                label: 'Collecte Annuelle',
                value: yearCollection.when(
                  data: (data) {
                    return data;
                  },
                  error: (error, stackTrace) => 0,
                  loading: () => 0,
                ),
                ceil: true,
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
              ),
              DashboardCard(
                label: 'Clients',
                value: totalCustomer.when(
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
            ],
          )
        ],
      ),
    );
  }
}
