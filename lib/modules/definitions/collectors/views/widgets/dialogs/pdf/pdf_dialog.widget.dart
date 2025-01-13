// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/definitions/collectors/controllers/collectors.controller.dart';
import 'package:rst/modules/definitions/collectors/functions/pdf/pdf_file.function.dart';
import 'package:rst/modules/definitions/collectors/providers/collectors.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CollectorPdfGenerationDialog extends HookConsumerWidget {
  const CollectorPdfGenerationDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final exportAllCollectors = useState<bool>(false);
    final exportSelectionnedCollectors = useState<bool>(true);
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
              value: exportAllCollectors.value,
              title: const RSTText(
                text: 'Tout',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportAllCollectors.value = value;
                  exportSelectionnedCollectors.value = !value;
                } else {
                  exportAllCollectors.value = value;
                  exportSelectionnedCollectors.value = !value;
                }
              },
            ),
            SwitchListTile(
              value: exportSelectionnedCollectors.value,
              title: const RSTText(
                text: 'Groupe sélectionné',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportSelectionnedCollectors.value = value;
                  exportAllCollectors.value = !value;
                } else {
                  exportSelectionnedCollectors.value = value;
                  exportAllCollectors.value = !value;
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
                        // get current collectors filter option
                        final collectorsListParameters = ref.read(collectorsListParametersProvider);

                        if (exportAllCollectors.value) {
                          // get all collectors count
                          final collectorsCount = await CollectorsController.countAll();

                          // generate excel file
                          await generateCollectorsPdf(
                            context: context,
                            ref: ref,
                            listParameters: {
                              'skip': 0,
                              'take': collectorsCount.data.count,
                            },
                            showPrintButton: showPrintButton,
                          );
                        } else {
                          // generate excel file
                          await generateCollectorsPdf(
                            context: context,
                            ref: ref,
                            listParameters: collectorsListParameters,
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
