import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CardBox extends ConsumerWidget {
  final Card card;
  const CardBox({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCustomerCard =
        ref.watch(cashOperationsSelectedCustomerCardProvider);
    return material.Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(
          color: RSTColors.primaryColor,
        ),
      ),
      elevation: 7.0,
      color: selectedCustomerCard!.id == card.id
          ? material.Colors.white
          : RSTColors.primaryColor,
      child: material.InkWell(
        onTap: () async {
          ref
              .read(cardSelectionToolProvider('cash-operations').notifier)
              .state = card;
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: RSTText(
              text: card.label,

              // sidebarSubOptionData.name
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: selectedCustomerCard.id == card.id
                  ? RSTColors.primaryColor
                  : material.Colors.white,
            )),
      ),
    );
  }
}
