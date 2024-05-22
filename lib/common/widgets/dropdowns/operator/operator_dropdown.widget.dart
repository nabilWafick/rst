import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/operator/operator.model.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

final operatorDropdownProvider = StateProvider.family<Operator, String>(
  (ref, dropdown) {
    return Operator(
      front: '',
      back: '',
    );
  },
);

class RSTOperatorDropdown extends ConsumerStatefulWidget {
  final String label;
  final String providerName;
  final List<Operator> dropdownMenuEntriesLabels;
  final List<Operator> dropdownMenuEntriesValues;
  final double? width;
  final double? menuHeigth;
  final bool? enabled;

  const RSTOperatorDropdown({
    super.key,
    this.width,
    this.menuHeigth,
    this.enabled,
    required this.label,
    required this.providerName,
    required this.dropdownMenuEntriesLabels,
    required this.dropdownMenuEntriesValues,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RSTOperatorDropdownState();
}

class _RSTOperatorDropdownState extends ConsumerState<RSTOperatorDropdown> {
  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        // check if dropdown item is not empty so as to avoid error
        // while setting the  the first item as the selectedItem
        if (widget.dropdownMenuEntriesValues.isNotEmpty) {
          ref
              .read(operatorDropdownProvider(widget.providerName).notifier)
              .state = widget.dropdownMenuEntriesValues[0];
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(operatorDropdownProvider(widget.providerName));
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: DropdownMenu(
        width: widget.width,
        menuHeight: widget.menuHeigth,
        enabled: widget.enabled ?? true,
        enableFilter: true,
        label: RSTText(
          text: widget.label,
        ),
        hintText: widget.label,
        initialSelection: selectedDropdownItem,
        dropdownMenuEntries: widget.dropdownMenuEntriesLabels
            .map(
              (dropdownMenuEntryLabel) => DropdownMenuEntry(
                value: widget.dropdownMenuEntriesValues[widget
                    .dropdownMenuEntriesLabels
                    .indexOf(dropdownMenuEntryLabel)],
                label: dropdownMenuEntryLabel.front,
                style: const ButtonStyle(
                  textStyle: MaterialStatePropertyAll(
                    TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            )
            .toList(),
        trailingIcon: const Icon(
          Icons.arrow_drop_down,
        ),
        onSelected: (value) {
          ref
              .read(operatorDropdownProvider(widget.providerName).notifier)
              .state = value!;
        },
      ),
    );
  }
}
