import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/family_textformfield/family_textformfield.widget.dart';
import 'package:rst/common/widgets/family_textformfield/on_changed/family_form_field_on_changed.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';
import 'package:rst/common/widgets/selection_tools/customer_card/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/types/models/types.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class MultipleSettlementInput extends StatefulHookConsumerWidget {
  final String inputName;
  final bool isVisible;
  const MultipleSettlementInput({
    super.key,
    required this.inputName,
    required this.isVisible,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultipleSettlementInputState();
}

class _MultipleSettlementInputState
    extends ConsumerState<MultipleSettlementInput> {
  String? settlementNumberChecker({required dynamic value}) {
    if (value <= 0 || value > 372) {
      return 'Entrez un nombre valide entre 1 et 372';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final showInput = useState<bool>(widget.isVisible);
    /* final cashOperationsSelectedCustomerCards = ref
        .watch(cashOperationsSelectedCustomerCardsProvider);*/

    final selectedCustomerCard = ref.watch(
      cardSelectionToolProvider(widget.inputName),
    );

    final settlementNumber = ref.watch(
      familyIntFormFieldValueProvider(widget.inputName),
    );

    ref.listen(cardSelectionToolProvider(widget.inputName), (previous, next) {
      // update input card
      Future.delayed(
        const Duration(
          milliseconds: 100,
        ),
        () {
          if (next != null) {
            ref
                .read(
              multipleSettlementsSelectedCustomerCardsProvider.notifier,
            )
                .update((state) {
              state = {
                ...state,
                widget.inputName: next,
              };

              return state;
            });
          }
        },
      );
    });

    return showInput.value
        ? SizedBox(
            width: 500,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CardSelectionToolCard(
                        toolName: widget.inputName,
                        roundedStyle: RoundedStyle.full,
                      ),
                      TypeBox(
                        customerCardType: selectedCustomerCard?.type ??
                            Type(
                              name: 'Type*',
                              stake: 1,
                              typeProducts: [],
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            ),
                      ),
                      material.IconButton(
                        onPressed: () {
                          showInput.value = false;

                          ref
                              .read(
                                  multipleSettlementsAddedInputsVisibilityProvider
                                      .notifier)
                              .update(
                            (state) {
                              // if input is visible, hide it

                              state = {
                                ...state,
                                widget.inputName: showInput.value,
                              };

                              return state;
                            },
                          );

                          // remove the card from the selected in multiple settlement cards

                          ref
                              .read(
                            multipleSettlementsSelectedCustomerCardsProvider
                                .notifier,
                          )
                              .update((state) {
                            Map<String, Card> newMap = {};

                            for (MapEntry<String, Card> stateEntry
                                in state.entries) {
                              if (stateEntry.key != widget.inputName) {
                                newMap[stateEntry.key] = stateEntry.value;
                              }
                            }

                            return newMap;
                          });
                        },
                        icon: const Icon(
                          material.Icons.close,
                          size: 30.0,
                          color: RSTColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: 500,
                      child: FamilyTextFormField(
                        inputName: widget.inputName,
                        label: 'Nombre',
                        hintText: 'Nombre',
                        valueChecker: settlementNumberChecker,
                        roundedStyle: RoundedStyle.full,
                        textInputType: TextInputType.number,
                        validator: FamilyFormFieldValidator.intFieldValue,
                        onChanged: FamilyFormFieldOnChanged.intFieldValue,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      child: LabelValue(
                          label: 'Montant',
                          value:
                              '${selectedCustomerCard!.typesNumber * selectedCustomerCard.type.stake.ceil() * settlementNumber}f'),
                    ),
                  ],
                )
              ],
            ),
          )
        : const SizedBox();
  }
}
