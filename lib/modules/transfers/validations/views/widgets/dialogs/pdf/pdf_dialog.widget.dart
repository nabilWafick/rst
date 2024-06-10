// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/transfers/controllers/transfers.controller.dart';
import 'package:rst/modules/transfers/validations/functions/pdf/pdf_file.function.dart';
import 'package:rst/modules/transfers/validations/providers/validations.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class TransferPdfGenerationDialog extends HookConsumerWidget {
  const TransferPdfGenerationDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final exportAllTransfers = useState<bool>(false);
    final exportSelectionnedTransfers = useState<bool>(true);
    final showPrintButton = useState<bool>(true);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Impression',
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
          vertical: 25.0,
        ),
        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SwitchListTile(
              value: exportAllTransfers.value,
              title: const RSTText(
                text: 'Tout',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportAllTransfers.value = value;
                  exportSelectionnedTransfers.value = !value;
                } else {
                  exportAllTransfers.value = value;
                  exportSelectionnedTransfers.value = !value;
                }
              },
            ),
            SwitchListTile(
              value: exportSelectionnedTransfers.value,
              title: const RSTText(
                text: 'Groupe sélectionné',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportSelectionnedTransfers.value = value;
                  exportAllTransfers.value = !value;
                } else {
                  exportSelectionnedTransfers.value = value;
                  exportAllTransfers.value = !value;
                }
              },
            )
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
                text: 'Annuler',
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
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Imprimer',
                      onPressed: () async {
                        // get current transfers filter option
                        final transfersListParameters =
                            ref.read(transfersListParametersProvider);

                        if (exportAllTransfers.value) {
                          // get all transfers count
                          final transfersCount =
                              await TransfersController.countAll();

                          // generate excel file
                          await generateTransfersPdf(
                            context: context,
                            ref: ref,
                            listParameters: {
                              'skip': 0,
                              'take': transfersCount.data.count,
                            },
                            showPrintButton: showPrintButton,
                          );
                        } else {
                          // generate excel file
                          await generateTransfersPdf(
                            context: context,
                            ref: ref,
                            listParameters: transfersListParameters,
                            showPrintButton: showPrintButton,
                          );
                        }
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
