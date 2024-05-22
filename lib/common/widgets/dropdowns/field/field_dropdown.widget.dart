import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/field/field.model.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

final fieldDropdownProvider = StateProvider.family<Field, String>(
  (ref, dropdown) {
    return Field(
      front: '',
      back: '',
      type: String,
      isNullable: false,
      isRelation: false,
    );
  },
);

class RSTFieldDropdown extends StatefulHookConsumerWidget {
  final String label;

  final String providerName;
  final List<Field> dropdownMenuEntriesLabels;
  final List<Field> dropdownMenuEntriesValues;
  final double? width;
  final double? menuHeigth;
  final bool? enabled;

  const RSTFieldDropdown({
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
      _RSTFieldDropdownState();
}

class _RSTFieldDropdownState extends ConsumerState<RSTFieldDropdown> {
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
          ref.read(fieldDropdownProvider(widget.providerName).notifier).state =
              widget.dropdownMenuEntriesValues[0];
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDropdownItem =
        ref.watch(fieldDropdownProvider(widget.providerName));
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
          ref.read(fieldDropdownProvider(widget.providerName).notifier).state =
              value!;
        },
      ),
    );
  }
}
