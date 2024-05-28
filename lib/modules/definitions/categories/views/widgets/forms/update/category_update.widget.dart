import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/textformfield/textformfield.widget.dart';
import 'package:rst/modules/definitions/categories/controllers/forms/forms.controller.dart';
import 'package:rst/modules/definitions/categories/functions/crud/crud.function.dart';
import 'package:rst/modules/definitions/categories/models/category/category.model.dart';
import 'package:rst/modules/definitions/categories/views/widgets/categories.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CategoryUpdateForm extends StatefulHookConsumerWidget {
  final Category category;

  const CategoryUpdateForm({
    super.key,
    required this.category,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryUpdateFormState();
}

class _CategoryUpdateFormState extends ConsumerState<CategoryUpdateForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;
    //  final categoryPhoto = ref.watch(categoryPhotoProvider);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Categorie',
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
                            ref.read(categoryPhotoProvider.notifier).state =
                                imageFromGallery;
                          },
                          child: categoryPhoto == null &&
                                  widget.category.photo != null
                              ? Image.network(
                                  widget.category.photo!,
                                  height: 250.0,
                                  width: 250.0,
                                )
                              : categoryPhoto == null
                                  ? const Icon(
                                      Icons.photo,
                                      size: 150.0,
                                      color: RSTColors.primaryColor,
                                    )
                                  : Image.asset(
                                      categoryPhoto,
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
           */
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                width: formCardWidth,
                child: RSTTextFormField(
                  label: 'Nom',
                  hintText: 'Nom',
                  initialValue: widget.category.name,
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.name,
                  validator: CategoryValidators.categoryName,
                  onChanged: CategoryOnChanged.categoryName,
                ),
              ),
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
                          alertDialog: CategoryUpdateConfirmationDialog(
                            category: widget.category,
                            formKey: formKey,
                            update: CategoriesCRUDFunctions.update,
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
