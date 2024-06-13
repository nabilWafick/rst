import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/card_box/card_box.widget.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/customer/card/selection_card.widget.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/modules/activities/customer/functions/listeners/listeners.functions.dart';
import 'package:rst/modules/activities/customer/providers/customers_activities.provider.dart';

class CustomerActivitiesPageBody extends StatefulHookConsumerWidget {
  const CustomerActivitiesPageBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerActivitiesPageBodyState();
}

class _CustomerActivitiesPageBodyState
    extends ConsumerState<CustomerActivitiesPageBody> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(customerSelectionToolProvider('customer-activities'),
        (previous, next) {
      onCustomerActivitiesCustomerChange(
        ref: ref,
        previousCustomer: previous,
        newCustomer: next,
      );
    });

    ref.listen(customerActivitiesSelectedCustomerCardProvider,
        (previous, next) {
      onCustomerActivitiesCustomerCardChange(
        ref: ref,
        previousCustomerCard: previous,
        newCustomerCard: next,
      );
    });

    final customerActivitiesSelectedCustomer =
        ref.watch(customerSelectionToolProvider('customer-activities'));

    final customerActivitiesSelectedCustomerCard = ref.watch(
      customerActivitiesSelectedCustomerCardProvider,
    );

    final customerActivitiesSelectedCustomerCards = ref.watch(
      customerActivitiesSelectedCustomerCardsProvider,
    );

    final customerActivitiesSelectedCardTotalSettlementsNumbers = ref
        .watch(customerActivitiesSelectedCardTotalSettlementsNumbersProvider);

    final customerActivitiesShowAllCustomerCards =
        ref.watch(customerActivitiesShowAllCustomerCardsProvider);

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 25.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Center(
            child: CustomerSelectionToolCard(
              toolName: 'customer-activities',
              width: 400.0,
              roundedStyle: RoundedStyle.full,
              textLimit: 45,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const RSTText(
                      text: 'Cartes: ',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .65,
                      height: 40.0,
                      child: HorizontalScroller(
                        children: customerActivitiesSelectedCustomer == null ||
                                customerActivitiesSelectedCustomerCard == null
                            ? []
                            : customerActivitiesSelectedCustomerCards
                                .where(
                                  (customerCard) {
                                    return customerActivitiesShowAllCustomerCards
                                        ? customerCard == customerCard
                                        : customerCard.satisfiedAt == null &&
                                            customerCard.repaidAt == null &&
                                            customerCard.transferredAt == null;
                                  },
                                )
                                .map(
                                  (customerCard) => CardBox(
                                    card: customerCard,
                                    selectedCustomerCardProvider:
                                        customerActivitiesSelectedCustomerCardProvider,
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 220.0,
                  child: CheckboxListTile(
                    value: ref.watch(
                      customerActivitiesShowAllCustomerCardsProvider,
                    ),
                    title: const RSTText(
                      text: 'Toutes les cartes',
                      fontSize: 12,
                    ),
                    hoverColor: Colors.transparent,
                    onChanged: (value) {
                      ref
                          .read(
                            customerActivitiesShowAllCustomerCardsProvider
                                .notifier,
                          )
                          .state = value!;
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 25.0,
            ),
            child: Wrap(
              runSpacing: 20.0,
              spacing: 200.0,
              runAlignment: WrapAlignment.center,
              children: [
                LabelValue(
                  label: 'Carte',
                  value: customerActivitiesSelectedCustomerCard != null
                      ? customerActivitiesSelectedCustomerCard.label
                      : '',
                ),
                LabelValue(
                  label: 'Nombre Types',
                  value: customerActivitiesSelectedCustomerCard != null
                      ? customerActivitiesSelectedCustomerCard.typesNumber
                          .toString()
                      : '',
                ),
                LabelValue(
                  label: 'Type',
                  value: customerActivitiesSelectedCustomerCard != null
                      ? customerActivitiesSelectedCustomerCard.type.name
                      : '',
                ),
                LabelValue(
                  label: 'Mise',
                  value: customerActivitiesSelectedCustomerCard != null
                      ? '${customerActivitiesSelectedCustomerCard.type.stake.toInt()}f'
                      : '',
                ),
                LabelValue(
                  label: 'Total Règlements',
                  value: customerActivitiesSelectedCustomerCard != null
                      ? '372'
                      : '',
                ),
                LabelValue(
                  label: 'Règlements Effectués',
                  value: customerActivitiesSelectedCustomerCard != null
                      ? customerActivitiesSelectedCardTotalSettlementsNumbers
                          .when(
                          data: (data) => data.toString(),
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
                LabelValue(
                  label: 'Montant Payé',
                  value: customerActivitiesSelectedCustomerCard != null
                      ? customerActivitiesSelectedCardTotalSettlementsNumbers
                          .when(
                          data: (data) =>
                              '${(customerActivitiesSelectedCustomerCard.typesNumber * customerActivitiesSelectedCustomerCard.type.stake * data).toInt()}f',
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
                LabelValue(
                  label: 'Règlements Restants',
                  value: customerActivitiesSelectedCustomerCard != null
                      ? customerActivitiesSelectedCardTotalSettlementsNumbers
                          .when(
                          data: (data) => (372 - data).toString(),
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
                LabelValue(
                  label: 'Reste à Payer',
                  value: customerActivitiesSelectedCustomerCard != null
                      ? customerActivitiesSelectedCardTotalSettlementsNumbers
                          .when(
                          data: (data) =>
                              '${((372 - data) * customerActivitiesSelectedCustomerCard.typesNumber * customerActivitiesSelectedCustomerCard.type.stake).toInt()}f',
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
