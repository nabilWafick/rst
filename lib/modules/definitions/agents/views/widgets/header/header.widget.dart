import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/add_button/add_button.widget.dart';
import 'package:rst/common/widgets/filter_parameter_tool/functions/filter_tool.function.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/modules/definitions/agents/providers/agents.provider.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/agents/views/widgets/dialogs/dialogs.widget.dart';
import 'package:rst/modules/definitions/agents/views/widgets/forms/addition/agent_addition.widget.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class AgentsPageHeader extends StatefulHookConsumerWidget {
  const AgentsPageHeader({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AgentsPageHeaderState();
}

class _AgentsPageHeaderState extends ConsumerState<AgentsPageHeader> {
  @override
  Widget build(BuildContext context) {
    final agentsListParameters = ref.watch(agentsListParametersProvider);
    final authPermissions = ref.watch(authPermissionsProvider);
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RSTIconButton(
                icon: Icons.refresh_outlined,
                text: 'Rafraichir',
                onTap: () {
                  // refresh providers counts and the agents list
                  ref.invalidate(agentsListStreamProvider);
                  ref.invalidate(agentsCountProvider);
                  ref.invalidate(specificAgentsCountProvider);
                },
              ),
              RSTIconButton(
                icon: Icons.filter_alt_rounded,
                text: agentsListParameters.containsKey('where') &&
                        agentsListParameters['where'].containsKey('AND') &&
                        agentsListParameters['where']['AND'].isNotEmpty
                    ? 'Filtré'
                    : 'Filtrer',
                light: agentsListParameters.containsKey('where') &&
                    agentsListParameters['where'].containsKey('AND') &&
                    agentsListParameters['where']['AND'].isNotEmpty,
                onTap: () async {
                  final random = Random();

                  // reset added filter paramters provider
                  ref.invalidate(agentsListFilterParametersAddedProvider);

                  // updated added filter parameters with list parameters

                  if (agentsListParameters.containsKey('where')) {
                    for (Map<String, dynamic> filterParameter
                        in agentsListParameters['where'].entries.first.value) {
                      // create a filterToolIndex
                      final filterToolIndex =
                          DateTime.now().millisecondsSinceEpoch +
                              random.nextInt(100000);

                      // add it to added filter parameters
                      ref
                          .read(
                        agentsListFilterParametersAddedProvider.notifier,
                      )
                          .update(
                        (state) {
                          state = {
                            ...state,
                            filterToolIndex: filterParameter,
                          };
                          return state;
                        },
                      );

                      // define the operators and the values

                      defineFilterToolOperatorAndValue(
                        ref: ref,
                        filterToolIndex: filterToolIndex,
                        filterParameter: filterParameter,
                      );
                    }
                  }

                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const AgentFilterDialog(),
                  );
                },
              ),
              RSTIconButton(
                icon: Icons.format_list_bulleted_sharp,
                text: !agentsListParameters.containsKey('orderBy') ||
                        !agentsListParameters['orderBy'].isNotEmpty
                    ? 'Trier'
                    : 'Trié',
                light: agentsListParameters.containsKey('orderBy') &&
                    agentsListParameters['orderBy'].isNotEmpty,
                onTap: () {
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const AgentSortDialog(),
                  );
                },
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.printAgentsList]
                  ? RSTIconButton(
                      icon: Icons.print_outlined,
                      text: 'Imprimer',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const AgentPdfGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.exportAgentsList]
                  ? RSTIconButton(
                      icon: Icons.view_module_outlined,
                      text: 'Exporter',
                      onTap: () {
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const AgentExcelFileGenerationDialog(),
                        );
                      },
                    )
                  : const SizedBox(),
              authPermissions[PermissionsValues.admin] ||
                      authPermissions[PermissionsValues.addProduct]
                  ? RSTAddButton(
                      onTap: () {
                        ref.read(agentProfileProvider.notifier).state = null;
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog: const AgentAdditionForm(),
                        );
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
