import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/family_textformfield/family_textformfield.widget.dart';
import 'package:rst/common/widgets/family_textformfield/on_changed/family_form_field_on_changed.dart';
import 'package:rst/common/widgets/family_textformfield/validator/family_form_field_validator.dart';
import 'package:rst/common/widgets/selection_tools/product/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class TypeProductInput extends StatefulHookConsumerWidget {
  final bool isVisible;
  final String inputName;
  final Product? product;
  final int? productNumber;
  const TypeProductInput({
    super.key,
    required this.isVisible,
    required this.inputName,
    this.product,
    this.productNumber,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TypeProductInputState();
}

class _TypeProductInputState extends ConsumerState<TypeProductInput> {
  @override
  void initState() {
    /// in update case, define the product passed as selected product of the input,
    if (widget.product != null) {
      Future.delayed(
        const Duration(
          milliseconds: 100,
        ),
        () {
          ref
              .read(productSelectionToolProvider(widget.inputName).notifier)
              .state = widget.product;
        },
      );
    }
    super.initState();
  }

  String? productNumberChecker({required dynamic value}) {
    if (value < 1) {
      return 'Entrez un nombre supérieur ou égal à 1';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final showWidget = useState(true);
    final productNumber = widget.productNumber?.toString() ?? '1';
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ProductSelectionToolCard(
                width: 250,
                toolName: widget.inputName,
                roundedStyle: RoundedStyle.onlyLeft,
                textLimit: 25,
              ),
              SizedBox(
                width: 164.0,
                child: FamilyTextFormField(
                  inputName: widget.inputName,
                  initialValue: productNumber,
                  label: 'Nombre',
                  hintText: 'Nombre de produit',
                  textInputType: TextInputType.text,
                  roundedStyle: RoundedStyle.onlyRight,
                  valueChecker: productNumberChecker,
                  validator: FamilyFormFieldValidator.intFieldValue,
                  onChanged: FamilyFormFieldOnChanged.intFieldValue,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              // hide the widget
              showWidget.value = false;

              // remove it inputs added
              ref
                  .read(typeProductsInputsAddedVisibilityProvider.notifier)
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
              ref.invalidate(familyIntFormFieldValueProvider(widget.inputName));
            },
            icon: const Icon(
              Icons.close_rounded,
              color: RSTColors.primaryColor,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
