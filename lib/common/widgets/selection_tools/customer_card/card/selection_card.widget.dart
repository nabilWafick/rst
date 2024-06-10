import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/dialog/selection_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CardSelectionToolCard extends StatefulHookConsumerWidget {
  final String toolName;
  final bool? enabled;
  final Card? card;
  final double? width;
  final int? textLimit;
  final RoundedStyle roundedStyle;

  const CardSelectionToolCard({
    super.key,
    required this.toolName,
    this.enabled,
    required this.roundedStyle,
    this.card,
    this.width,
    this.textLimit,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardSelectionToolCardState();
}

class _CardSelectionToolCardState extends ConsumerState<CardSelectionToolCard> {
  final focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    if (widget.card != null) {
      Future.delayed(
        const Duration(
          milliseconds: 100,
        ),
        () {
          ref.read(cardSelectionToolProvider(widget.toolName).notifier).state =
              widget.card;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedCard = ref.watch(cardSelectionToolProvider(widget.toolName));
    final focusOn = useState<bool>(false);
    double width = widget.width ?? 210;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: material.InkWell(
        onTap: widget.enabled == null || widget.enabled == true
            ? () async {
                // invalidate card selection list parameters
                ref.invalidate(cardsSelectionListParametersProvider);

                /// ****  CASH OPERARTIONS CARDS FILTERING **** ///
                // show only cards of the selected customer of cash operations (if his is selected)
                final cashOperationsSelectedCustomer =
                    ref.watch(customerSelectionToolProvider('cash-operations'));

                if (widget.toolName == 'cash-operations' &&
                    cashOperationsSelectedCustomer != null) {
                  ref
                      .read(cardsSelectionListParametersProvider(
                              'cash-operations')
                          .notifier)
                      .state = {
                    'skip': 0,
                    'take': 15,
                    'where': {
                      'AND': [
                        {
                          'customerId': cashOperationsSelectedCustomer.id,
                        },
                      ]
                    }
                  };
                }

                /// ****  CASH OPERARTIONS MULTIPLE SETTLEMENTS CARDS FILTERING **** ///
                // show only card that are not stored in multipleSettlementSelectedCards and are usable
                final multipleSettlementsSelectedCustomerCards =
                    ref.watch(multipleSettlementsSelectedCustomerCardsProvider);

                List<int> selectedCardIds =
                    multipleSettlementsSelectedCustomerCards.values
                        .toList()
                        .map(
                          (card) => card.id!,
                        )
                        .toList();

                if (widget.toolName.contains('multiple-settlement-input-') &&
                    cashOperationsSelectedCustomer != null) {
                  ref
                      .read(cardsSelectionListParametersProvider(
                        'multiple-settlement-input-${widget.toolName.split('multiple-settlement-input-').last}',
                      ).notifier)
                      .state = {
                    'skip': 0,
                    'take': 15,
                    'where': {
                      'AND': [
                        {
                          'id': {
                            'notIn': selectedCardIds,
                          },
                        },
                        {
                          'customerId': cashOperationsSelectedCustomer.id,
                        },
                        // null is transformed to correct null value in backend
                        {
                          'repaidAt': 'null',
                        },
                        {
                          'satisfiedAt': 'null',
                        },
                        {
                          'transferredAt': 'null',
                        }
                      ]
                    }
                  };
                }

                /// ****  TRANSFER BETWEEN CUSTOMER CARDS FILTERING **** ///
                // read the slected customer, issuing and rceiving card
                final transferBCCCustomer = ref.watch(
                    customerSelectionToolProvider('transfer-bcc-customer'));
                final transferBCCIssuingCard = ref.watch(
                  cardSelectionToolProvider('transfer-bcc-issuing-card'),
                );
                final transferBCCReceivingCard = ref.watch(
                    cardSelectionToolProvider('transfer-bcc-receiving-card'));

                if (transferBCCCustomer != null &&
                    (widget.toolName == 'transfer-bcc-issuing-card' ||
                        widget.toolName == 'transfer-bcc-receiving-card')) {
                  // filter issuing card list
                  ref
                      .read(cardsSelectionListParametersProvider(
                        'transfer-bcc-issuing-card',
                      ).notifier)
                      .state = {
                    'skip': 0,
                    'take': 15,
                    'where': {
                      'AND': [
                        {
                          'id': {
                            'not': transferBCCIssuingCard?.id ?? 0,
                          },
                        },
                        {
                          'customerId': transferBCCCustomer.id,
                        },
                        // null is transformed to correct null value in backend
                        {
                          'repaidAt': 'null',
                        },
                        {
                          'satisfiedAt': 'null',
                        },
                        {
                          'transferredAt': 'null',
                        }
                      ]
                    }
                  };

                  // filter receiving card list
                  ref
                      .read(cardsSelectionListParametersProvider(
                        'transfer-bcc-receiving-card',
                      ).notifier)
                      .state = {
                    'skip': 0,
                    'take': 15,
                    'where': {
                      'AND': [
                        {
                          'id': {
                            'not': transferBCCReceivingCard?.id ?? 0,
                          },
                        },
                        {
                          'customerId': transferBCCCustomer.id,
                        },
                        // null is transformed to correct null value in backend
                        {
                          'repaidAt': 'null',
                        },
                        {
                          'satisfiedAt': 'null',
                        },
                        {
                          'transferredAt': 'null',
                        }
                      ]
                    }
                  };
                }

                /// ****  TRANSFER BETWEEN CUSTOMERS CARDS FILTERING **** ///
                // read the slected customer, issuing and rceiving card
                final transferBCIssuingCustomer = ref.watch(
                    customerSelectionToolProvider(
                        'transfer-bc-issuing-customer'));

                final transferBCReceivingCustomer = ref.watch(
                    customerSelectionToolProvider(
                        'transfer-bc-receiving-customer'));
                final transferBCIssuingCard = ref.watch(
                  cardSelectionToolProvider('transfer-bc-issuing-card'),
                );
                final transferBCReceivingCard = ref.watch(
                    cardSelectionToolProvider('transfer-bc-receiving-card'));

                // filter issuing customer card
                if (transferBCIssuingCustomer != null &&
                    (widget.toolName == 'transfer-bc-issuing-card')) {
                  // filter issuing card list
                  ref
                      .read(cardsSelectionListParametersProvider(
                        'transfer-bc-issuing-card',
                      ).notifier)
                      .state = {
                    'skip': 0,
                    'take': 15,
                    'where': {
                      'AND': [
                        {
                          'id': {
                            'not': transferBCIssuingCard?.id ?? 0,
                          },
                        },
                        {
                          'customerId': transferBCIssuingCustomer.id,
                        },
                        // null is transformed to correct null value in backend
                        {
                          'repaidAt': 'null',
                        },
                        {
                          'satisfiedAt': 'null',
                        },
                        {
                          'transferredAt': 'null',
                        }
                      ]
                    }
                  };
                }

                // filter receiving customer card
                if (transferBCReceivingCustomer != null &&
                    (widget.toolName == 'transfer-bc-receiving-card')) {
                  // filter receiving card list
                  ref
                      .read(cardsSelectionListParametersProvider(
                        'transfer-bc-receiving-card',
                      ).notifier)
                      .state = {
                    'skip': 0,
                    'take': 15,
                    'where': {
                      'AND': [
                        {
                          'id': {
                            'not': transferBCReceivingCard?.id ?? 0,
                          },
                        },
                        {
                          'customerId': transferBCReceivingCustomer.id,
                        },
                        // null is transformed to correct null value in backend
                        {
                          'repaidAt': 'null',
                        },
                        {
                          'satisfiedAt': 'null',
                        },
                        {
                          'transferredAt': 'null',
                        }
                      ]
                    }
                  };
                }

                FunctionsController.showAlertDialog(
                  context: context,
                  alertDialog: CardSelectionDialog(
                    toolName: widget.toolName,
                  ),
                );
              }
            : null,
        splashColor: RSTColors.primaryColor.withOpacity(.05),
        hoverColor: material.Colors.transparent,
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: .5,
              color: focusOn.value
                  ? RSTColors.primaryColor
                  : RSTColors.tertiaryColor,
            ),
            borderRadius: widget.roundedStyle == RoundedStyle.full
                ? BorderRadius.circular(15.0)
                : widget.roundedStyle == RoundedStyle.none
                    ? BorderRadius.circular(.0)
                    : BorderRadius.only(
                        topLeft: Radius.circular(
                          widget.roundedStyle == RoundedStyle.onlyLeft
                              ? 15.0
                              : 0,
                        ),
                        bottomLeft: Radius.circular(
                          widget.roundedStyle == RoundedStyle.onlyLeft
                              ? 15.0
                              : 0,
                        ),
                        topRight: Radius.circular(
                          widget.roundedStyle == RoundedStyle.onlyRight
                              ? 15.0
                              : 0,
                        ),
                        bottomRight: Radius.circular(
                          widget.roundedStyle == RoundedStyle.onlyRight
                              ? 15.0
                              : 0,
                        ),
                      ),
          ),
          child: Row(
            children: [
              material.InkWell(
                onTap: () {
                  ref.invalidate(cardSelectionToolProvider(widget.toolName));
                },
                child: Icon(
                  material.Icons.credit_card,
                  size: 15,
                  color: focusOn.value
                      ? RSTColors.primaryColor
                      : RSTColors.tertiaryColor,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              RSTText(
                text: FunctionsController.truncateText(
                  text: selectedCard != null ? selectedCard.label : 'Carte',
                  maxLength: widget.textLimit ?? 15,
                ),
                fontSize: 10.0,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
