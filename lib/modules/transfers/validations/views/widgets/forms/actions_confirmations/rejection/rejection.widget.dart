import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/transfers/models/transfer/transfer.model.dart';

import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

class TransferRejectionConfirmationDialog extends HookConsumerWidget {
  final Transfer transfer;
  final Future<void> Function({
    required BuildContext context,
    required WidgetRef ref,
    required Transfer transfer,
  }) confirmToReject;

  const TransferRejectionConfirmationDialog({
    super.key,
    required this.transfer,
    required this.confirmToReject,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final showConfirmationButton = useState<bool>(true);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Confirmation',
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
        child: Row(
          children: [
            Icon(
              Icons.warning,
              color: Colors.orange[900],
              size: 30.0,
            ),
            const SizedBox(
              width: 25.0,
            ),
            const Flexible(
              child: RSTText(
                text: 'Êtes-vous sûr de vouloir rejeter ce transfert ?',
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
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
                text: 'Fermer',
                backgroundColor: RSTColors.sidebarTextColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            showConfirmationButton.value
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Confirmer',
                      onPressed: () async {
                        confirmToReject(
                          context: context,
                          ref: ref,
                          transfer: transfer,
                        );
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
