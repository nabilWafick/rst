import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/tooltip/tooltip.widget.dart';
import 'package:rst/common/widgets/tooltip/tooltip_option/tooltip_option.model.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/modules/stocks/stocks/functions/crud/crud.function.dart';
import 'package:rst/modules/stocks/stocks/providers/stocks.provider.dart';
import 'package:rst/modules/stocks/stocks/views/widgets/forms/forms.widget.dart';
import 'package:rst/modules/stocks/stocks/views/widgets/simple_view/simple_view.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class StocksPageBody extends StatefulHookConsumerWidget {
  const StocksPageBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StocksPageBodyState();
}

class _StocksPageBodyState extends ConsumerState<StocksPageBody> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final stocksList = ref.watch(stocksListStreamProvider);
    final authPermissions = ref.watch(authPermissionsProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: stocksList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 1832,
            itemCount: data.length,
            isFixedHeader: true,
            leftHandSideColBackgroundColor: RSTColors.backgroundColor,
            rightHandSideColBackgroundColor: RSTColors.backgroundColor,
            headerWidgets: [
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const RSTText(
                  text: 'N°',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 100.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const SizedBox(),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Produit',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Quantité Initiale',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Quantité Entrée',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Quantité Sortie',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Quantité Stock',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Type Mouvement',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Carte',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Type',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Client',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 400.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Agent',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Insertion',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Dernière Modification',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            leftSideItemBuilder: (context, index) {
              return Container(
                alignment: Alignment.center,
                width: 200.0,
                height: 30.0,
                child: RSTText(
                  text: '${index + 1}',
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
            rightSideItemBuilder: (BuildContext context, int index) {
              final stock = data[index];
              return Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 100.0,
                    height: 30.0,
                    child: RSTTooltip(
                      options: [
                        RSTToolTipOption(
                          icon: Icons.aspect_ratio,
                          iconColor: RSTColors.primaryColor,
                          name: 'Vue Simple',
                          onTap: () {
                            FunctionsController.showAlertDialog(
                              context: context,
                              alertDialog: StockSimpleView(
                                stock: stock,
                              ),
                            );
                          },
                        ),
                        authPermissions![PermissionsValues.admin] ||
                                authPermissions[PermissionsValues.updateStock]
                            ? RSTToolTipOption(
                                icon: Icons.edit,
                                iconColor: RSTColors.primaryColor,
                                name: 'Modifier',
                                onTap: () async {
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog: stock.inputQuantity != null
                                        ? StockManualInputUpdateForm(
                                            stock: stock,
                                          )
                                        : StockManualOutputUpdateForm(
                                            stock: stock,
                                          ),
                                  );
                                },
                              )
                            : null,
                        authPermissions[PermissionsValues.admin] ||
                                authPermissions[PermissionsValues.deleteStock]
                            ? RSTToolTipOption(
                                icon: Icons.delete,
                                iconColor: RSTColors.primaryColor,
                                name: 'Supprimer',
                                onTap: () {
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog:
                                        StockDeletionConfirmationDialog(
                                      stock: stock,
                                      confirmToDelete:
                                          StocksCRUDFunctions.delete,
                                    ),
                                  );
                                },
                              )
                            : null,
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: RSTText(
                      text: FunctionsController.truncateText(
                        text: stock.product.name,
                        maxLength: 35,
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 200.0,
                    height: 30.0,
                    child: RSTText(
                      text: FunctionsController.truncateText(
                        text: stock.initialQuantity.toString(),
                        maxLength: 35,
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 200.0,
                    height: 30.0,
                    child: RSTText(
                      text: stock.inputQuantity?.toString() ?? '',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 200.0,
                    height: 30.0,
                    child: RSTText(
                      text: stock.outputQuantity?.toString() ?? '',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 200.0,
                    height: 30.0,
                    child: RSTText(
                      text: stock.stockQuantity.toString(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: RSTText(
                      text: stock.movementType?.toString() ?? '',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: RSTText(
                      text: FunctionsController.truncateText(
                        text: stock.card?.label ?? '',
                        maxLength: 35,
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: RSTText(
                      text: FunctionsController.truncateText(
                        text: stock.card?.type.name ?? '',
                        maxLength: 35,
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: RSTText(
                      text: FunctionsController.truncateText(
                        text: stock.card != null
                            ? '${stock.card!.customer.name} ${stock.card!.customer.firstnames}'
                            : '',
                        maxLength: 35,
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: RSTText(
                      text: FunctionsController.truncateText(
                        text: '${stock.agent.name} ${stock.agent.firstnames}',
                        maxLength: 35,
                      ),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: RSTText(
                      text: format.format(stock.createdAt),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: RSTText(
                      text: format.format(stock.updatedAt),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
            rowSeparatorWidget: const Divider(),
            scrollPhysics: const BouncingScrollPhysics(),
            horizontalScrollPhysics: const BouncingScrollPhysics(),
          ),
          error: (error, stackTrace) => RSTText(
            text: 'ERREUR :) \n ${error.toString()}',
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          loading: () => const CircularProgressIndicator(
            strokeWidth: 2.5,
          ),
        ),
      ),
    );
  }
}
