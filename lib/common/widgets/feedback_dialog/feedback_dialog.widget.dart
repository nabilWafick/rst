import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class FeedbackDialog extends StatefulHookConsumerWidget {
  const FeedbackDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends ConsumerState<FeedbackDialog> {
  @override
  void initState() {
    final feedbackResponse = ref.read(feedbackDialogResponseProvider);
    /* final remarkSuccessFeedbackDialog =
        ref.read(remarkSuccessfeedbackDialogResponseProvider);*/
    if (feedbackResponse.result != null) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final feedbackResponse = ref.watch(feedbackDialogResponseProvider);
    const formCardWidth = 500.0;
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RSTText(
            text:
                feedbackResponse.result ?? (feedbackResponse.error ?? 'Status'),
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
        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 25.0,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: feedbackResponse.error != null
                            ? Colors.red[700]
                            : RSTColors.primaryColor,
                        size: 30.0,
                      ),
                      const SizedBox(
                        width: 25.0,
                      ),
                      Flexible(
                        child: RSTText(
                          text: feedbackResponse.message,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15.0),
              width: 170.0,
              child: RSTElevatedButton(
                text: 'Fermer',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
