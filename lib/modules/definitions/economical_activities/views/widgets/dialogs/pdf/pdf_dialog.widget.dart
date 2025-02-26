// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/definitions/economical_activities/controllers/economical_activities.controller.dart';
import 'package:rst/modules/definitions/economical_activities/functions/pdf/pdf_file.function.dart';
import 'package:rst/modules/definitions/economical_activities/providers/economical_activities.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class EconomicalActivityPdfGenerationDialog extends HookConsumerWidget {
  const EconomicalActivityPdfGenerationDialog({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final exportAlleconomicalActivities = useState<bool>(false);
    final exportSelectionnedeconomicalActivities = useState<bool>(true);
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
              value: exportAlleconomicalActivities.value,
              title: const RSTText(
                text: 'Tout',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportAlleconomicalActivities.value = value;
                  exportSelectionnedeconomicalActivities.value = !value;
                } else {
                  exportAlleconomicalActivities.value = value;
                  exportSelectionnedeconomicalActivities.value = !value;
                }
              },
            ),
            SwitchListTile(
              value: exportSelectionnedeconomicalActivities.value,
              title: const RSTText(
                text: 'Groupe sélectionné',
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                if (value) {
                  exportSelectionnedeconomicalActivities.value = value;
                  exportAlleconomicalActivities.value = !value;
                } else {
                  exportSelectionnedeconomicalActivities.value = value;
                  exportAlleconomicalActivities.value = !value;
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
                        // get current economicalActivities filter option
                        final economicalActivitiesListParameters =
                            ref.read(economicalActivitiesListParametersProvider);

                        if (exportAlleconomicalActivities.value) {
                          // get all economicalActivities count
                          final economicalActivitiesCount =
                              await EconomicalActivitiesController.countAll();

                          // generate excel file
                          await generateEconomicalActivitiesPdf(
                            context: context,
                            ref: ref,
                            listParameters: {
                              'skip': 0,
                              'take': economicalActivitiesCount.data.count,
                            },
                            showPrintButton: showPrintButton,
                          );
                        } else {
                          // generate excel file
                          await generateEconomicalActivitiesPdf(
                            context: context,
                            ref: ref,
                            listParameters: economicalActivitiesListParameters,
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
