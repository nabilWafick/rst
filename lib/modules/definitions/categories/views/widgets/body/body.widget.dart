import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/tooltip/tooltip.widget.dart';
import 'package:rst/common/widgets/tooltip/tooltip_option/tooltip_option.model.dart';
import 'package:rst/modules/definitions/categories/functions/crud/crud.function.dart';
import 'package:rst/modules/definitions/categories/providers/categories.provider.dart';
import 'package:rst/modules/definitions/categories/views/widgets/categories.widget.dart';
import 'package:rst/modules/definitions/categories/views/widgets/simple_view/simple_view.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CategoriesPageBody extends StatefulHookConsumerWidget {
  const CategoriesPageBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoriesPageBodyState();
}

class _CategoriesPageBodyState extends ConsumerState<CategoriesPageBody> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final categoriesList = ref.watch(categoriesListStreamProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        width: 1200,
        alignment: Alignment.center,
        child: categoriesList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: 1100,
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
              final category = data[index];
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
                              alertDialog:
                                  CategorySimpleView(category: category),
                            );
                          },
                        ),
                        RSTToolTipOption(
                          icon: Icons.edit,
                          iconColor: RSTColors.primaryColor,
                          name: 'Modifier',
                          onTap: () async {
                            FunctionsController.showAlertDialog(
                              context: context,
                              alertDialog: CategoryUpdateForm(
                                category: category,
                              ),
                            );
                          },
                        ),
                        RSTToolTipOption(
                          icon: Icons.delete,
                          iconColor: RSTColors.primaryColor,
                          name: 'Supprimer',
                          onTap: () {
                            FunctionsController.showAlertDialog(
                              context: context,
                              alertDialog: CategoryDeletionConfirmationDialog(
                                category: category,
                                confirmToDelete: CategoriesCRUDFunctions.delete,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 400.0,
                    height: 30.0,
                    child: RSTText(
                      text: FunctionsController.truncateText(
                        text: category.name,
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
                      text: format.format(category.createdAt),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 300.0,
                    height: 30.0,
                    child: RSTText(
                      text: format.format(category.updatedAt),
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
