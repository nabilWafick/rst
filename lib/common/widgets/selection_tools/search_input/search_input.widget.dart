import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/common/models/field/field.model.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:yaru_icons/yaru_icons.dart';

class RSTSelectionSearchInput extends ConsumerStatefulWidget {
  final String hintText;
  final Field field;
  final StateProvider<Map<String, dynamic>> selectionListParametersProvider;
  final Function({
    required WidgetRef ref,
    required Field field,
    required String value,
    required StateProvider<Map<String, dynamic>>
        selectionListParametersProvider,
  }) onChanged;
  final double? width;
  const RSTSelectionSearchInput({
    super.key,
    required this.hintText,
    required this.field,
    required this.selectionListParametersProvider,
    required this.onChanged,
    this.width,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RSTSelectionSearchInputState();
}

class _RSTSelectionSearchInputState
    extends ConsumerState<RSTSelectionSearchInput> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  textEditingController.text = ref.watch(selectionListParametersProvider(widget.familyName));
    return Container(
      width: widget.width ?? 350.0,
      padding: const EdgeInsets.only(
        right: 15.0,
      ),
      child: Form(
        child: TextFormField(
          controller: textEditingController,
          onChanged: (value) {
            widget.onChanged(
              ref: ref,
              field: widget.field,
              value: value,
              selectionListParametersProvider:
                  widget.selectionListParametersProvider,
            );
          },
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            // contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            hintStyle: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
            ),
            hintText: widget.hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(
              YaruIcons.search,
              color: RSTColors.primaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                // reset search
                widget.onChanged(
                  ref: ref,
                  field: widget.field,
                  value: '',
                  selectionListParametersProvider:
                      widget.selectionListParametersProvider,
                );

                // reset text editing controller
                textEditingController.text = '';
              },
              icon: const Icon(
                Icons.close,
                color: RSTColors.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
