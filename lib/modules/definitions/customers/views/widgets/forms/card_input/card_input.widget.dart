import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/family_textformfield/family_textformfield.widget.dart';
import 'package:rst/common/widgets/family_textformfield/on_changed/family_form_field_on_changed.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/common/widgets/selection_tools/type/providers/selection.provider.dart';
import 'package:rst/modules/definitions/cards/models/cards.model.dart';
import 'package:rst/modules/definitions/customers/providers/customers.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CardInput extends StatefulHookConsumerWidget {
//  final int index;
  final bool isVisible;
  final String inputName;
  final Card? card;

  const CardInput({
    super.key,
    //  required this.index,
    required this.isVisible,
    required this.inputName,
    this.card,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardInputState();
}

class _CardInputState extends ConsumerState<CardInput> {
  @override
  void initState() {
    /// in update case, define the product passed as selected product of the input,
    if (widget.card != null) {
      Future.delayed(
        const Duration(
          milliseconds: 100,
        ),
        () {
          ref.read(typeSelectionToolProvider(widget.inputName).notifier).state =
              widget.card!.type;
        },
      );
    }
    super.initState();
  }

  String? cardLabelChecker({required dynamic value}) {
    if (value.length < 5) {
      return 'Entrez un libellé contenant au moins 5 caractères';
    }
    return null;
  }

  String? typesNumberChecker({required dynamic value}) {
    if (value < 1) {
      return 'Entrez un nombre supérieur ou égal à 1';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final showWidget = useState(true);

    final isOldCard = int.tryParse(widget.inputName) != null;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 220.0,
              child: Consumer(
                builder: (context, ref, child) {
                  final cardLabel = widget.card?.label ??
                      FunctionsController
                          .generateRandomStringFromCurrentDateTime();
                  return FamilyTextFormField(
                    inputName: widget.inputName,
                    enabled: !isOldCard,
                    initialValue: cardLabel,
                    label: 'Libellé',
                    hintText: 'Libellé de la carte',
                    textInputType: TextInputType.text,
                    roundedStyle: RoundedStyle.onlyLeft,
                    valueChecker: cardLabelChecker,
                    validator: FamilyFormFieldValidator.textFieldValue,
                    onChanged: FamilyFormFieldOnChanged.textFieldValue,
                  );
                },
              ),
            ),
            SizedBox(
              width: 79.0,
              child: FamilyTextFormField(
                inputName: widget.inputName,
                enabled: !isOldCard,
                initialValue: widget.card?.typesNumber.toString() ?? '1',
                label: 'Nombre',
                hintText: 'Nombre de Type',
                textInputType: TextInputType.text,
                roundedStyle: RoundedStyle.none,
                valueChecker: typesNumberChecker,
                validator: FamilyFormFieldValidator.intFieldValue,
                onChanged: FamilyFormFieldOnChanged.intFieldValue,
              ),
            ),
            TypeSelectionToolCard(
              width: 165.0,
              toolName: widget.inputName,
              enabled: !isOldCard,
              roundedStyle: RoundedStyle.onlyRight,
              textLimit: 15,
            ),
          ],
        ),

        // hide close widget in update case, because card added
        // can only be removed in cards module
        !isOldCard
            ? material.IconButton(
                onPressed: () {
                  // hide the widget
                  showWidget.value = false;

                  // remove it inputs added
                  ref
                      .read(customerCardsInputsAddedVisibilityProvider.notifier)
                      .update((state) {
                    // if input is visible, hide it
                    state[widget.inputName] = showWidget.value;

                    state = {
                      ...state,
                      widget.inputName: showWidget.value,
                    };

                    return state;
                  });

                  // reset product number provider
                  ref.invalidate(
                      familyIntFormFieldValueProvider(widget.inputName));
                },
                icon: const Icon(
                  material.Icons.close_rounded,
                  color: RSTColors.primaryColor,
                  size: 30.0,
                ),
              )
            : const SizedBox(
                width: 10,
              ),
      ],
    );
  }
}
