import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';

final filterParameterToolBoolFieldProvider =
    StateProvider.family<bool, String>((ref, providerName) {
  return true;
});

class FilterParameterToolBoolField extends HookConsumerWidget {
  final String providerName;
  const FilterParameterToolBoolField({
    super.key,
    required this.providerName,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedValue = ref.watch(
      filterParameterToolBoolFieldProvider(providerName),
    );
    return SwitchListTile(
      value: selectedValue,
      title: RSTText(
        text: selectedValue ? 'Vrai' : 'Faux',
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
      ),
      onChanged: (value) {
        ref
            .read(filterParameterToolBoolFieldProvider(providerName).notifier)
            .state = value;
      },
    );
  }
}
