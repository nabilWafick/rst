// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/activities/collector/functions/excel/excel_file.function.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CollectorActivitiesExcelFileGenerationDialog extends HookConsumerWidget {
  const CollectorActivitiesExcelFileGenerationDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final exportAllsettlements = useState<bool>(false);
    final exportSelectionnedsettlements = useState<bool>(true);
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
              value: exportAllsettlements.value,
              title: const RSTText(
                text: 'Tout',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportAllsettlements.value = value;
                  exportSelectionnedsettlements.value = !value;
                } else {
                  exportAllsettlements.value = value;
                  exportSelectionnedsettlements.value = !value;
                }
              },
            ),
            SwitchListTile(
              value: exportSelectionnedsettlements.value,
              title: const RSTText(
                text: 'Groupe sélectionné',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportSelectionnedsettlements.value = value;
                  exportAllsettlements.value = !value;
                } else {
                  exportSelectionnedsettlements.value = value;
                  exportAllsettlements.value = !value;
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
                        // get current settlements filter option
                        final settlementsListParameters =
                            ref.read(settlementsListParametersProvider);

                        if (exportAllsettlements.value) {
                          // get all settlements count
                          final settlementsCount =
                              await SettlementsController.countAll();

                          // generate excel file
                          await generateCollectorActivitiesExcelFile(
                            context: context,
                            ref: ref,
                            listParameters: {
                              'skip': 0,
                              'take': settlementsCount.data.count,
                            },
                            showExportButton: showExportButton,
                          );
                        } else {
                          // generate excel file
                          await generateCollectorActivitiesExcelFile(
                            context: context,
                            ref: ref,
                            listParameters: settlementsListParameters,
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
