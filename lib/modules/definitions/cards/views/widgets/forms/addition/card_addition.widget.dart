import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/textformfield/textformfield.widget.dart';
import 'package:rst/modules/definitions/cards/controllers/forms/forms.controller.dart';
import 'package:rst/modules/definitions/cards/functions/crud/crud.function.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CardAdditionForm extends StatefulHookConsumerWidget {
  const CardAdditionForm({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardAdditionFormState();
}

class _CardAdditionFormState extends ConsumerState<CardAdditionForm> {
  @override
  void initState() {
    initializeDateFormatting('fr');
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;

    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Carte',
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
                  vertical: .0,
                ),
                width: formCardWidth,
                child: const RSTTextFormField(
                  label: 'Libellé',
                  hintText: 'Libellé',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.text,
                  validator: CardValidors.cardLabel,
                  onChanged: CardOnChanged.cardLabel,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: .0,
                ),
                width: formCardWidth,
                child: const RSTTextFormField(
                  label: 'Nombre Type',
                  hintText: 'Nombre Type',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  validator: CardValidors.cardTypesNumber,
                  onChanged: CardOnChanged.cardTypesNumber,
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
                        await CardsCRUDFunctions.create(
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
