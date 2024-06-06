import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/textformfield/textformfield.widget.dart';
import 'package:rst/modules/definitions/collectors/controllers/forms/forms.controller.dart';
import 'package:rst/modules/definitions/collectors/functions/crud/crud.function.dart';
import 'package:rst/modules/definitions/collectors/models/collector/collector.model.dart';
import 'package:rst/modules/definitions/collectors/views/widgets/collectors.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CollectorUpdateForm extends StatefulHookConsumerWidget {
  final Collector collector;

  const CollectorUpdateForm({
    super.key,
    required this.collector,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorUpdateFormState();
}

class _CollectorUpdateFormState extends ConsumerState<CollectorUpdateForm> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;
    //  final collectorPhoto = ref.watch(collectorPhotoProvider);
    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Collecteur',
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
                            ref.read(collectorPhotoProvider.notifier).state =
                                imageFromGallery;
                          },
                          child: collectorPhoto == null &&
                                  widget.collector.photo != null
                              ? Image.network(
                                  widget.collector.photo!,
                                  height: 250.0,
                                  width: 250.0,
                                )
                              : collectorPhoto == null
                                  ? const Icon(
                                      Icons.photo,
                                      size: 150.0,
                                      color: RSTColors.primaryColor,
                                    )
                                  : Image.asset(
                                      collectorPhoto,
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
                      initialValue: widget.collector.name,
                      label: 'Nom',
                      hintText: 'Nom',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: CollectorValidators.collectorName,
                      onChanged: CollectorOnChanged.collectorName,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    child: RSTTextFormField(
                      initialValue: widget.collector.firstnames,
                      label: 'Prénoms',
                      hintText: 'Prénoms',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: CollectorValidators.collectorFirstnames,
                      onChanged: CollectorOnChanged.collectorFirstnames,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    child: RSTTextFormField(
                      initialValue: widget.collector.phoneNumber,
                      label: 'Téléphone',
                      hintText: '+229|00229XXXXXXXX',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: CollectorValidators.collectorPhoneNumber,
                      onChanged: CollectorOnChanged.collectorPhoneNumber,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    width: formCardWidth / 2.3,
                    child: RSTTextFormField(
                      initialValue: widget.collector.address,
                      label: 'Adresse',
                      hintText: 'Adresse',
                      isMultilineTextForm: false,
                      obscureText: false,
                      textInputType: TextInputType.name,
                      validator: CollectorValidators.collectorAddress,
                      onChanged: CollectorOnChanged.collectorAddress,
                    ),
                  ),
                ],
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
                          alertDialog: CollectorUpdateConfirmationDialog(
                            collector: widget.collector,
                            formKey: formKey,
                            update: CollectorsCRUDFunctions.update,
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
