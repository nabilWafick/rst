import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/textformfield/textformfield.widget.dart';
import 'package:rst/modules/definitions/types/controllers/forms/forms.controller.dart';
import 'package:rst/modules/definitions/types/functions/crud/crud.function.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/modules/definitions/types/views/widgets/forms/type_product_input/type_product_input.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class TypeAdditionForm extends StatefulHookConsumerWidget {
  const TypeAdditionForm({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TypeAdditionFormState();
}

class _TypeAdditionFormState extends ConsumerState<TypeAdditionForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;
    //  final typePicture = ref.watch(typePhotoProvider);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Type',
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
        width: formCardWidth,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                width: formCardWidth * 1,
                child: const RSTTextFormField(
                  label: 'Nom',
                  hintText: 'Nom',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.name,
                  validator: TypeValidators.typeName,
                  onChanged: TypeOnChanged.typeName,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                width: formCardWidth * 1,
                child: const RSTTextFormField(
                  label: 'Mise',
                  hintText: 'Mise',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  validator: TypeValidators.typeStake,
                  onChanged: TypeOnChanged.typeStake,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const RSTText(
                      text: 'Produits',
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                    RSTIconButton(
                      icon: Icons.add_rounded,
                      text: 'Ajouter',
                      onTap: () {
                        // add a new visible typeProductInput

                        ref
                            .read(
                          typeProductsInputsAddedVisibilityProvider.notifier,
                        )
                            .update((state) {
                          // generate a random inputName
                          final inputName = FunctionsController
                              .generateRandomStringFromCurrentDateTime();

                          state = {
                            ...state,
                            inputName: true,
                          };

                          return state;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final typeProductsInputsAddedVisibility =
                      ref.watch(typeProductsInputsAddedVisibilityProvider);

                  List<TypeProductInput> typeProductsInputs = [];

                  for (MapEntry<String, bool> typeProductInputAddedVisibility
                      in typeProductsInputsAddedVisibility.entries) {
                    if (typeProductInputAddedVisibility.value) {
                      typeProductsInputs.add(
                        TypeProductInput(
                          isVisible: typeProductInputAddedVisibility.value,
                          inputName: typeProductInputAddedVisibility.key,
                        ),
                      );
                    }
                  }

                  return Column(
                    children: typeProductsInputs,
                  );
                },
              )
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
                        await TypesCRUDFunctions.create(
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
    );
  }
}
