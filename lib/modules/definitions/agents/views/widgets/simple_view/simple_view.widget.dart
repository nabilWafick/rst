import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/definitions/agents/models/agents.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class AgentSimpleView extends ConsumerWidget {
  final Agent agent;
  const AgentSimpleView({
    super.key,
    required this.agent,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;

    final format = DateFormat.yMMMMEEEEd('fr');
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 5.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Agent',
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
          vertical: 20.0,
        ),
        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Nom',
                value: agent.name,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Prénoms',
                value: agent.firstnames,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Téléphone',
                value: agent.phoneNumber,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Email',
                value: agent.email,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Adresse',
                value: agent.address,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Insertion',
                value: format.format(agent.createdAt),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Dernière Modification',
                value: format.format(agent.updatedAt),
              ),
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: 170.0,
          child: RSTElevatedButton(
            text: 'Fermer',
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
