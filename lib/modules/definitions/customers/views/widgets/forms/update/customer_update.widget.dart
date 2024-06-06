import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/textformfield/textformfield.widget.dart';
import 'package:rst/modules/definitions/customers/controllers/forms/forms.controller.dart';
import 'package:rst/modules/definitions/customers/functions/crud/crud.function.dart';
import 'package:rst/modules/definitions/customers/models/customer/customer.model.dart';
import 'package:rst/modules/definitions/customers/providers/customers.provider.dart';
import 'package:rst/modules/definitions/customers/views/widgets/customers.widget.dart';
import 'package:rst/modules/definitions/customers/views/widgets/forms/card_input/card_input.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CustomerUpdateForm extends StatefulHookConsumerWidget {
  final Customer customer;

  const CustomerUpdateForm({
    super.key,
    required this.customer,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerUpdateFormState();
}

class _CustomerUpdateFormState extends ConsumerState<CustomerUpdateForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 570.0;
    const formCardHeight = 500.0;
    //  final customerPhoto = ref.watch(customerPhotoProvider);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Client',
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
        padding: const EdgeInsets.all(10.0),
        width: formCardWidth,
        height: formCardHeight,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*     Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 15.0,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 25.0,
                          horizontal: 55.0,
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 15.0),
                        //width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: RSTColors.sidebarTextColor,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () async {
                              final imageFromGallery =
                                  await FunctionsController.pickFile();
                              ref.read(customerPhotoProvider.notifier).state =
                                  imageFromGallery;
                            },
                            child: customerPhoto == null &&
                                    widget.customer.photo != null
                                ? Image.network(
                                    widget.customer.photo!,
                                    height: 250.0,
                                    width: 250.0,
                                  )
                                : customerPhoto == null
                                    ? const Icon(
                                        Icons.photo,
                                        size: 150.0,
                                        color: RSTColors.primaryColor,
                                      )
                                    : Image.asset(
                                        customerPhoto,
                                        height: 250.0,
                                        width: 250.0,
                                      ),
                          ),
                        ),
                      ),
                       RSTText(
                        text: 'Produit',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ],
                  ),
                ),
             */
                Wrap(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: formCardWidth / 2.3,
                      child: RSTTextFormField(
                        initialValue: widget.customer.name,
                        label: 'Nom',
                        hintText: 'Nom',
                        isMultilineTextForm: false,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: CustomerValidators.customerName,
                        onChanged: CustomerOnChanged.customerName,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: formCardWidth / 2.3,
                      child: RSTTextFormField(
                        initialValue: widget.customer.firstnames,
                        label: 'Prénoms',
                        hintText: 'Prénoms',
                        isMultilineTextForm: false,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: CustomerValidators.customerFirstnames,
                        onChanged: CustomerOnChanged.customerFirstnames,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: formCardWidth / 2.3,
                      child: RSTTextFormField(
                        initialValue: widget.customer.phoneNumber,
                        label: 'Téléphone',
                        hintText: '+229|00229XXXXXXXX',
                        isMultilineTextForm: false,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: CustomerValidators.customerPhoneNumber,
                        onChanged: CustomerOnChanged.customerPhoneNumber,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: formCardWidth / 2.3,
                      child: RSTTextFormField(
                        initialValue: widget.customer.address,
                        label: 'Adresse',
                        hintText: 'Adresse',
                        isMultilineTextForm: false,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: CustomerValidators.customerAddress,
                        onChanged: CustomerOnChanged.customerAddress,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: formCardWidth / 2.3,
                      child: RSTTextFormField(
                        initialValue: widget.customer.occupation,
                        label: 'Profession',
                        hintText: 'Profession',
                        isMultilineTextForm: false,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: CustomerValidators.customerOccupation,
                        onChanged: CustomerOnChanged.customerOccupation,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      width: formCardWidth / 2.3,
                      child: RSTTextFormField(
                        initialValue: widget.customer.nicNumber?.toString(),
                        label: 'CNI/NPI',
                        hintText: 'CNI/NPI',
                        isMultilineTextForm: false,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        validator: CustomerValidators.customerNicNumber,
                        onChanged: CustomerOnChanged.customerNicNumber,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: CategorySelectionToolCard(
                        category: widget.customer.category,
                        width: formCardWidth / 2.3,
                        toolName: 'customer-update',
                        roundedStyle: RoundedStyle.full,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: PersonalStatusSelectionToolCard(
                        personalStatus: widget.customer.personalStatus,
                        width: formCardWidth / 2.3,
                        toolName: 'customer-update',
                        roundedStyle: RoundedStyle.full,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: EconomicalActivitySelectionToolCard(
                        economicalActivity: widget.customer.economicalActivity,
                        width: formCardWidth / 2.3,
                        toolName: 'customer-update',
                        roundedStyle: RoundedStyle.full,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: LocalitySelectionToolCard(
                        locality: widget.customer.locality,
                        width: formCardWidth / 2.3,
                        toolName: 'customer-update',
                        roundedStyle: RoundedStyle.full,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: CollectorSelectionToolCard(
                    collector: widget.customer.collector,
                    width: formCardWidth * .9,
                    toolName: 'customer-update',
                    roundedStyle: RoundedStyle.full,
                    textLimit: 25,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const RSTText(
                        text: 'Cartes',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                      RSTIconButton(
                        icon: Icons.add_rounded,
                        text: 'Ajouter',
                        onTap: () {
                          // add a new visible cardInput

                          ref
                              .read(
                            customerCardsInputsAddedVisibilityProvider.notifier,
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
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final customerCardsInputsAddedVisibility =
                          ref.watch(customerCardsInputsAddedVisibilityProvider);

                      List<CardInput> customerCardsInputs = [];

                      for (MapEntry<String, bool> cardInputAddedVisibility
                          in customerCardsInputsAddedVisibility.entries) {
                        if (cardInputAddedVisibility.value) {
                          final numKey =
                              int.tryParse(cardInputAddedVisibility.key);

                          if (numKey == null) {
                            customerCardsInputs.add(
                              CardInput(
                                isVisible: cardInputAddedVisibility.value,
                                inputName: cardInputAddedVisibility.key,
                              ),
                            );
                          } else {
                            final oldCard = widget.customer.cards?.firstWhere(
                              (card) => card.id == numKey,
                            );

                            customerCardsInputs.add(
                              CardInput(
                                isVisible: cardInputAddedVisibility.value,
                                inputName: cardInputAddedVisibility.key,
                                card: oldCard,
                              ),
                            );
                          }
                        }
                      }

                      return Column(
                        children: customerCardsInputs,
                      );
                    },
                  ),
                )
              ],
            ),
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
                          alertDialog: CustomerUpdateConfirmationDialog(
                            customer: widget.customer,
                            formKey: formKey,
                            update: CustomersCRUDFunctions.update,
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
