import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/collector/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/modules/cash/cash_operations/functions/listeners/listeners.functions.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/cash/settlements/views/widgets/forms/multiple_addition/multiple_addition.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/home/providers/home.provider.dart';

class CashOperationsFilterTools extends StatefulHookConsumerWidget {
  const CashOperationsFilterTools({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CashOperationsFilterToolsState();
}

class _CashOperationsFilterToolsState
    extends ConsumerState<CashOperationsFilterTools> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final cashOperationsSelectedCustomerCards =
        ref.watch(cashOperationsSelectedCustomerCardsProvider);

    // listen to cash operations customer change
    ref.listen(collectorSelectionToolProvider('cash-operations'),
        (previous, next) {
      onCashOperationsCollectorChange(
        ref: ref,
        previousCollector: previous,
        newCollector: next,
      );
    });

    // listen to cash operations customer change
    ref.listen(customerSelectionToolProvider('cash-operations'),
        (previous, next) {
      onCashOperationsCustomerChange(
        ref: ref,
        previousCustomer: previous,
        newCustomer: next,
      );
    });

    // listen to cash operations customer card change
    ref.listen(cardSelectionToolProvider('cash-operations'), (previous, next) {
      onCashOperationsCustomerCardChange(
        ref: ref,
        previousCustomerCard: previous,
        newCustomerCard: next,
      );
    });

    final authPermissions = ref.watch(authPermissionsProvider);

    final toolsSpacing = MediaQuery.of(context).size.width * 0.01;

    return Scrollbar(
      controller: scrollController,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        child: SingleChildScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RSTIconButton(
                icon: Icons.refresh,
                text: 'Rafraichir',
                onTap: () {
                  // invalidate collector tool provider
                  ref.invalidate(
                      collectorSelectionToolProvider('cash-operations'));
                },
              ),
              SizedBox(
                width: toolsSpacing,
              ),
              const CustomerSelectionToolCard(
                toolName: 'cash-operations',
                width: 280.0,
                roundedStyle: RoundedStyle.full,
                textLimit: 25,
              ),
              SizedBox(
                width: toolsSpacing,
              ),
              const CollectorSelectionToolCard(
                toolName: 'cash-operations',
                width: 280.0,
                roundedStyle: RoundedStyle.full,
                textLimit: 25,
              ),
              SizedBox(
                width: toolsSpacing,
              ),
              const CardSelectionToolCard(
                toolName: 'cash-operations',
                width: 280.0,
                roundedStyle: RoundedStyle.full,
                textLimit: 25,
              ),
              SizedBox(
                width: toolsSpacing,
              ),
              cashOperationsSelectedCustomerCards.length > 1
                  ? authPermissions![PermissionsValues.admin] ||
                          authPermissions[PermissionsValues.addSettlement]
                      ? RSTIconButton(
                          icon: Icons.add_circle,
                          text: 'Régler plusieurs cartes',
                          onTap: () {
                            // reset collection date provider
                            ref
                                .read(settlementCollectionDateProvider.notifier)
                                .state = null;

                            // reset c

                            ref
                                .read(settlementCollectorCollectionProvider
                                    .notifier)
                                .state = null;

                            // reset added inputs provider
                            ref
                                .read(
                                  multipleSettlementsAddedInputsVisibilityProvider
                                      .notifier,
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
                                  const MultipleSettlementsAdditionForm(),
                            );
                          },
                        )
                      : const SizedBox()
                  : const SizedBox(),
              SizedBox(
                width: toolsSpacing,
              ),
              authPermissions![PermissionsValues.admin] ||
                      authPermissions[
                          PermissionsValues.showAllCustomerCardsCash]
                  ? SizedBox(
                      width: 220.0,
                      child: CheckboxListTile(
                        value: ref.watch(
                          cashOperationsShowAllCustomerCardsProvider,
                        ),
                        title: const RSTText(
                          text: 'Toutes les cartes',
                          fontSize: 12,
                        ),
                        hoverColor: Colors.transparent,
                        onChanged: (value) {
                          ref
                              .read(
                                cashOperationsShowAllCustomerCardsProvider
                                    .notifier,
                              )
                              .state = value!;
                        },
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
