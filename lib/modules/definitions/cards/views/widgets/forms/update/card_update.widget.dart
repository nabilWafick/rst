import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/rounded_style/rounded_style.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/common/widgets/selection_tools/type/providers/selection.provider.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/text_button/text_button.widget.dart';
import 'package:rst/common/widgets/textformfield/textformfield.widget.dart';
import 'package:rst/modules/definitions/cards/controllers/forms/forms.controller.dart';
import 'package:rst/modules/definitions/cards/functions/crud/crud.function.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';
import 'package:rst/modules/definitions/cards/providers/cards.provider.dart';
import 'package:rst/modules/definitions/cards/views/widgets/cards.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CardUpdateForm extends StatefulHookConsumerWidget {
  final Card card;
  const CardUpdateForm({
    super.key,
    required this.card,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardUpdateFormState();
}

class _CardUpdateFormState extends ConsumerState<CardUpdateForm> {
  @override
  void initState() {
    initializeDateFormatting('fr');

    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        ref.read(customerSelectionToolProvider('card-update').notifier).state =
            widget.card.customer;

        ref.read(typeSelectionToolProvider('card-update').notifier).state =
            widget.card.type;

        ref.read(cardRepaymentDateProvider.notifier).state =
            widget.card.repaidAt;
      },
    );

    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final showValidatedButton = useState<bool>(true);
    const formCardWidth = 500.0;

    final format = DateFormat.yMMMMEEEEd('fr');
    final cardOwner = ref.watch(customerSelectionToolProvider('card-update'));
    final cardType = ref.watch(typeSelectionToolProvider('card-update'));
    final cardRepaymentDate = ref.watch(cardRepaymentDateProvider);

    return material.AlertDialog(
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
          material.IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              material.Icons.close_rounded,
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
                child: CustomerSelectionToolCard(
                  toolName: 'card-update',
                  width: formCardWidth,
                  customer: cardOwner,
                  roundedStyle: RoundedStyle.full,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: .0,
                ),
                width: formCardWidth,
                child: RSTTextFormField(
                  initialValue: widget.card.label.toString(),
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
                child: RSTTextFormField(
                  initialValue: widget.card.typesNumber.toString(),
                  label: 'Nombre Type',
                  hintText: 'Nombre Type',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  validator: CardValidors.cardTypesNumber,
                  onChanged: CardOnChanged.cardTypesNumber,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: .0,
                ),
                child: TypeSelectionToolCard(
                  toolName: 'card-update',
                  width: formCardWidth,
                  type: cardType,
                  roundedStyle: RoundedStyle.full,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RSTIconButton(
                          icon: material.Icons.date_range,
                          text: 'Remboursée le',
                          onTap: () {
                            FunctionsController.showDate(
                              context: context,
                              ref: ref,
                              stateProvider: cardRepaymentDateProvider,
                              isNullable: true,
                              ereasable: false,
                            );
                          },
                        ),
                        cardRepaymentDate != null
                            ? RSTTextButton(
                                text: 'Réinitialiser',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600,
                                onPressed: () {
                                  ref.invalidate(cardRepaymentDateProvider);
                                },
                              )

                            /* material.IconButton(
                                onPressed: () {
                                  ref.invalidate(cardRepaymentDateProvider);
                                },
                                icon: const Icon(
                                  material.Icons.refresh,
                                  color: RSTColors.primaryColor,
                                ),
                              )*/
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    RSTText(
                      text: cardRepaymentDate != null
                          ? FunctionsController.truncateText(
                              text: format.format(cardRepaymentDate),
                              maxLength: 25,
                            )
                          : '',
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    )
                  ],
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
                          alertDialog: CardUpdateConfirmationDialog(
                            card: widget.card,
                            formKey: formKey,
                            update: CardsCRUDFunctions.update,
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
