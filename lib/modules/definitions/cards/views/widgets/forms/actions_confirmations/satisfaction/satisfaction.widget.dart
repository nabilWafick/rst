import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart' as material;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

class CardSatisfactionUpdateConfirmationDialog extends HookConsumerWidget {
  final Card card;

  final Future<void> Function({
    required BuildContext context,
    required WidgetRef ref,
    required Card card,
    required ValueNotifier<bool> showValidatedButton,
  }) update;

  const CardSatisfactionUpdateConfirmationDialog({
    super.key,
    required this.card,
    required this.update,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;
    final showValidatedButton = useState<bool>(true);
    return material.AlertDialog(
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
          material.IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              material.Icons.close_rounded,
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
              material.Icons.warning,
              color: material.Colors.orange[900],
              size: 30.0,
            ),
            const SizedBox(
              width: 25.0,
            ),
            const Flexible(
              child: RSTText(
                text:
                    'Êtes-vous sûr de vouloir modifier le statut de satisfaction de cette carte ?',
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
            showValidatedButton.value
                ? SizedBox(
                    width: 170.0,
                    child: RSTElevatedButton(
                      text: 'Confirmer',
                      onPressed: () async {
                        try {
                          update(
                            context: context,
                            ref: ref,
                            card: card,
                            showValidatedButton: showValidatedButton,
                          );
                        } catch (e) {
                          debugPrint(e.toString());
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
