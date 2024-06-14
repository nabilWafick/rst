import 'package:rst/modules/statistics/types_stat/models/card_data_stat/card_data_stat.model.dart';
import 'package:rst/modules/statistics/types_stat/models/card_stat/card_stat.model.dart';
import 'package:rst/modules/statistics/types_stat/models/collector_stat/collector_stat.model.dart';
import 'package:rst/modules/statistics/types_stat/models/customer_stat/customer_stat.model.dart';

List<CollectorStat> performTypeStatsData(
    {required double typeStake, required List<CardStat> cardsStat}) {
  List<CollectorStat> collectorsStats = [];

  List<CustomerStat> customersStatsData = [];

  for (int i = 0; i < cardsStat.length; i++) {
    int totalSettlementNumber = 0;

    // calculate the total of settlements number
    for (int j = 0; j < cardsStat[i].settlements.length; j++) {
      totalSettlementNumber += cardsStat[i].settlements[j].number;
    }

    // instanciate customer card data
    final customerStat = CustomerStat(
      customer: cardsStat[i].customer,
      cardData: CardDataStat(
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
          CollectorStat(
            collector: cardsStat[i].customer.collector!,
            customersStats: List.from(customersStatsData),
          ),
        );

        // clear customers data list
        customersStatsData.clear();
      }
    } else {
      collectorsStats.add(
        CollectorStat(
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
