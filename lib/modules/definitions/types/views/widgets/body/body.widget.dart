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
import 'package:rst/modules/definitions/types/functions/crud/crud.function.dart';
import 'package:rst/modules/definitions/types/models/types.model.dart';
import 'package:rst/modules/definitions/types/providers/types.provider.dart';
import 'package:rst/modules/definitions/types/views/widgets/types.widget.dart';
import 'package:rst/modules/definitions/types/views/widgets/simple_view/simple_view.widget.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';

class TypesPageBody extends StatefulHookConsumerWidget {
  const TypesPageBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TypesPageBodyState();
}

class _TypesPageBodyState extends ConsumerState<TypesPageBody> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final typesList = ref.watch(typesListStreamProvider);
    final authPermissions = ref.watch(authPermissionsProvider);
    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: typesList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 2000,
            itemCount: data.length,
            isFixedHeader: true,
            leftHandSideColBackgroundColor: RSTColors.backgroundColor,
            rightHandSideColBackgroundColor: RSTColors.backgroundColor,
            horizontalScrollbarStyle: ScrollbarStyle(
              thickness: 25.0,
              thumbColor: Colors.blueGrey[200],
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
                width: 300.0,
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
                width: 300.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Mise',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                width: 700.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Produits',
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
              final type = data[index];
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
                              alertDialog: TypeSimpleView(type: type),
                            );
                          },
                        ),
                        authPermissions![PermissionsValues.admin] ||
                                authPermissions[PermissionsValues.updateType]
                            ? RSTToolTipOption(
                                icon: Icons.edit,
                                iconColor: RSTColors.primaryColor,
                                name: 'Modifier',
                                onTap: () async {
                                  // invalidate typeProductsInputsAddedProvider
                                  ref.invalidate(
                                      typeProductsInputsAddedVisibilityProvider);

                                  // add the type products inputs

                                  for (TypeProduct typeProduct
                                      in type.typeProducts) {
                                    ref
                                        .read(
                                            typeProductsInputsAddedVisibilityProvider
                                                .notifier)
                                        .update((state) {
                                      state = {
                                        ...state,
                                        typeProduct.productId.toString(): true,
                                      };

                                      return state;
                                    });
                                  }

                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog: TypeUpdateForm(
                                      type: type,
                                    ),
                                  );
                                },
                              )
                            : null,
                        authPermissions[PermissionsValues.admin] ||
                                authPermissions[PermissionsValues.deleteType]
                            ? RSTToolTipOption(
                                icon: Icons.delete,
                                iconColor: RSTColors.primaryColor,
                                name: 'Supprimer',
                                onTap: () {
                                  FunctionsController.showAlertDialog(
                                    context: context,
                                    alertDialog: TypeDeletionConfirmationDialog(
                                      type: type,
                                      confirmToDelete:
                                          TypesCRUDFunctions.delete,
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
                    width: 300.0,
                    height: 30.0,
                    child: RSTText(
                      text: FunctionsController.truncateText(
                        text: type.name,
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
                      text: '${type.stake.ceil()} f',
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      String typeProducts = '';

                      for (int j = 0; j < type.typeProducts.length; j++) {
                        if (typeProducts.isEmpty) {
                          typeProducts =
                              '${type.typeProducts[j].productNumber} * ${type.typeProducts[j].product.name}';
                        } else {
                          typeProducts =
                              '$typeProducts, ${type.typeProducts[j].productNumber} * ${type.typeProducts[j].product.name}';
                        }
                      }

                      return Container(
                        alignment: Alignment.centerLeft,
                        width: 700.0,
                        height: 30.0,
                        child: RSTText(
                          text: FunctionsController.truncateText(
                            text: typeProducts,
                            maxLength: 80,
                          ),
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: RSTText(
                      text: format.format(type.createdAt),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: RSTText(
                      text: format.format(type.updatedAt),
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
