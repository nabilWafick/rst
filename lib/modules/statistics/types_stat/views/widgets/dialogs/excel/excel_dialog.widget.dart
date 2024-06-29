// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/definitions/types/controllers/types.controller.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/modules/statistics/types_stat/functions/excel/excel_file.function.dart';
import 'package:rst/utils/colors/colors.util.dart';

class TypesStatsExcelFileGenerationDialog extends HookConsumerWidget {
  const TypesStatsExcelFileGenerationDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final exportAllTypesStats = useState<bool>(false);
    final exportSelectionnedTypesStats = useState<bool>(true);
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
              value: exportAllTypesStats.value,
              title: const RSTText(
                text: 'Tout',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportAllTypesStats.value = value;
                  exportSelectionnedTypesStats.value = !value;
                } else {
                  exportAllTypesStats.value = value;
                  exportSelectionnedTypesStats.value = !value;
                }
              },
            ),
            SwitchListTile(
              value: exportSelectionnedTypesStats.value,
              title: const RSTText(
                text: 'Groupe sélectionné',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportSelectionnedTypesStats.value = value;
                  exportAllTypesStats.value = !value;
                } else {
                  exportSelectionnedTypesStats.value = value;
                  exportAllTypesStats.value = !value;
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
                        // get current types filter option
                        final typesListParameters =
                            ref.read(typesListParametersProvider);

                        if (exportAllTypesStats.value) {
                          // get all types count
                          final typesCount = await TypesController.countAll();

                          // generate excel file
                          await generateTypesStatsExcelFile(
                            context: context,
                            ref: ref,
                            listParameters: {
                              'skip': 0,
                              'take': typesCount.data.count,
                            },
                            showExportButton: showExportButton,
                          );
                        } else {
                          // generate excel file
                          await generateTypesStatsExcelFile(
                            context: context,
                            ref: ref,
                            listParameters: typesListParameters,
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
