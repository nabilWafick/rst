import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';

class CashOperationsFilterTools extends StatefulHookConsumerWidget {
  const CashOperationsFilterTools({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashOperationsFilterToolsState();
}

class _CashOperationsFilterToolsState
    extends ConsumerState<CashOperationsFilterTools> {
  @override
  Widget build(BuildContext context) {
    final cashOperationsSelectedCustomerCards =
        ref.watch(cashOperationsSelectedCustomerCardsProvider);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RSTIconButton(
            icon: Icons.refresh,
            text: 'Rafraichir',
            onTap: () {},
          ),
          const CustomerSelectionToolCard(
            toolName: 'cash-operation',
            width: 280.0,
            roundedStyle: RoundedStyle.full,
            textLimit: 45,
          ),
          const CollectorSelectionToolCard(
            toolName: 'cash-operation',
            width: 280.0,
            roundedStyle: RoundedStyle.full,
            textLimit: 45,
          ),
          const CardSelectionToolCard(
            toolName: 'cash-operation',
            width: 280.0,
            roundedStyle: RoundedStyle.full,
            textLimit: 45,
          ),
          cashOperationsSelectedCustomerCards.isEmpty
              ? RSTIconButton(
                  icon: Icons.add_circle,
                  text: 'Régler plusieurs cartes',
                  onTap: () {
                    // reset collection date provider
                    ref.read(settlementCollectionDateProvider.notifier).state =
                        null;
                    // reset added inputs provider
                    ref
                        .read(
                          multipleSettlementsAddedInputsProvider.notifier,
                        )
                        .state = {};
                    // reset selected types provider
                    ref
                        .read(
                          multipleSettlementsSelectedTypesProvider.notifier,
                        )
                        .state = {};
                    // reset selected customer cards provider
                    ref
                        .read(
                          multipleSettlementsSelectedCustomerCardsProvider
                              .notifier,
                        )
                        .state = {};

                    FunctionsController.showAlertDialog(
                      context: context,
                      alertDialog:
                          Container() /* const MultipleSettlementsAddingForm()*/,
                    );
                  },
                )
              : const SizedBox(),
          SizedBox(
            width: 220.0,
            child: CheckboxListTile(
              value: true,
              title: const RSTText(
                text: 'Toutes les cartes',
                fontSize: 12,
              ),
              hoverColor: Colors.transparent,
              onChanged: (value) {
                ref
                    .read(
                      cashOperationsShowAllCustomerCardsProvider.notifier,
                    )
                    .state = value!;
              },
            ),
          ),
        ],
      ),
    );
  }
}
