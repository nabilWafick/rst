import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/icon_button/icon_button.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/textformfield/textformfield.widget.dart';
import 'package:rst/modules/cash/cash_operations/providers/cash_operations.provider.dart';
import 'package:rst/modules/cash/settlements/controllers/forms/forms.controller.dart';
import 'package:rst/modules/cash/settlements/functions/crud/crud.function.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/cash/settlements/views/widgets/forms/functions/collector_collection.function.dart';
import 'package:rst/utils/colors/colors.util.dart';

class SettlementAdditionForm extends StatefulHookConsumerWidget {
  const SettlementAdditionForm({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettlementAdditionFormState();
}

class _SettlementAdditionFormState
    extends ConsumerState<SettlementAdditionForm> {
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
    final settlementCollectionDate =
        ref.watch(settlementCollectionDateProvider);

    final cashOperationsSelectedCustomerCard =
        ref.watch(cashOperationsSelectedCustomerCardProvider);

    final cashOperationsSelectedCollector =
        ref.watch(cashOperationsSelectedCollectorProvider);
    final settlementCollectorCollection =
        ref.watch(settlementCollectorCollectionProvider);
    final settlementNumber = ref.watch(settlementNumberProvider);

    ref.listen(
      settlementCollectionDateProvider,
      (previous, next) {
        if (next != null) {
          collectionOfCollectorOf(
            ref: ref,
            collector: cashOperationsSelectedCollector!,
            dateTime: next,
          );
        }
      },
    );

    final format = DateFormat.yMMMMEEEEd('fr');

    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const RSTText(
            text: 'Règlement',
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
                  label: 'Nombre',
                  hintText: 'Nombre',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  validator: SettlementValidors.settlementNumber,
                  onChanged: SettlementOnChanged.settlementNumber,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                alignment: Alignment.centerRight,
                width: formCardWidth,
                child: RSTText(
                  text:
                      'Montant: ${(cashOperationsSelectedCustomerCard!.typesNumber * settlementNumber * cashOperationsSelectedCustomerCard.type.stake).toInt()}f',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 15.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RSTIconButton(
                      icon: Icons.date_range,
                      text: 'Date de Collecte',
                      onTap: () {
                        FunctionsController.showDate(
                          isNullable: true,
                          context: context,
                          ref: ref,
                          stateProvider: settlementCollectionDateProvider,
                          ereasable: false,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: RSTText(
                        text: settlementCollectionDate != null
                            ? format.format(settlementCollectionDate)
                            : '',
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //   const SizedBox(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 15.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const RSTText(
                      text: 'Montant Collecte Restant',
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: RSTText(
                        text: settlementCollectorCollection != null
                            ? '${settlementCollectorCollection.rest.toInt()}f'
                            : '0f',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //   const SizedBox(),
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
                        await SettlementsCRUDFunctions.create(
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
