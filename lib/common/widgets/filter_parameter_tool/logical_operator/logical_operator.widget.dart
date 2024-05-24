import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/utils/colors/colors.util.dart';

class FilterParametersLogicalOperator extends HookConsumerWidget {
  final ValueNotifier<String> logicalOperator;
  final double formCardWidth;
  const FilterParametersLogicalOperator({
    super.key,
    required this.logicalOperator,
    required this.formCardWidth,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final andOperatorSelected = useState<bool>(logicalOperator.value == "AND");
    final orOperatorSelected = useState<bool>(logicalOperator.value == "OR");
    final notOperatorSelected = useState<bool>(logicalOperator.value == "NOT");
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: formCardWidth / 3.5,
            child: CheckboxListTile(
              value: andOperatorSelected.value,
              hoverColor: RSTColors.primaryColor.withOpacity(.1),
              title: const RSTText(
                text: 'ET',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              onChanged: (value) {
                if (value == true) {
                  andOperatorSelected.value = true;
                  logicalOperator.value = "AND";
                  orOperatorSelected.value = false;
                  notOperatorSelected.value = false;
                } else if (value == false) {
                  andOperatorSelected.value = value!;
                  notOperatorSelected.value = value;
                  orOperatorSelected.value = true;
                  logicalOperator.value = "OR";
                }
              },
            ),
          ),
          SizedBox(
            width: formCardWidth / 3.5,
            child: CheckboxListTile(
              value: orOperatorSelected.value,
              hoverColor: RSTColors.primaryColor.withOpacity(.1),
              title: const RSTText(
                text: 'OU',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              onChanged: (value) {
                if (value == true) {
                  orOperatorSelected.value = value!;
                  logicalOperator.value = "OR";
                  andOperatorSelected.value = false;
                  notOperatorSelected.value = false;
                } else if (value == false) {
                  orOperatorSelected.value = value!;
                  notOperatorSelected.value = value;
                  andOperatorSelected.value = true;
                  logicalOperator.value = "AND";
                }
              },
            ),
          ),
          SizedBox(
            width: formCardWidth / 3.5,
            child: CheckboxListTile(
              value: notOperatorSelected.value,
              hoverColor: RSTColors.primaryColor.withOpacity(.15),
              title: const RSTText(
                text: 'NON',
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              onChanged: (value) {
                if (value == true) {
                  notOperatorSelected.value = value!;
                  logicalOperator.value = "NOT";
                  orOperatorSelected.value = false;
                  andOperatorSelected.value = false;
                } else if (value == false) {
                  notOperatorSelected.value = value!;
                  orOperatorSelected.value = value;
                  andOperatorSelected.value = true;
                  logicalOperator.value = "AND";
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
