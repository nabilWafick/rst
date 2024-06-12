import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/stocks/stocks/models/stocks.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class StockSimpleView extends ConsumerWidget {
  final Stock stock;
  const StockSimpleView({
    super.key,
    required this.stock,
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
            text: 'Stock',
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
                label: 'Produit',
                value: stock.product.name.toString(),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Quantité Initiale',
                value: stock.initialQuantity.toString(),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Quantité Stock',
                value: stock.stockQuantity.toString(),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Quantité Entrée',
                value: stock.inputQuantity?.toString() ?? '',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Quantité Sortie',
                value: stock.outputQuantity?.toString() ?? '',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Type Mouvement',
                value: stock.movementType?.toString() ?? '',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Carte',
                value: stock.card?.label ?? '',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Type',
                value: stock.card?.type.name ?? '',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Client',
                value: stock.card != null
                    ? '${stock.card!.customer.name} ${stock.card!.customer.firstnames}'
                    : '',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Agent',
                value: '${stock.agent.name} ${stock.agent.firstnames}',
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Insertion',
                value: format.format(stock.createdAt),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Dernière Modification',
                value: format.format(stock.updatedAt),
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
