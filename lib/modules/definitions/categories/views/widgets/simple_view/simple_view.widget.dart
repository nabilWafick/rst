import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/definitions/categories/models/categories.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CategorySimpleView extends ConsumerWidget {
  final Category category;
  const CategorySimpleView({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 500.0;

    final format = DateFormat.yMMMMEEEEd('fr');
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 5.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Categorie',
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close_rounded,
              color: RSTColors.primaryColor,
              size: 30.0,
            ),
          ),
        ],
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(20.0),
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        width: formCardWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Nom',
                value: category.name,
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Insertion',
                value: format.format(category.createdAt),
              ),
            ),
            Container(
              margin: const EdgeInsetsDirectional.symmetric(
                vertical: 5.0,
              ),
              child: LabelValue(
                label: 'Dernière Modification',
                value: format.format(category.updatedAt),
              ),
            ),
          ],
        ),
      ),
      actions: [
        SizedBox(
          width: 170.0,
          child: RSTElevatedButton(
            text: 'Fermer',
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
