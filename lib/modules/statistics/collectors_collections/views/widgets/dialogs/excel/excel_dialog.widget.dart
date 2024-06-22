// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/definitions/collectors/controllers/collectors.controller.dart';
import 'package:rst/modules/statistics/collectors_collections/functions/excel/excel_file.function.dart';
import 'package:rst/modules/statistics/collectors_collections/providers/collectors_collections.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CollectorsCollectionsExcelFileGenerationDialog
    extends HookConsumerWidget {
  const CollectorsCollectionsExcelFileGenerationDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final exportAllCollectorsCollections = useState<bool>(false);
    final exportSelectionnedCollectorsCollectionss = useState<bool>(true);
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
              value: exportAllCollectorsCollections.value,
              title: const RSTText(
                text: 'Tout',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportAllCollectorsCollections.value = value;
                  exportSelectionnedCollectorsCollectionss.value = !value;
                } else {
                  exportAllCollectorsCollections.value = value;
                  exportSelectionnedCollectorsCollectionss.value = !value;
                }
              },
            ),
            SwitchListTile(
              value: exportSelectionnedCollectorsCollectionss.value,
              title: const RSTText(
                text: 'Groupe sélectionné',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportSelectionnedCollectorsCollectionss.value = value;
                  exportAllCollectorsCollections.value = !value;
                } else {
                  exportSelectionnedCollectorsCollectionss.value = value;
                  exportAllCollectorsCollections.value = !value;
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
                        // get current collectorsCollectionss filter option
                        final collectorsCollectionssListParameters = ref
                            .read(collectorsCollectionsListParametersProvider);

                        if (exportAllCollectorsCollections.value) {
                          // get all collectorsCollectionss count
                          final collectorsCollectionssCount =
                              await CollectorsController.countAll();

                          // generate excel file
                          await generateCollectorsCollectionsExcelFile(
                            context: context,
                            ref: ref,
                            listParameters: {
                              'skip': 0,
                              'take': collectorsCollectionssCount.data.count,
                            },
                            showExportButton: showExportButton,
                          );
                        } else {
                          // generate excel file
                          await generateCollectorsCollectionsExcelFile(
                            context: context,
                            ref: ref,
                            listParameters:
                                collectorsCollectionssListParameters,
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
