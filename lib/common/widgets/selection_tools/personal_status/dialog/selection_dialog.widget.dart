import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/personal_status/dialog/body/body.dart';
import 'package:rst/common/widgets/selection_tools/personal_status/dialog/footer/footer.dart';
import 'package:rst/common/widgets/selection_tools/personal_status/providers/selection.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class PersonalStatusSelectionDialog extends StatefulHookConsumerWidget {
  final String toolName;
  const PersonalStatusSelectionDialog({
    super.key,
    required this.toolName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonalStatusSelectionDialogState();
}

class _PersonalStatusSelectionDialogState
    extends ConsumerState<PersonalStatusSelectionDialog> {
  @override
  Widget build(BuildContext context) {
    const dialogWidth = 520.0;
    const dialogHeight = 500.0;
    final selectedpersonalStatus =
        ref.watch(personalStatusSelectionToolProvider(widget.toolName));
    return AlertDialog(
      /*   contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 5.0,
        horizontal: 5.0,
      ),*/
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Statuts Personnels',
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
                    text: 'Statut personnel sélectionné: ',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                  RSTText(
                    text: selectedpersonalStatus?.name ?? '',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            PersonalStatusSelectionDialogBody(
              toolName: widget.toolName,
            ),
            const SizedBox(
              height: 15.0,
            ),
            PersonalStatusSelectionDialogFooter(
              toolName: widget.toolName,
            ),
          ],
        ),
      ),
    );
  }
}
