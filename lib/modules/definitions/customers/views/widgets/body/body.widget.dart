// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart' as material;
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/tooltip/tooltip.widget.dart';
import 'package:rst/common/widgets/tooltip/tooltip_option/tooltip_option.model.dart';
import 'package:rst/modules/definitions/agents/providers/permissions_values.dart';
import 'package:rst/modules/definitions/cards/controllers/cards.controller.dart';
import 'package:rst/modules/definitions/customers/functions/crud/crud.function.dart';
import 'package:rst/modules/definitions/customers/providers/customers.provider.dart';
import 'package:rst/modules/definitions/customers/views/widgets/customers.widget.dart';
import 'package:rst/modules/definitions/customers/views/widgets/simple_view/simple_view.widget.dart';
import 'package:rst/modules/definitions/cards/models/cards.model.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CustomersPageBody extends StatefulHookConsumerWidget {
  const CustomersPageBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomersPageBodyState();
}

class _CustomersPageBodyState extends ConsumerState<CustomersPageBody> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final customersList = ref.watch(customersListStreamProvider);
    final authPermissions = ref.watch(authPermissionsProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: customersList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 3232,
            itemCount: data.length,
            isFixedHeader: true,
            leftHandSideColBackgroundColor: RSTColors.backgroundColor,
            rightHandSideColBackgroundColor: RSTColors.backgroundColor,
            horizontalScrollbarStyle: ScrollbarStyle(
              thickness: 25.0,
              thumbColor: material.Colors.blueGrey[200],
            ),
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
                  text: 'Nom',
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
                  text: 'Prénoms',
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
                  text: 'Téléphone',
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
                  text: 'Adresse',
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
                  text: 'Profession',
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
                  text: 'CNI/NPI',
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
                  text: 'Collecteur',
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
                  text: 'Localité',
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
                  text: 'Catégorie',
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
                  text: 'Activité Économique',
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
                  text: 'Statut Personnel',
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
              final customer = data[index];
              return material.SingleChildScrollView(
                scrollDirection: material.Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 100.0,
                      height: 30.0,
                      child: RSTTooltip(
                        options: [
                          RSTToolTipOption(
                            icon: material.Icons.aspect_ratio,
                            iconColor: RSTColors.primaryColor,
                            name: 'Vue Simple',
                            onTap: () {
                              FunctionsController.showAlertDialog(
                                context: context,
                                alertDialog: CustomerSimpleView(
                                  customer: customer,
                                ),
                              );
                            },
                          ),
                          authPermissions![PermissionsValues.admin] ||
                                  authPermissions[
                                      PermissionsValues.updateCustomer]
                              ? RSTToolTipOption(
                                  icon: material.Icons.edit,
                                  iconColor: RSTColors.primaryColor,
                                  name: 'Modifier',
                                  onTap: () async {
                                    // invalidate cardsTypesInputsAddedProvider
                                    ref.invalidate(
                                        customerCardsInputsAddedVisibilityProvider);

                                    // fetch all cards of customer cards
                                    List<Card> customerCards = [];
                                    try {
                                      // get customer cards number
                                      // because the number can be knowed without
                                      // asking the database
                                      final customerCardsNumberData =
                                          await CardsController.countSpecific(
                                        listParameters: {
                                          'skip':
                                              0, // This value is override in backend
                                          'take':
                                              100, // This value is override in backend
                                          'where': {
                                            'customer': {
                                              'id': customer.id!.toInt(),
                                            },
                                          },
                                        },
                                      );

                                      // fetch the cards
                                      final customerCardsData =
                                          await CardsController.getMany(
                                              listParameters: {
                                            'skip': 0,
                                            'take': customerCardsNumberData
                                                .data.count,
                                            'where': {
                                              'customer': {
                                                'id': customer.id!.toInt(),
                                              },
                                            },
                                          });

                                      // store the cards
                                      customerCards = List<Card>.from(
                                        customerCardsData.data,
                                      );
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }

                                    // update customer data
                                    customer.cards = customerCards;

                                    // add the cards inputs
                                    for (Card card in customerCards) {
                                      ref
                                          .read(
                                              customerCardsInputsAddedVisibilityProvider
                                                  .notifier)
                                          .update((state) {
                                        state = {
                                          ...state,
                                          card.id.toString(): true,
                                        };

                                        return state;
                                      });
                                    }

                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog: CustomerUpdateForm(
                                        customer: customer,
                                      ),
                                    );
                                  },
                                )
                              : null,
                          authPermissions[PermissionsValues.admin] ||
                                  authPermissions[
                                      PermissionsValues.deleteCustomer]
                              ? RSTToolTipOption(
                                  icon: material.Icons.delete,
                                  iconColor: RSTColors.primaryColor,
                                  name: 'Supprimer',
                                  onTap: () {
                                    FunctionsController.showAlertDialog(
                                      context: context,
                                      alertDialog:
                                          CustomerDeletionConfirmationDialog(
                                        customer: customer,
                                        confirmToDelete:
                                            CustomersCRUDFunctions.delete,
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
                          text: customer.name,
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
                          text: customer.firstnames,
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
                          text: customer.phoneNumber,
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
                          text: customer.address,
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
                          text: customer.occupation ?? '',
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
                          text: customer.nicNumber?.toString() ?? '',
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
                          text: customer.collector != null
                              ? '${customer.collector?.name} ${customer.collector?.firstnames}'
                              : '',
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
                          text: customer.locality?.name ?? '',
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
                          text: customer.category?.name ?? '',
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
                          text: customer.economicalActivity?.name ?? '',
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
                          text: customer.personalStatus?.name ?? '',
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
                        text: format.format(customer.createdAt),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: 300.0,
                      height: 30.0,
                      child: RSTText(
                        text: format.format(customer.updatedAt),
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
            rowSeparatorWidget: const material.Divider(),
            scrollPhysics: const BouncingScrollPhysics(),
            horizontalScrollPhysics: const BouncingScrollPhysics(),
          ),
          error: (error, stackTrace) => RSTText(
            text: 'ERREUR :) \n ${error.toString()}',
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          loading: () => const material.CircularProgressIndicator(
            strokeWidth: 2.5,
          ),
        ),
      ),
    );
  }
}
