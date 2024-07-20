// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/activities/customer/providers/customers_activities.provider.dart';
import 'package:rst/modules/cash/cash_operations/functions/pdf/pdf_file.function.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class CustomerActivitiesPageHeader extends StatefulHookConsumerWidget {
  const CustomerActivitiesPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerActivitiesPageHeaderState();
}

class _CustomerActivitiesPageHeaderState
    extends ConsumerState<CustomerActivitiesPageHeader> {
  @override
  Widget build(BuildContext context) {
    final customerActivitiesSelectedCustomerCard = ref.watch(
      customerActivitiesSelectedCustomerCardProvider,
    );
    final authPermissions = ref.watch(authPermissionsProvider);
    final showPrintButton = useState(true);
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RSTIconButton(
                icon: Icons.refresh_outlined,
                text: 'Rafraichir',
                onTap: () {
                  // refresh providers counts and the customerActivities list
                  ref.invalidate(customerActivitiesSelectedCustomerProvider);
                  ref.invalidate(
                      customerActivitiesSelectedCustomerCardProvider);
                  ref.invalidate(
                      customerActivitiesSelectedCustomerCardsProvider);
                  ref.invalidate(
                      customerActivitiesSelectedCardSettlementsCountProvider);
                  ref.invalidate(
                      customerActivitiesSelectedCardSettlementsListParametersProvider);
                  ref.invalidate(
                      customerActivitiesSelectedCardSettlementsProvider);
                  ref.invalidate(
                      customerActivitiesSelectedCardSpecificSettlementsCountProvider);

                  ref.invalidate(
                    customerActivitiesSelectedCardTotalSettlementsNumbersProvider,
                  );
                  ref.invalidate(
                      customerActivitiesShowAllCustomerCardsProvider);
                },
              ),
              customerActivitiesSelectedCustomerCard != null &&
                      showPrintButton.value
                  ? authPermissions![PermissionsValues.admin] ||
                          authPermissions[PermissionsValues
                              .printCardSituationCustomersActivities]
                      ? RSTIconButton(
                          icon: Icons.print_outlined,
                          text: 'Imprimer',
                          onTap: () async {
                            // get customer cards selllements number
                            // because the number can not be knowed without
                            // asking the database
                            final customerCardsSettlementsNumberData =
                                await SettlementsController.countSpecific(
                              listParameters: {
                                'skip': 0, // This value is override in backend
                                'take':
                                    100, // This value is override in backend
                                'where': {
                                  'card': {
                                    'id': customerActivitiesSelectedCustomerCard
                                        .id!
                                        .toInt(),
                                  },
                                },
                                'orderBy': {
                                  'collection': {
                                    'collectedAt': 'asc',
                                  },
                                }
                              },
                            );

                            //generate pdf file
                            await generateCardSettlementsPdf(
                              context: context,
                              ref: ref,
                              card: customerActivitiesSelectedCustomerCard,
                              listParameters: {
                                'skip': 0,
                                'take': customerCardsSettlementsNumberData.data
                                    .count, // This value is override in backend
                                'where': {
                                  'card': {
                                    'id': customerActivitiesSelectedCustomerCard
                                        .id!
                                        .toInt(),
                                  },
                                },
                                'orderBy': {
                                  'collection': {
                                    'collectedAt': 'asc',
                                  },
                                }
                              },
                              showPrintButton: showPrintButton,
                              popAfterPrint: false,
                            );
                          },
                        )
                      : const SizedBox()
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
