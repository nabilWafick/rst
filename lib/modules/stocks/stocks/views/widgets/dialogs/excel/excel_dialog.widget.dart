// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/stocks/stocks/controllers/stocks.controller.dart';
import 'package:rst/modules/stocks/stocks/functions/excel/excel_file.function.dart';
import 'package:rst/modules/stocks/stocks/providers/stocks.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class StockExcelFileGenerationDialog extends HookConsumerWidget {
  const StockExcelFileGenerationDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final exportAllstocks = useState<bool>(false);
    final exportSelectionnedstocks = useState<bool>(true);
    final showExportButton = useState<bool>(true);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Exportation',
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
          children: [
            SwitchListTile(
              value: exportAllstocks.value,
              title: const RSTText(
                text: 'Tout',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportAllstocks.value = value;
                  exportSelectionnedstocks.value = !value;
                } else {
                  exportAllstocks.value = value;
                  exportSelectionnedstocks.value = !value;
                }
              },
            ),
            SwitchListTile(
              value: exportSelectionnedstocks.value,
              title: const RSTText(
                text: 'Groupe sélectionné',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportSelectionnedstocks.value = value;
                  exportAllstocks.value = !value;
                } else {
                  exportSelectionnedstocks.value = value;
                  exportAllstocks.value = !value;
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
            showExportButton.value
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Exporter',
                      onPressed: () async {
                        // get current stocks filter option
                        final stocksListParameters = ref.read(stocksListParametersProvider);

                        if (exportAllstocks.value) {
                          // get all stocks count
                          final stocksCount = await StocksController.countAll();

                          // generate excel file
                          await generateStocksExcelFile(
                            context: context,
                            ref: ref,
                            listParameters: {
                              'skip': 0,
                              'take': stocksCount.data.count,
                            },
                            showExportButton: showExportButton,
                          );
                        } else {
                          // generate excel file
                          await generateStocksExcelFile(
                            context: context,
                            ref: ref,
                            listParameters: stocksListParameters,
                            showExportButton: showExportButton,
                          );
                        }
                      },
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
      actionsAlignment: MainAxisAlignment.end,
    );
  }
}
