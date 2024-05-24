import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';

final filterParameterToolBoolFieldValueProvider =
    StateProvider.family<bool, String>((ref, providerName) {
  return true;
});

class FilterParameterToolBoolField extends StatefulHookConsumerWidget {
  final bool? initialValue;
  final String providerName;
  const FilterParameterToolBoolField({
    super.key,
    this.initialValue,
    required this.providerName,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterParameterToolBoolFieldState();
}

class _FilterParameterToolBoolFieldState
    extends ConsumerState<FilterParameterToolBoolField> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      ref
          .read(filterParameterToolBoolFieldValueProvider(widget.providerName)
              .notifier)
          .state = widget.initialValue ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedValue = ref.watch(
      filterParameterToolBoolFieldValueProvider(widget.providerName),
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
            .read(filterParameterToolBoolFieldValueProvider(widget.providerName)
                .notifier)
            .state = value;
      },
    );
  }
}
