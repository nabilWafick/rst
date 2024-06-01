import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/selection_tools/product/card/selection_card.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

class WidgetTest extends StatefulHookConsumerWidget {
  const WidgetTest({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WidgetTestState();
}

class _WidgetTestState extends ConsumerState<WidgetTest> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    //  final heigth = MediaQuery.of(context).size.height;
    //  final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const RSTText(
              text: 'Test',
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
            ),
            const ProductSelectionToolCard(
              toolName: 'test',
              roundedStyle: RoundedStyle.full,
            ),
            RSTIconButton(
              onTap: () async {
                /*   await ProductsServices.create(
                  product: Product(
                    name: 'Product 1',
                    purchasePrice: 1,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                );*/
              },
              icon: Icons.telegram_outlined,
              text: 'Test',
            )
          ],
        ),
      ),
    );
  }
}
