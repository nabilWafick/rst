import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:yaru_icons/yaru_icons.dart';

class RSTSearchInput extends ConsumerStatefulWidget {
  final String hintText;
  final StateProvider<String> searchProvider;
  final String providerName;
  final double? width;
  const RSTSearchInput({
    super.key,
    required this.hintText,
    required this.searchProvider,
    required this.providerName,
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
          controller: textEditingController,
          onChanged: (value) {
            ref.read(widget.searchProvider.notifier).state = value;
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
                ref.read(widget.searchProvider.notifier).state = '';

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
