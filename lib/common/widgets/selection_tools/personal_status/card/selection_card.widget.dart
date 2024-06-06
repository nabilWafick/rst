import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/personal_status/dialog/selection_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/personal_status/providers/selection.provider.dart';
import 'package:rst/modules/definitions/personal_status/models/personal_status/personal_status.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class PersonalStatusSelectionToolCard extends StatefulHookConsumerWidget {
  final String toolName;
  final bool? enabled;
  final PersonalStatus? personalStatus;
  final double? width;
  final RoundedStyle roundedStyle;
  final int? textLimit;

  const PersonalStatusSelectionToolCard({
    super.key,
    required this.toolName,
    this.enabled,
    required this.roundedStyle,
    this.personalStatus,
    this.width,
    this.textLimit,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PersonalStatusSelectionToolCardState();
}

class _PersonalStatusSelectionToolCardState
    extends ConsumerState<PersonalStatusSelectionToolCard> {
  final focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    if (widget.personalStatus != null) {
      Future.delayed(
        const Duration(
          milliseconds: 100,
        ),
        () {
          ref
              .read(
                  personalStatusSelectionToolProvider(widget.toolName).notifier)
              .state = widget.personalStatus;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedpersonalStatus =
        ref.watch(personalStatusSelectionToolProvider(widget.toolName));
    final focusOn = useState<bool>(false);
    double width = widget.width ?? 210;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: InkWell(
        onTap: widget.enabled == null || widget.enabled == true
            ? () async {
                // invalidate personalStatus selection list parameters
                ref.invalidate(personalStatusSelectionListParametersProvider);

                FunctionsController.showAlertDialog(
                  context: context,
                  alertDialog: PersonalStatusSelectionDialog(
                    toolName: widget.toolName,
                  ),
                );
              }
            : null,
        splashColor: RSTColors.primaryColor.withOpacity(.05),
        hoverColor: Colors.transparent,
        child: Container(
          width: width,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 16.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: .5,
              color: focusOn.value
                  ? RSTColors.primaryColor
                  : RSTColors.tertiaryColor,
            ),
            borderRadius: widget.roundedStyle == RoundedStyle.full
                ? BorderRadius.circular(15.0)
                : widget.roundedStyle == RoundedStyle.none
                    ? BorderRadius.circular(.0)
                    : BorderRadius.only(
                        topLeft: Radius.circular(
                          widget.roundedStyle == RoundedStyle.onlyLeft
                              ? 15.0
                              : 0,
                        ),
                        bottomLeft: Radius.circular(
                          widget.roundedStyle == RoundedStyle.onlyLeft
                              ? 15.0
                              : 0,
                        ),
                        topRight: Radius.circular(
                          widget.roundedStyle == RoundedStyle.onlyRight
                              ? 15.0
                              : 0,
                        ),
                        bottomRight: Radius.circular(
                          widget.roundedStyle == RoundedStyle.onlyRight
                              ? 15.0
                              : 0,
                        ),
                      ),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  ref.invalidate(
                      personalStatusSelectionToolProvider(widget.toolName));
                },
                child: Icon(
                  Icons.person_outlined,
                  size: 15,
                  color: focusOn.value
                      ? RSTColors.primaryColor
                      : RSTColors.tertiaryColor,
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              RSTText(
                text: FunctionsController.truncateText(
                  text: selectedpersonalStatus?.name ?? 'Statut Personnel',
                  maxLength: widget.textLimit ?? 15,
                ),
                fontSize: 10.0,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
