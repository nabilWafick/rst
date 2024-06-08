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

                // show only cards of the selected customer of cash operations (if his is seleclected)
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

                FunctionsController.showAlertDialog(
                  context: context,
                  alertDialog: CardSelectionDialog(toolName: widget.toolName),
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
                  material.Icons.supervised_user_circle_outlined,
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
