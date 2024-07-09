import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/cash/settlements/models/settlements.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class SettlementSimpleView extends ConsumerWidget {
  final Settlement settlement;
  const SettlementSimpleView({
    super.key,
    required this.settlement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;

    final format = DateFormat.yMMMMEEEEd('fr');
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 5.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Règlement',
            fontSize: 20.0,
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
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Carte',
                value: settlement.card.label.toString(),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Nombre',
                value: settlement.number.toString(),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Montant',
                value:
                    '${(settlement.card.typesNumber * settlement.number * settlement.card.type.stake).toInt()}f',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Est Validé',
                value: settlement.isValidated ? 'Oui' : 'Non',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Client',
                value:
                    '${settlement.card.customer.name} ${settlement.card.customer.firstnames}',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Agent',
                value:
                    '${settlement.agent.name} ${settlement.agent.firstnames}',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Insertion',
                value: format.format(settlement.createdAt),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Dernière Modification',
                value: format.format(settlement.updatedAt),
              ),
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: 170.0,
          child: RSTElevatedButton(
            text: 'Fermer',
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
