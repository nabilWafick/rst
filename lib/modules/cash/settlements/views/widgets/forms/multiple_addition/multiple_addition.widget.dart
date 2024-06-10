import 'package:collection/collection.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/settlements/functions/crud/crud.function.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/cash/settlements/views/widgets/forms/functions/collector_collection.function.dart';
import 'package:rst/modules/cash/settlements/views/widgets/forms/multiple_addition/input/multiple_settlement_input.widget.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/cards/models/cards.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class MultipleSettlementsAdditionForm extends StatefulHookConsumerWidget {
  const MultipleSettlementsAdditionForm({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultipleSettlementsAdditionFormState();
}

class _MultipleSettlementsAdditionFormState
    extends ConsumerState<MultipleSettlementsAdditionForm> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initializeDateFormatting('fr');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    final cashOperationsSelectedCollector =
        ref.watch(cashOperationsSelectedCollectorProvider);
    final cashOperationsSelectedCustomerCards =
        ref.watch(cashOperationsSelectedCustomerCardsProvider);
    final settlementCollectorCollection =
        ref.watch(settlementCollectorCollectionProvider);
    const formCardWidth = 1000.0;
    final settlementCollectionDate =
        ref.watch(settlementCollectionDateProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    ref.listen(
      settlementCollectionDateProvider,
      (previous, next) {
        if (next != null) {
          collectionOfCollectorOf(
            ref: ref,
            collector: cashOperationsSelectedCollector!,
            dateTime: next,
          );
        }
      },
    );

    return material.AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const RSTText(
                text: 'Règlements Multiples',
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
              material.IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  material.Icons.close_rounded,
                  color: RSTColors.primaryColor,
                  size: 30.0,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  width: 500,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RSTIconButton(
                        icon: material.Icons.date_range,
                        text: 'Date de Collecte',
                        onTap: () {
                          FunctionsController.showDate(
                            context: context,
                            ref: ref,
                            stateProvider: settlementCollectionDateProvider,
                            isNullable: true,
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                        child: RSTText(
                          text: settlementCollectionDate != null
                              ? format.format(settlementCollectionDate)
                              : '',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      //   const SizedBox(),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  width: 500.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const RSTText(
                        text: 'Montant Collecte Restant: ',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                      settlementCollectorCollection != null
                          ? RSTText(
                              text:
                                  '${settlementCollectorCollection.rest.ceil().toString()}f',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            )
                          : const RSTText(text: ''),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          //  color: Colors.blueGrey,
          padding: const EdgeInsets.all(20.0),
          width: formCardWidth,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    final multipleSettlementsAddedInputs = ref.watch(
                        multipleSettlementsAddedInputsVisibilityProvider);
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20.0,
                      ),
                      child: RSTIconButton(
                        // limit the number of customer card settlement visible form to exactly the number of customer card
                        onTap: () {
                          int visibleInputs = 0;

                          // get multiple settlements selected card
                          final multipleSettlementsMapSelectedCards = ref.read(
                              multipleSettlementsSelectedCustomerCardsProvider);

                          // get selected card in list
                          List<Card> multipleSettlementsSelectedCards =
                              multipleSettlementsMapSelectedCards.values
                                  .toList();

                          // define the inputs name
                          final inputName =
                              'multiple-settlement-input-${DateTime.now().millisecond}';

                          for (MapEntry multipleSettlementsAddedInputsEntry
                              in multipleSettlementsAddedInputs.entries) {
                            // verify if the input is visible
                            if (multipleSettlementsAddedInputsEntry.value) {
                              ++visibleInputs;
                            }
                          }

                          if (visibleInputs <
                              cashOperationsSelectedCustomerCards
                                  .where(
                                    (card) =>
                                        card.repaidAt == null &&
                                        card.satisfiedAt == null &&
                                        card.transferredAt == null,
                                  )
                                  .length) {
                            // define new input selected card
                            // define the next multiple settlement input card tool selection value
                            // get the first that is not multiple settlements selected cards

                            ref
                                    .read(
                                      cardSelectionToolProvider(inputName)
                                          .notifier,
                                    )
                                    .state =
                                cashOperationsSelectedCustomerCards
                                    .firstWhereOrNull(
                              (customerCard) =>
                                  !multipleSettlementsSelectedCards.any(
                                    (card) => card.id == customerCard.id,
                                  ) &&
                                  customerCard.repaidAt == null &&
                                  customerCard.satisfiedAt == null &&
                                  customerCard.transferredAt == null,
                            );

                            final newCard =
                                ref.watch(cardSelectionToolProvider(inputName));

                            // add the defined card if it is not null to multipleSettlementsSelectedCards
                            if (newCard != null) {
                              ref
                                  .read(
                                multipleSettlementsSelectedCustomerCardsProvider
                                    .notifier,
                              )
                                  .update(
                                (state) {
                                  state = {
                                    ...state,
                                    inputName: newCard,
                                  };

                                  return state;
                                },
                              );
                            }

                            // add the new multiple settlement input
                            ref
                                .read(
                              multipleSettlementsAddedInputsVisibilityProvider
                                  .notifier,
                            )
                                .update(
                              (state) {
                                return {
                                  ...state,
                                  inputName: true,
                                };
                              },
                            );
                          }
                        },
                        icon: material.Icons.add_circle,
                        text: 'Ajouter une carte',
                      ),
                    );
                  },
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final customerCardsSettlemenentCardsMaps = ref.watch(
                      multipleSettlementsAddedInputsVisibilityProvider,
                    );
                    List<MultipleSettlementInput>
                        customerCardsSettlemenentCardsList = [];
                    for (MapEntry mapEntry
                        in customerCardsSettlemenentCardsMaps.entries) {
                      customerCardsSettlemenentCardsList.add(
                        MultipleSettlementInput(
                          inputName: mapEntry.key,
                          isVisible: mapEntry.value,
                        ),
                      );
                    }

                    return Wrap(
                      runSpacing: 5.0,
                      spacing: 5.0,
                      children: customerCardsSettlemenentCardsList,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer(
              builder: (context, ref, child) {
                final multipleSettlementsSelectedCustomerCards =
                    ref.watch(multipleSettlementsSelectedCustomerCardsProvider);
                final multipleSettlementsAddedInputs =
                    ref.watch(multipleSettlementsAddedInputsVisibilityProvider);

                List<Card> selectedCustomerCards = [];
                // check if a type repeated
                for (MapEntry multipleSettlementsSelectedCustomerCardEntry
                    in multipleSettlementsSelectedCustomerCards.entries) {
                  selectedCustomerCards.add(
                    multipleSettlementsSelectedCustomerCardEntry.value,
                  );
                }

                // store the numbers of settlements
                List<int> settlementsNumbers = [];

                for (MapEntry multipleSettlementsAddedInputsEntry
                    in multipleSettlementsAddedInputs.entries) {
                  // verify if the input is visible
                  if (multipleSettlementsAddedInputsEntry.value) {
                    settlementsNumbers.add(
                      ref.watch(
                        familyIntFormFieldValueProvider(
                          multipleSettlementsAddedInputsEntry.key,
                        ),
                      ),
                    );
                  }
                }

                int totalAmount = 0;

                for (int i = 0; i < selectedCustomerCards.length; ++i) {
                  totalAmount += (selectedCustomerCards[i].typesNumber *
                          selectedCustomerCards[i].type.stake *
                          settlementsNumbers[i])
                      .toInt();
                }

                return RSTText(
                  text: 'Montant Total: ${totalAmount}f',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                );
              },
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 170.0,
                  child: RSTElevatedButton(
                    text: 'Fermer',
                    backgroundColor: RSTColors.sidebarTextColor,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                showValidatedButton.value
                    ? SizedBox(
                        width: 170.0,
                        child: RSTElevatedButton(
                          text: 'Valider',
                          onPressed: () async {
                            SettlementsCRUDFunctions.createMultipleSettlements(
                              context: context,
                              formKey: formKey,
                              ref: ref,
                              showValidatedButton: showValidatedButton,
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
