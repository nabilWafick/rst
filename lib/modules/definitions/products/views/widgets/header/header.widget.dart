import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rst/functions/common/common.function.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/modules/definitions/products/views/widgets/forms/adding/products_adding.widget.dart';
import 'package:rst/widgets/add_button/add_button.widget.dart';
import 'package:rst/widgets/icon_button/icon_button.widget.dart';

class ProductsSortOptions extends ConsumerWidget {
  const ProductsSortOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20.0,
      ),
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RSTIconButton(
                icon: Icons.refresh,
                text: 'Rafraichir',
                onTap: () {
                  // ref.invalidate(productsListStreamProvider);
                },
              ),
              RSTAddButton(
                onTap: () {
                  ref.read(productPhotoProvider.notifier).state = null;
                  FunctionsController.showAlertDialog(
                    context: context,
                    alertDialog: const ProductAddingForm(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
