import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/cards/models/cards.model.dart';
import 'package:rst/modules/definitions/cards/services/cards.service.dart';
import 'package:rst/modules/definitions/types/models/types.model.dart';
import 'package:rst/modules/definitions/customers/models/customers.model.dart';

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

    return material.Scaffold(
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
            const CategorySelectionToolCard(
              toolName: 'test',
              roundedStyle: RoundedStyle.full,
            ),
            const LocalitySelectionToolCard(
              toolName: 'test',
              roundedStyle: RoundedStyle.full,
            ),
            const EconomicalActivitySelectionToolCard(
              toolName: 'test',
              roundedStyle: RoundedStyle.full,
            ),
            const PersonalStatusSelectionToolCard(
              toolName: 'test',
              roundedStyle: RoundedStyle.full,
            ),
            const TypeSelectionToolCard(
              toolName: 'test',
              roundedStyle: RoundedStyle.full,
            ),
            const CustomerSelectionToolCard(
              toolName: 'test',
              roundedStyle: RoundedStyle.full,
            ),
            const CollectorSelectionToolCard(
              toolName: 'test',
              roundedStyle: RoundedStyle.full,
            ),
            RSTIconButton(
              onTap: () async {
                try {
                  await CardsServices.create(
                    card: Card(
                      label: 'label',
                      type: Type(
                        id: 70,
                        name: 'name',
                        stake: 10,
                        typeProducts: [],
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                      typesNumber: 1,
                      customer: Customer(
                        id: 835,
                        name: 'name',
                        firstnames: 'firstnames',
                        phoneNumber: '',
                        address: 'address',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    ),
                  );
                } catch (e) {
                  debugPrint(e.toString());
                }
              },
              icon: material.Icons.telegram_outlined,
              text: 'Test',
            )
          ],
        ),
      ),
    );
  }
}
