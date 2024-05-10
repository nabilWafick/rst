import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/utils/colors/colors.util.dart';

class RSTSearchInput extends ConsumerStatefulWidget {
  final String hintText;
  final String familyName;
  final StateProvider<String> searchProvider;
  final double? width;
  const RSTSearchInput({
    super.key,
    required this.familyName,
    required this.hintText,
    required this.searchProvider,
    this.width,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RSTSearchInputState();
}

class _RSTSearchInputState extends ConsumerState<RSTSearchInput> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //  textEditingController.text = ref.watch(searchProvider(widget.familyName));
    return Container(
      width: widget.width ?? 350.0,
      padding: const EdgeInsets.only(
        right: 15.0,
      ),
      child: Form(
        child: TextFormField(
          //  initialValue: initialValue != '' ? initialValue : null,
          controller: textEditingController,
          onChanged: (value) {
            ref.read(widget.searchProvider.notifier).state = value;
          },
          style: const TextStyle(
            fontSize: 12.0,
          ),
          decoration: InputDecoration(
            // contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            hintStyle: const TextStyle(
              fontSize: 12.0,
            ),
            hintText: widget.hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: RSTColors.primaryColor,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                ref.read(widget.searchProvider.notifier).state = '';
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
