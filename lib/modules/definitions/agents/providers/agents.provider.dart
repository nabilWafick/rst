import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/modules/definitions/agents/controllers/agents.controller.dart';
import 'package:rst/modules/definitions/agents/models/agent/agent.model.dart';

// used for storing agent name (form)
final agentNameProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent firstnames (form)
final agentFirstnamesProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent email (form)
final agentEmailProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent phoneNumber (form)
final agentPhoneNumberProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent address (form)
final agentAddressProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

// used for storing agent photo (form)
final agentProfileProvider = StateProvider<String?>(
  (ref) {
    return;
  },
);

// used for storing agent permissions (form)
final agentPermissionsProvider = StateProvider<Map<String, dynamic>>(
  (ref) {
    return {};
  },
);

// used for storing agent permissions (form)
final agentViewsViewsPermissionsProvider = StateProvider<Map<String, dynamic>>(
  (ref) {
    return {};
  },
);

// used for storing agents filter options
final agentsListParametersProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {
    'skip': 0,
    'take': 25,
  };
});

// used for storing added filter tool
final agentsListFilterParametersAddedProvider =
    StateProvider<Map<int, Map<String, dynamic>>>((ref) {
  return {};
});

// used for storing fetched agents
final agentsListStreamProvider = FutureProvider<List<Agent>>((ref) async {
  final listParameters = ref.watch(agentsListParametersProvider);

  final controllerResponse = await AgentsController.getMany(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? List<Agent>.from(controllerResponse.data)
      : <Agent>[];
});

// used for storing all agents of database count
final agentsCountProvider = FutureProvider<int>((ref) async {
  final controllerResponse = await AgentsController.countAll();

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});

// used for storing fetched agents (agents respecting filter options) count
final specificagentsCountProvider = FutureProvider<int>((ref) async {
  final listParameters = ref.watch(agentsListParametersProvider);

  final controllerResponse = await AgentsController.countSpecific(
    listParameters: listParameters,
  );

  return controllerResponse.data != null
      ? controllerResponse.data.count as int
      : 0;
});
