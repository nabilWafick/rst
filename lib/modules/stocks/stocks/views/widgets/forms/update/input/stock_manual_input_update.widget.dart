import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/common.model.dart';
import 'package:rst/common/widgets/elevated_button/elevated_button.widget.dart';
import 'package:rst/common/widgets/selection_tools/selection_tools.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/textformfield/textformfield.widget.dart';
import 'package:rst/modules/stocks/stocks/controllers/forms/forms.controller.dart';
import 'package:rst/modules/stocks/stocks/functions/crud/crud.function.dart';
import 'package:rst/modules/stocks/stocks/models/stock/stock.model.dart';
import 'package:rst/modules/stocks/stocks/views/widgets/forms/forms.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class StockManualInputUpdateForm extends StatefulHookConsumerWidget {
  final Stock stock;
  const StockManualInputUpdateForm({
    super.key,
    required this.stock,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StockManualInputUpdateFormState();
}

class _StockManualInputUpdateFormState
    extends ConsumerState<StockManualInputUpdateForm> {
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
            text: 'Stock Entrée',
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
                child: ProductSelectionToolCard(
                  toolName: 'stock-input',
                  width: formCardWidth,
                  product: widget.stock.product,
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
                  initialValue: widget.stock.inputQuantity?.toString(),
                  label: 'Quantité Entrée',
                  hintText: 'Quantité Entrée',
                  isMultilineTextForm: false,
                  obscureText: false,
                  textInputType: TextInputType.number,
                  validator: StockValidors.stockInputQuantity,
                  onChanged: StockOnChanged.stockInputQuantity,
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
                          alertDialog: StockUpdateConfirmationDialog(
                            stock: widget.stock,
                            formKey: formKey,
                            update: StocksCRUDFunctions.updateStockManualInput,
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
