import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/modules/definitions/products/controllers/forms/forms.controller.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/textformfield/textformfield.widget.dart';

class ProductAddingForm extends StatefulHookConsumerWidget {
  const ProductAddingForm({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductAddingFormState();
}

class _ProductAddingFormState extends ConsumerState<ProductAddingForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 700.0;
    final productPicture = ref.watch(productPhotoProvider);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(20.0),
        width: formCardWidth,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const RSTText(
                        text: 'Produit',
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
                  Container(
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
                                ref.read(productPhotoProvider.notifier).state =
                                    imageFromGallery;
                              },
                              child: productPicture == null
                                  ? const Icon(
                                      Icons.photo,
                                      size: 150.0,
                                      color: RSTColors.primaryColor,
                                    )
                                  : Image.asset(
                                      productPicture,
                                      height: 250.0,
                                      width: 250.0,
                                    ),
                            ),
                          ),
                        ),
                        const RSTText(
                          text: 'Produit',
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth / 2.3,
                        child: const RSTTextFormField(
                          label: 'Nom',
                          hintText: 'Nom',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: ProductValidators.productName,
                          onChanged: ProductOnChanged.productName,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        width: formCardWidth / 2.3,
                        child: const RSTTextFormField(
                          label: 'Prix d\'achat',
                          hintText: 'Prix d\'achat',
                          isMultilineTextForm: false,
                          obscureText: false,
                          textInputType: TextInputType.name,
                          validator: ProductValidators.productPurchasePrice,
                          onChanged: ProductOnChanged.productPurchasePrice,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 35.0,
              ),
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
                              /* await ProductCRUDFunctions.create(
                                context: context,
                                formKey: formKey,
                                ref: ref,
                                showValidatedButton: showValidatedButton,
                              );*/
                            },
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
