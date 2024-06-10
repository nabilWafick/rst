import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/dialog/body/body.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/dialog/footer/footer.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CardSelectionDialog extends StatefulHookConsumerWidget {
  final String toolName;
  const CardSelectionDialog({
    super.key,
    required this.toolName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardSelectionDialogState();
}

class _CardSelectionDialogState extends ConsumerState<CardSelectionDialog> {
  @override
  Widget build(BuildContext context) {
    const dialogWidth = 900.0;
    const dialogHeight = 500.0;
    final selectedCard = ref.watch(cardSelectionToolProvider(widget.toolName));
    return AlertDialog(
      /*   contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),*/
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Cartes',
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
        padding: const EdgeInsets.all(10.0),
        /*margin: const EdgeInsets.symmetric(
          vertical: 15.0,
        ),*/
        width: dialogWidth,
        height: dialogHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const RSTText(
                    text: 'Carte sélectionnée: ',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                  RSTText(
                    text: selectedCard != null ? selectedCard.label : '',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            CardSelectionDialogBody(
              toolName: widget.toolName,
            ),
            const SizedBox(
              height: 15.0,
            ),
            CardSelectionDialogFooter(
              toolName: widget.toolName,
            ),
          ],
        ),
      ),
    );
  }
}
