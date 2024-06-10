import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/transfers/models/transfer/transfer.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class TransferSimpleView extends ConsumerWidget {
  final Transfer transfer;
  const TransferSimpleView({
    super.key,
    required this.transfer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formtransferWidth = 500.0;

    final format = DateFormat.yMMMMEEEEd('fr');
    return material.AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 5.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Transfert',
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          material.IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              material.Icons.close_rounded,
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
        width: formtransferWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Client Émetteur',
                value:
                    '${transfer.issuingCard.customer.name} ${transfer.issuingCard.customer.firstnames}',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Carte Émettrice',
                value: transfer.issuingCard.label,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Type',
                value: transfer.issuingCard.type.name,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Client Récepteur',
                value:
                    '${transfer.receivingCard.customer.name} ${transfer.receivingCard.customer.firstnames}',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Carte Réceptrice',
                value: transfer.receivingCard.label,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Type',
                value: transfer.receivingCard.type.name,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Validation',
                value: transfer.validatedAt != null
                    ? format.format(
                        transfer.validatedAt!,
                      )
                    : '',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Rejet',
                value: transfer.rejectedAt != null
                    ? format.format(
                        transfer.rejectedAt!,
                      )
                    : '',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Client Récepteur',
                value: '${transfer.agent.name} ${transfer.agent.firstnames}',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Insertion',
                value: format.format(transfer.createdAt),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Dernière Modification',
                value: format.format(transfer.updatedAt),
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
