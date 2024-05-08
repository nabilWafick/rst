import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/modules/definitions/products/providers/products.provider.dart';
import 'package:rst/modules/definitions/products/views/widgets/forms/update/products_update.widget.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:rst/common/widgets/search_input/search_input.widget.dart';
import 'package:rst/common/widgets/text/text.widget.dart';

class ProductsPageBody extends StatefulHookConsumerWidget {
  const ProductsPageBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductsPageBodyState();
}

class _ProductsPageBodyState extends ConsumerState<ProductsPageBody> {
  @override
  Widget build(BuildContext context) {
    final productsList = ref.watch(productsListStreamProvider);

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: productsList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width - 100,
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
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 200.0,
                height: 50.0,
                alignment: Alignment.center,
                child: const RSTText(
                  text: 'Photo',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                width: 700.0,
                height: 50.0,
                alignment: Alignment.center,
                child: RSTSearchInput(
                  hintText: 'Nom',
                  familyName: 'products',
                  searchProvider: searchProvider('products'),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Container(
                width: 250.0,
                height: 50.0,
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Prix d\'achat',
                  textAlign: TextAlign.center,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
              ),
              const SizedBox(
                width: 150.0,
                height: 50.0,
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
                ),
              );
            },
            rightSideItemBuilder: (BuildContext context, int index) {
              final product = data[index];
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      /*  product.photo != null
                          ? FunctionsController.showAlertDialog(
                              context: context,
                              alertDialog: SingleImageShower(
                                imageSource: product.photo!,
                              ),
                            )
                          : () {};*/
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200.0,
                      height: 30.0,
                      child: product.photo != null
                          ? const Icon(
                              Icons.photo,
                              color: RSTColors.primaryColor,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 700.0,
                    height: 30.0,
                    child: RSTText(
                      text: product.name,
                      fontSize: 12.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: 250.0,
                    height: 30.0,
                    child: RSTText(
                      text: '${product.purchasePrice.ceil()} f',
                      fontSize: 12.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(productPhotoProvider.notifier).state = null;
                      FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: ProductUpdateForm(product: product),
                      );
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.edit,
                        color: Colors.green[500],
                      ),
                    ),
                    // showEditIcon: true,
                  ),
                  InkWell(
                    onTap: () async {
                      /*   FunctionsController.showAlertDialog(
                        context: context,
                        alertDialog: ProductDeletionConfirmationDialog(
                          product: product,
                          confirmToDelete: ProductCRUDFunctions.delete,
                        )
                      );*/
                    },
                    child: Container(
                      width: 150.0,
                      height: 30.0,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.delete_sharp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              );
            },
            rowSeparatorWidget: const Divider(),
            scrollPhysics: const BouncingScrollPhysics(),
            horizontalScrollPhysics: const BouncingScrollPhysics(),
          ),
          error: (error, stackTrace) => const RSTText(
            text: 'ERREUR :)',
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          loading: () => const CircularProgressIndicator(
            strokeWidth: 10.0,
          ),
        ),
      ),
    );
  }
}
