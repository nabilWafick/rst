import 'package:rst/modules/statistics/types_stat/models/types_stat.model.dart';

List<CollectorStatType> performTypeStatsData(
    {required double typeStake, required List<CardStatType> cardsStat}) {
  List<CollectorStatType> collectorsStats = [];

  List<CustomerStatType> customersStatsData = [];

  for (int i = 0; i < cardsStat.length; i++) {
    int totalSettlementNumber = 0;

    // calculate the total of settlements number
    for (int j = 0; j < cardsStat[i].settlements.length; j++) {
      totalSettlementNumber += cardsStat[i].settlements[j].number;
    }

    // instanciate customer card data
    final customerStat = CustomerStatType(
      customer: cardsStat[i].customer,
      cardData: CardDataStatType(
        label: cardsStat[i].label,
        typesNumber: cardsStat[i].typesNumber,
        totalSettlementNumber: totalSettlementNumber,
        totalSettlementAmount:
            cardsStat[i].typesNumber * totalSettlementNumber * typeStake,
      ),
    );

    // add new customer data
    customersStatsData.add(customerStat);
    if (i + 1 != cardsStat.length) {
      if (cardsStat[i].customer.collector! !=
          cardsStat[i + 1].customer.collector!) {
        collectorsStats.add(
          CollectorStatType(
            collector: cardsStat[i].customer.collector!,
            customersStats: List.from(customersStatsData),
          ),
        );

        // clear customers data list
        customersStatsData.clear();
      }
    } else {
      collectorsStats.add(
        CollectorStatType(
          collector: cardsStat[i].customer.collector!,
          customersStats: List.from(customersStatsData),
        ),
      );

      // clear customers data list
      customersStatsData.clear();
    }
  }

  // return customers data per collector
  return collectorsStats;
}
