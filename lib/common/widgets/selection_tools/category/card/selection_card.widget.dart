import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/category/dialog/selection_dialog.widget.dart';
import 'package:rst/common/widgets/selection_tools/category/providers/selection.provider.dart';
import 'package:rst/modules/definitions/categories/models/category/category.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CategorySelectionToolCard extends StatefulHookConsumerWidget {
  final String toolName;
  final Category? category;
  final double? width;
  final RoundedStyle roundedStyle;

  const CategorySelectionToolCard({
    super.key,
    required this.toolName,
    required this.roundedStyle,
    this.category,
    this.width,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategorySelectionToolCardState();
}

class _CategorySelectionToolCardState
    extends ConsumerState<CategorySelectionToolCard> {
  final focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    if (widget.category != null) {
      Future.delayed(
        const Duration(
          milliseconds: 100,
        ),
        () {
          ref
              .read(categorySelectionToolProvider(widget.toolName).notifier)
              .state = widget.category;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedcategory =
        ref.watch(categorySelectionToolProvider(widget.toolName));
    final focusOn = useState<bool>(false);
    double width = widget.width ?? 210;
    return InkWell(
      onTap: () async {
        // invalidate category selection list parameters
        ref.invalidate(categoriesSelectionListParametersProvider);

        FunctionsController.showAlertDialog(
          context: context,
          alertDialog: CategorySelectionDialog(
            toolName: widget.toolName,
          ),
        );
      },
      splashColor: RSTColors.primaryColor.withOpacity(.05),
      hoverColor: Colors.transparent,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: focusOn.value
                ? RSTColors.primaryColor
                : RSTColors.tertiaryColor,
          ),
          borderRadius: widget.roundedStyle == RoundedStyle.full
              ? BorderRadius.circular(15.0)
              : BorderRadius.only(
                  topLeft: Radius.circular(
                    widget.roundedStyle == RoundedStyle.onlyLeft ? 15.0 : 0,
                  ),
                  bottomLeft: Radius.circular(
                    widget.roundedStyle == RoundedStyle.onlyLeft ? 15.0 : 0,
                  ),
                  topRight: Radius.circular(
                    widget.roundedStyle == RoundedStyle.onlyRight ? 15.0 : 0,
                  ),
                  bottomRight: Radius.circular(
                    widget.roundedStyle == RoundedStyle.onlyRight ? 15.0 : 0,
                  ),
                ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 15,
              color: focusOn.value
                  ? RSTColors.primaryColor
                  : RSTColors.tertiaryColor,
            ),
            const SizedBox(
              width: 10.0,
            ),
            RSTText(
              text: FunctionsController.truncateText(
                text: selectedcategory?.name ?? 'Produit',
                maxLength: 15,
              ),
              fontSize: 10.0,
              fontWeight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
