import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/definitions/types/models/type/type.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class TransferIssuingCardBox extends StatefulHookConsumerWidget {
  final String transferName;

  const TransferIssuingCardBox({
    super.key,
    required this.transferName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TransferIssuingCardBoxState();
}

class _TransferIssuingCardBoxState
    extends ConsumerState<TransferIssuingCardBox> {
  @override
  Widget build(BuildContext context) {
    final cardOwner = ref.watch(
      customerSelectionToolProvider(
        widget.transferName == 'transfer-bcc'
            ? '${widget.transferName}-customer'
            : '${widget.transferName}-issuing-customer',
      ),
    );
    final issuingCard = ref.watch(
        cardSelectionToolProvider('${widget.transferName}-issuing-card'));
    final receivingCard = ref.watch(
        cardSelectionToolProvider('${widget.transferName}-receiving-card'));
    final issuingCardTotalSettlementsNumber = useState<int>(0);
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 50.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 25.0,
            ),
            padding: const EdgeInsetsDirectional.all(
              15.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: RSTColors.sidebarTextColor,
                width: .5,
              ),
              borderRadius: BorderRadius.circular(
                15.0,
              ),
            ),
            width: 500.0,
            child: Column(
              children: [
                const RSTText(
                  text: 'Compte Émetteur',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 25.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardSelectionToolCard(
                      enabled: cardOwner != null,
                      toolName: '${widget.transferName}-issuing-card',
                      roundedStyle: RoundedStyle.full,
                    ),
                    TypeBox(
                      customerCardType: issuingCard != null
                          ? issuingCard.type
                          : Type(
                              name: 'Type *',
                              stake: 1,
                              typeProducts: [],
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            ),
                    )
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 25.0,
                  ),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20.0,
                    //  crossAxisSpacing: ,
                    children: [
                      LabelValue(
                        label: 'Nombre Type',
                        value: issuingCard != null
                            ? issuingCard.typesNumber.toString()
                            : '',
                      ),
                      LabelValue(
                        label: 'Mise Type',
                        value: issuingCard != null
                            ? issuingCard.type.stake.toInt().toString()
                            : '',
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          if (issuingCard != null) {
                            Future.delayed(
                              const Duration(
                                milliseconds: 100,
                              ),
                              () async {
                                final numberData = await SettlementsController
                                    .sumOfNumberForCard(
                                  cardId: issuingCard.id!,
                                );

                                issuingCardTotalSettlementsNumber.value =
                                    numberData.data.count;
                              },
                            );
                          }
                          return LabelValue(
                            label: 'Total Règlements',
                            value: issuingCard != null
                                ? issuingCardTotalSettlementsNumber.value
                                    .toString()
                                : '',
                          );
                        },
                      ),
                      Consumer(
                        builder: (context, ref, child) {
                          final amount = issuingCard != null
                              ? issuingCard.typesNumber *
                                  issuingCardTotalSettlementsNumber.value *
                                  issuingCard.type.stake.toInt()
                              : 0;

                          return LabelValue(
                            label: 'Montant Réglé',
                            value: issuingCard != null
                                ? amount > 0
                                    ? '${amount}f'
                                    : '0f'
                                : '',
                          );
                        },
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RSTText(
                      text: 'Montant à transférer: ',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    // the amount to transfer is equal to customer card total amount *2/3 - 300. 300 for customerCard fee
                    Consumer(
                      builder: (context, ref, child) {
                        final amount = issuingCard != null &&
                                receivingCard != null
                            ? (2 *
                                        (issuingCard.typesNumber *
                                            issuingCardTotalSettlementsNumber
                                                .value *
                                            issuingCard.type.stake) /
                                        3)
                                    .round() -
                                300
                            : 0;

                        return RSTText(
                          text: issuingCard != null && receivingCard != null
                              ? amount > 0
                                  ? '${amount}f'
                                  : '0f'
                              : '',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
