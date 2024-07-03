import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/label_value/label_value.model.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/definitions/agents/models/agent/agent.model.dart';
import 'package:rst/modules/definitions/agents/providers/agents.provider.dart';
import 'package:rst/modules/definitions/agents/views/widgets/dialogs/permissions/permission_tool/permission_tool.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class AgentPermissionsDialog extends StatefulHookConsumerWidget {
  final Agent? agent;
  const AgentPermissionsDialog({
    super.key,
    this.agent,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AgentPermissionsDialogState();
}

class _AgentPermissionsDialogState
    extends ConsumerState<AgentPermissionsDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const formCardWidth = 800.0;
    final agentName = ref.watch(agentNameProvider);
    final agentFirstnames = ref.watch(agentFirstnamesProvider);
    final agentPermissionsGroup = ref.watch(agentsPermissionsGroupsProvider);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RSTText(
                text: 'Permissions',
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
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            child: LabelValue(
              label: 'Agent',
              value: widget.agent != null
                  ? '${widget.agent?.name ?? ''} ${widget.agent?.firstnames ?? ''}'
                  : '$agentName $agentFirstnames',
              labelSize: 12.0,
              labelFontWeight: FontWeight.w500,
              valueSize: 15.0,
              valueFontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(10.0),
        width: formCardWidth,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: agentPermissionsGroup
                  .map(
                    (agentPermissionsGroup) => Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      child: Column(
                        children: [
                          RSTText(
                            text: agentPermissionsGroup.name,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ...agentPermissionsGroup.permissions.map(
                            (permission) => PermissionTool(
                              // check agent != null due to addition case
                              permission: widget.agent == null
                                  ? permission
                                  : permission.copyWith(
                                      // checking widget.agent!.permissions
                                      // .containsKey(permission.back)
                                      // because currently users permissions
                                      // is like {'admin':value}
                                      isGranted: widget.agent!.permissions
                                              .containsKey(permission.back)
                                          ? widget.agent!
                                              .permissions[permission.back]
                                          : false,
                                    ),
                              permissionsProvider: agentPermissionsProvider,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList()),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 170.0,
              child: RSTElevatedButton(
                text: 'Valider',
                backgroundColor: RSTColors.primaryColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
