import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/card_settlements/card_settlements.widget.dart';
import 'package:rst/modules/cash/cash_operations/views/widgets/infos/card/card_box/card_box.widget.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/cash/settlements/views/widgets/settlements.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CashOperationsCustomerCardInfos extends ConsumerStatefulWidget {
  final double width;
  const CashOperationsCustomerCardInfos({super.key, required this.width});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashOperationsCustomerCardInfosState();
}

class _CashOperationsCustomerCardInfosState
    extends ConsumerState<CashOperationsCustomerCardInfos> {
  @override
  void initState() {
    initializeDateFormatting('fr');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cashOperationsSelectedCustomer =
        ref.watch(cashOperationsSelectedCustomerProvider);
    final cashOperationsSelectedCustomerCard =
        ref.watch(cashOperationsSelectedCustomerCardProvider);
    /*  final cashOperationsSelectedCollector =
        ref.watch(cashOperationsSelectedCollectorProvider);*/
    final cashOperationsSelectedCustomerCards =
        ref.watch(cashOperationsSelectedCustomerCardsProvider);
    final cashOperationsShowAllCustomerCards =
        ref.watch(cashOperationsShowAllCustomerCardsProvider);

    final cashOperationsSelectedCardTotalSettlementsNumbers =
        ref.watch(cashOperationsSelectedCardTotalSettlementsNumbersProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return Container(
      padding: const EdgeInsets.all(15.0),
      width: widget.width,
      height: 440.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          15.0,
        ),
        border: Border.all(
          color: RSTColors.sidebarTextColor.withOpacity(.5),
          width: 1.5,
        ),
      ),
      child: Column(
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
                width: widget.width * .85,
                height: 40.0,
                child: HorizontalScroller(
                  children: cashOperationsSelectedCustomer == null ||
                          cashOperationsSelectedCustomerCard == null
                      ? []
                      : cashOperationsSelectedCustomerCards
                          .where(
                            (customerCard) {
                              return cashOperationsShowAllCustomerCards
                                  ? customerCard == customerCard
                                  : customerCard.satisfiedAt == null &&
                                      customerCard.repaidAt == null &&
                                      customerCard.transferredAt == null;
                            },
                          )
                          .map(
                            (customerCard) => CardBox(
                              card: customerCard,
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          ),
          SizedBox(
            width: widget.width,
            child: Wrap(
              runSpacing: 20.0,
              spacing: 20.0,
              runAlignment: WrapAlignment.center,
              children: [
                LabelValue(
                  label: 'Carte',
                  value: cashOperationsSelectedCustomerCard != null
                      ? cashOperationsSelectedCustomerCard.label
                      : '',
                ),
                LabelValue(
                  label: 'Nombre Types',
                  value: cashOperationsSelectedCustomerCard != null
                      ? cashOperationsSelectedCustomerCard.typesNumber
                          .toString()
                      : '',
                ),
                LabelValue(
                  label: 'Type',
                  value: cashOperationsSelectedCustomerCard != null
                      ? cashOperationsSelectedCustomerCard.type.name
                      : '',
                ),
                LabelValue(
                  label: 'Mise',
                  value: cashOperationsSelectedCustomerCard != null
                      ? '${cashOperationsSelectedCustomerCard.type.stake.toInt()}f'
                      : '',
                ),
                LabelValue(
                  label: 'Total Règlements',
                  value:
                      cashOperationsSelectedCustomerCard != null ? '372' : '',
                ),
                LabelValue(
                  label: 'Règlements Effectués',
                  value: cashOperationsSelectedCustomerCard != null
                      ? cashOperationsSelectedCardTotalSettlementsNumbers.when(
                          data: (data) => data.toString(),
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
                LabelValue(
                  label: 'Montant Payé',
                  value: cashOperationsSelectedCustomerCard != null
                      ? cashOperationsSelectedCardTotalSettlementsNumbers.when(
                          data: (data) =>
                              '${(cashOperationsSelectedCustomerCard.typesNumber * cashOperationsSelectedCustomerCard.type.stake * data).toInt()}f',
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
                LabelValue(
                  label: 'Règlements Restants',
                  value: cashOperationsSelectedCustomerCard != null
                      ? cashOperationsSelectedCardTotalSettlementsNumbers.when(
                          data: (data) => (372 - data).toString(),
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
                LabelValue(
                  label: 'Reste à Payer',
                  value: cashOperationsSelectedCustomerCard != null
                      ? cashOperationsSelectedCardTotalSettlementsNumbers.when(
                          data: (data) =>
                              '${((372 - data) * cashOperationsSelectedCustomerCard.typesNumber * cashOperationsSelectedCustomerCard.type.stake).toInt()}f',
                          error: (error, stackTrace) => '',
                          loading: () => '',
                        )
                      : '',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: material.SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: .0,
                        vertical: .0,
                      ),
                      splashRadius: .0,
                      value: cashOperationsSelectedCustomerCard != null
                          ? cashOperationsSelectedCustomerCard.repaidAt != null
                          : false,
                      title: const RSTText(
                        text: 'Remboursée',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      hoverColor: material.Colors.transparent,
                      onChanged: (value) async {},
                    ),
                  ),
                  LabelValue(
                    label: 'Date de Remboursement',
                    value: cashOperationsSelectedCustomerCard != null &&
                            cashOperationsSelectedCustomerCard.repaidAt != null
                        ? format.format(
                            cashOperationsSelectedCustomerCard.repaidAt!,
                          )
                        : '',
                    isColumnFormat: true,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: material.SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: .0,
                        vertical: .0,
                      ),
                      splashRadius: .0,
                      value: cashOperationsSelectedCustomerCard != null
                          ? cashOperationsSelectedCustomerCard.satisfiedAt !=
                              null
                          : false,
                      title: const RSTText(
                        text: 'Satisfaite',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      hoverColor: material.Colors.transparent,
                      onChanged: (value) async {},
                    ),
                  ),
                  LabelValue(
                    label: 'Date de Satisfaction',
                    value: cashOperationsSelectedCustomerCard != null &&
                            cashOperationsSelectedCustomerCard.satisfiedAt !=
                                null
                        ? format.format(
                            cashOperationsSelectedCustomerCard.satisfiedAt!,
                          )
                        : '',
                    isColumnFormat: true,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250.0,
                    child: material.SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: .0,
                        vertical: .0,
                      ),
                      splashRadius: .0,
                      value: cashOperationsSelectedCustomerCard != null
                          ? cashOperationsSelectedCustomerCard.transferredAt !=
                              null
                          : false,
                      title: const RSTText(
                        text: 'Transférée',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      hoverColor: material.Colors.transparent,
                      onChanged: (value) async {},
                    ),
                  ),
                  LabelValue(
                    label: 'Date de Transfert',
                    value: cashOperationsSelectedCustomerCard != null &&
                            cashOperationsSelectedCustomerCard.transferredAt !=
                                null
                        ? format.format(
                            cashOperationsSelectedCustomerCard.transferredAt!,
                          )
                        : '',
                    isColumnFormat: true,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RSTIconButton(
                icon: material.Icons.book,
                text: 'Situation du client',
                onTap: cashOperationsSelectedCustomer != null &&
                        cashOperationsSelectedCustomerCard != null
                    ? () async {
                        await FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const CardSettlementsOverview(),
                        );
                      }
                    : () {},
              ),
              RSTIconButton(
                icon: material.Icons.add_circle,
                text: 'Ajouter un règlement',
                onTap: () {
                  ref.read(settlementNumberProvider.notifier).state = 0;
                  ref.read(settlementCollectionDateProvider.notifier).state =
                      null;
                  ref
                      .read(settlementCollectorCollectionProvider.notifier)
                      .state = null;
                  cashOperationsSelectedCustomerCard != null
                      ? FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const SettlementAdditionForm(),
                        )
                      : () {};
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
