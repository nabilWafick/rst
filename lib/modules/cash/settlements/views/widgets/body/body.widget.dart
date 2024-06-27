import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/tooltip/tooltip.widget.dart';
import 'package:rst/common/widgets/tooltip/tooltip_option/tooltip_option.model.dart';
import 'package:rst/modules/cash/settlements/functions/crud/crud.function.dart';
import 'package:rst/modules/cash/settlements/providers/settlements.provider.dart';
import 'package:rst/modules/cash/settlements/views/widgets/forms/actions_confirmations/toggle%20_validation/toggle_validation.widget.dart';
import 'package:rst/modules/cash/settlements/views/widgets/settlements.widget.dart';
import 'package:rst/modules/cash/settlements/views/widgets/simple_view/simple_view.widget.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class SettlementsPageBody extends StatefulHookConsumerWidget {
  const SettlementsPageBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SettlementsPageBodyState();
}

class _SettlementsPageBodyState extends ConsumerState<SettlementsPageBody> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final settlementsList = ref.watch(settlementsListStreamProvider);
    final authPermissions = ref.watch(authPermissionsProvider);
    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: settlementsList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 832,
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
                width: 300.0,
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
                width: 200.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Nombre',
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
                  text: 'Montant',
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
                  text: 'Est Validé',
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
              final settlement = data[index];
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
                              alertDialog: SettlementSimpleView(
                                settlement: settlement,
                              ),
                            );
                          },
                        ),
                        if (settlement.collection != null &&
                            settlement.card.repaidAt == null &&
                            settlement.card.transferredAt == null &&
                            settlement.card.transferredAt == null) ...[
                          authPermissions![PermissionsValues.admin] ||
                                  authPermissions[
                                      PermissionsValues.updateSettlement]
                              ? RSTToolTipOption(
                                  icon: !settlement.isValidated
                                      ? Icons.check
                                      : Icons.close,
                                  iconColor: RSTColors.primaryColor,
                                  name: !settlement.isValidated
                                      ? 'Valider'
                                      : 'Invalider',
                                  onTap: () async {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog:
                                          SettlementValidationToggleConfirmationDialog(
                                        settlement: settlement,
                                        toggle: SettlementsCRUDFunctions
                                            .toggleValidation,
                                      ),
                                    );
                                  },
                                )
                              : null,
                          if (settlement.card.repaidAt == null &&
                              settlement.card.transferredAt == null &&
                              settlement.card.transferredAt == null)
                            authPermissions[PermissionsValues.admin] ||
                                    authPermissions[
                                        PermissionsValues.updateSettlement]
                                ? RSTToolTipOption(
                                    icon: Icons.edit,
                                    iconColor: RSTColors.primaryColor,
                                    name: 'Modifier',
                                    onTap: () async {
                                      FunctionsController.showAlertDialog(
                                        context: context,
                                        alertDialog: SettlementUpdateForm(
                                          settlement: settlement,
                                        ),
                                      );
                                    },
                                  )
                                : null,
                          if (settlement.card.repaidAt == null &&
                              settlement.card.transferredAt == null &&
                              settlement.card.transferredAt == null)
                            authPermissions[PermissionsValues.admin] ||
                                    authPermissions[
                                        PermissionsValues.updateSettlement]
                                ? RSTToolTipOption(
                                    icon: Icons.delete,
                                    iconColor: RSTColors.primaryColor,
                                    name: 'Supprimer',
                                    onTap: () {
                                      FunctionsController.showAlertDialog(
                                        context: context,
                                        alertDialog:
                                            SettlementDeletionConfirmationDialog(
                                          settlement: settlement,
                                          confirmToDelete:
                                              SettlementsCRUDFunctions.delete,
                                        ),
                                      );
                                    },
                                  )
                                : null,
                        ]
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: RSTText(
                      text: FunctionsController.truncateText(
                        text: settlement.card.label,
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
                        text: settlement.number.toString(),
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
                        text:
                            '${(settlement.card.typesNumber * settlement.number * settlement.card.type.stake).toInt()}',
                        maxLength: 45,
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
                      text: settlement.isValidated ? 'Oui' : 'Non',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 200.0,
                    height: 30.0,
                    child: RSTText(
                      text:
                          settlement.collection != null ? 'Normal' : 'Tranfert',
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
                        text:
                            '${settlement.card.customer.name} ${settlement.card.customer.firstnames}',
                        maxLength: 45,
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
                        text:
                            '${settlement.agent.name} ${settlement.agent.firstnames}',
                        maxLength: 45,
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
                      text: format.format(settlement.createdAt),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: RSTText(
                      text: format.format(settlement.updatedAt),
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
