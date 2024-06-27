// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/cash/cash_operations/functions/pdf/pdf_file.function.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/card_settlements/body/body.widget.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/card_settlements/footer/footer.widget.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/card_settlements/providers/card_settlements.provider.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CardSettlementsOverview extends StatefulHookConsumerWidget {
  const CardSettlementsOverview({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardSettlementsOverviewState();
}

class _CardSettlementsOverviewState
    extends ConsumerState<CardSettlementsOverview> {
  @override
  Widget build(BuildContext context) {
    const formCardWidth = 1032.0;

    final showPrintButton = useState(true);

    final cashOperationsSelectedCustomerCard =
        ref.watch(cashOperationsSelectedCustomerCardProvider);
    final cashOperationsSelectedCustomer =
        ref.watch(cashOperationsSelectedCustomerProvider);

    final authPermissions = ref.watch(authPermissionsProvider);
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Situation du client',
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close_rounded,
              color: RSTColors.primaryColor,
              size: 30.0,
            ),
          ),
        ],
      ),
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              child: LabelValue(
                label: 'Client',
                value:
                    '${cashOperationsSelectedCustomer!.name} ${cashOperationsSelectedCustomer.firstnames}',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelValue(
                  label: 'Carte',
                  value: cashOperationsSelectedCustomerCard!.label,
                ),
                LabelValue(
                  label: 'Nombre Type',
                  value:
                      cashOperationsSelectedCustomerCard.typesNumber.toString(),
                )
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelValue(
                  label: 'Type',
                  value: cashOperationsSelectedCustomerCard.type.name,
                ),
                LabelValue(
                  label: 'Mise',
                  value:
                      '${cashOperationsSelectedCustomerCard.type.stake.toInt()}f',
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              alignment: Alignment.center,
              child: RSTIconButton(
                icon: Icons.refresh,
                text: 'Rafraichir',
                onTap: () async {
                  ref.invalidate(cardSettlementsOverviewListParametersProvider);
                  ref.invalidate(cardSettlementsOverviewProvider);
                  ref.invalidate(cardSettlementsOverviewCountProvider);
                  ref.invalidate(
                      cardSettlementsOverviewSpecificSettlementsCountProvider);
                },
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 350.0,
              margin: const EdgeInsets.only(top: 30.0),
              child: const Column(
                children: [
                  CardSettlementsOverviewBody(),
                  CardSettlementsOverviewFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 170.0,
              child: RSTElevatedButton(
                text: 'Fermer',
                backgroundColor: RSTColors.sidebarTextColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            showPrintButton.value
                ? authPermissions![PermissionsValues.admin] ||
                        authPermissions[
                            PermissionsValues.printCardSituationCash]
                    ? SizedBox(
                        width: 170.0,
                        child: RSTElevatedButton(
                          text: 'Imprimer',
                          onPressed: () async {
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
                                    'id': cashOperationsSelectedCustomerCard.id!
                                        .toInt(),
                                  },
                                },
                              },
                            );

                            //generate pdf file
                            await generateCardSettlementsPdf(
                              context: context,
                              ref: ref,
                              card: cashOperationsSelectedCustomerCard,
                              listParameters: {
                                'skip': 0,
                                'take': customerCardsSettlementsNumberData.data
                                    .count, // This value is override in backend
                                'where': {
                                  'card': {
                                    'id': cashOperationsSelectedCustomerCard.id!
                                        .toInt(),
                                  },
                                },
                              },
                              showPrintButton: showPrintButton,
                            );
                          },
                        ),
                      )
                    : const SizedBox()
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
