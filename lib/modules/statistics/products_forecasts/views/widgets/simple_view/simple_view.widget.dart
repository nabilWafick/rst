import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/statistics/products_forecasts/models/product_forecast/product_forecast.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class ProductForecastSimpleView extends ConsumerWidget {
  final ProductForecast productForecast;
  const ProductForecastSimpleView({
    super.key,
    required this.productForecast,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 1200.0;
    final productForecastPerCollectorList = productForecast.getPerCollector();
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RSTText(
            text: productForecast.productName,
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
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      content: Container(
        // color: Colors.blueGrey,
        padding: const EdgeInsets.all(20.0),
        width: formCardWidth,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: productForecastPerCollectorList.map(
                      (productForecastPerCollector) {
                        return productForecastPerCollector.collectorId != null
                            ? Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                ),
                                child: Column(
                                  children: [
                                    RSTText(
                                      text:
                                          '${productForecastPerCollector.collectorName} ${productForecastPerCollector.collectorFirstnames}',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(
                                        minHeight: 80,
                                        maxHeight: 300.0,
                                      ),
                                      child: HorizontalDataTable(
                                        leftHandSideColumnWidth: 100,
                                        rightHandSideColumnWidth: 1700,
                                        itemCount: productForecastPerCollector
                                            .customersIds.length,
                                        isFixedHeader: true,
                                        leftHandSideColBackgroundColor:
                                            Colors.transparent,
                                        rightHandSideColBackgroundColor:
                                            Colors.transparent,
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
                                            width: 300.0,
                                            height: 50.0,
                                            alignment: Alignment.centerLeft,
                                            child: const RSTText(
                                              text: 'Client',
                                              textAlign: TextAlign.start,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(
                                            width: 200.0,
                                            height: 50.0,
                                            alignment: Alignment.centerLeft,
                                            child: const RSTText(
                                              text: 'Nombre Produit',
                                              textAlign: TextAlign.center,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
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
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(
                                            width: 300.0,
                                            height: 50.0,
                                            alignment: Alignment.centerLeft,
                                            child: const RSTText(
                                              text: 'Carte',
                                              textAlign: TextAlign.center,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(
                                            width: 200.0,
                                            height: 50.0,
                                            alignment: Alignment.centerLeft,
                                            child: const RSTText(
                                              text: 'Nombre Type',
                                              textAlign: TextAlign.center,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(
                                            width: 200.0,
                                            height: 50.0,
                                            alignment: Alignment.centerLeft,
                                            child: const RSTText(
                                              text: 'Total Règlement',
                                              textAlign: TextAlign.center,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Container(
                                            width: 300.0,
                                            height: 50.0,
                                            alignment: Alignment.center,
                                            child: const RSTText(
                                              text: 'Montant',
                                              textAlign: TextAlign.start,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
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
                                            ),
                                          );
                                        },
                                        rightSideItemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            children: [
                                              Container(
                                                width: 300.0,
                                                height: 30.0,
                                                alignment: Alignment.centerLeft,
                                                child: RSTText(
                                                  text: FunctionsController
                                                      .truncateText(
                                                    text:
                                                        '${productForecastPerCollector.customersNames[index]} ${productForecastPerCollector.customersNames[index]}',
                                                    maxLength: 30,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Container(
                                                width: 200.0,
                                                height: 30.0,
                                                alignment: Alignment.centerLeft,
                                                child: RSTText(
                                                  text:
                                                      productForecastPerCollector
                                                          .forecastsNumbers[
                                                              index]
                                                          .toString(),
                                                  textAlign: TextAlign.center,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Container(
                                                width: 200.0,
                                                height: 30.0,
                                                alignment: Alignment.centerLeft,
                                                child: RSTText(
                                                  text:
                                                      productForecastPerCollector
                                                          .typesNames[index]
                                                          .toString(),
                                                  textAlign: TextAlign.center,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Container(
                                                width: 300.0,
                                                height: 30.0,
                                                alignment: Alignment.centerLeft,
                                                child: RSTText(
                                                  text:
                                                      productForecastPerCollector
                                                          .cardsLabels[index]
                                                          .toString(),
                                                  textAlign: TextAlign.center,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Container(
                                                width: 200.0,
                                                height: 30.0,
                                                alignment: Alignment.centerLeft,
                                                child: RSTText(
                                                  text:
                                                      productForecastPerCollector
                                                          .cardsTypesNumbers[
                                                              index]
                                                          .toString(),
                                                  textAlign: TextAlign.center,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Container(
                                                width: 200.0,
                                                height: 30.0,
                                                alignment: Alignment.centerLeft,
                                                child: RSTText(
                                                  text: productForecastPerCollector
                                                      .totalsSettlementsNumbers[
                                                          index]
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Container(
                                                width: 300.0,
                                                height: 30.0,
                                                alignment: Alignment.center,
                                                child: RSTText(
                                                  text:
                                                      '${productForecastPerCollector.totalsSettlementsAmounts[index].ceil()}f',
                                                  textAlign: TextAlign.start,
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        rowSeparatorWidget: const Divider(),
                                        scrollPhysics:
                                            const BouncingScrollPhysics(),
                                        horizontalScrollPhysics:
                                            const BouncingScrollPhysics(),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox();
                      },
                    ).toList(),
                  )
                ],
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
            RSTIconButton(
              icon: Icons.print,
              text: 'Imprimer',
              onTap: () {},
            ),
          ],
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
