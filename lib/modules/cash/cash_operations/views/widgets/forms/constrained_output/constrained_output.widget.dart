import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/definitions/cards/views/widgets/forms/actions_confirmations/constrained_satisfaction/constrained_satisfaction.widget.dart';
import 'package:rst/modules/definitions/types/views/widgets/forms/type_product_input/type_product_input.widget.dart';
import 'package:rst/modules/stocks/stocks/functions/crud/crud.function.dart';
import 'package:rst/utils/colors/colors.util.dart';

class ConstrainedCardSatisfactionForm extends StatefulHookConsumerWidget {
  const ConstrainedCardSatisfactionForm({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConstrainedCardSatisfactionFormState();
}

class _ConstrainedCardSatisfactionFormState
    extends ConsumerState<ConstrainedCardSatisfactionForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;
    //  final typePicture = ref.watch(typePhotoProvider);
    final cashOperationsSelectedCustomerCard =
        ref.watch(cashOperationsSelectedCustomerCardProvider);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Sortie Produit',
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
                  vertical: 20.0,
                ),
                child: const RSTText(
                  text:
                      'Tous les produits du types ne sont pas disponibles. Veuillez choisir des produits à donner en échange',
                  fontSize: 12.0,
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
                          cashOperationsConstrainedOutputProductsInputsAddedVisibilityProvider
                              .notifier,
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
                  final cashOperationsConstrainedOutputProductsInputsAddedVisibility =
                      ref.watch(
                          cashOperationsConstrainedOutputProductsInputsAddedVisibilityProvider);

                  List<TypeProductInput>
                      cashOperationsConstrainedOutputProductsInputs = [];

                  for (MapEntry<String,
                          bool> cashOperationsConstrainedOutputProductInputAddedVisibility
                      in cashOperationsConstrainedOutputProductsInputsAddedVisibility
                          .entries) {
                    if (cashOperationsConstrainedOutputProductInputAddedVisibility
                        .value) {
                      cashOperationsConstrainedOutputProductsInputs.add(
                        TypeProductInput(
                          isVisible:
                              cashOperationsConstrainedOutputProductInputAddedVisibility
                                  .value,
                          inputName:
                              cashOperationsConstrainedOutputProductInputAddedVisibility
                                  .key,
                        ),
                      );
                    }
                  }

                  return Column(
                    children: cashOperationsConstrainedOutputProductsInputs,
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
                        FunctionsController.showAlertDialog(
                          context: context,
                          alertDialog:
                              CardConstrainedSatisfactionUpdateConfirmationDialog(
                            card: cashOperationsSelectedCustomerCard!,
                            formKey: formKey,
                            update: StocksCRUDFunctions.createConstrainedOutput,
                          ),
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
