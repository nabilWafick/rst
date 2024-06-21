import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/modules/statistics/types_stat/models/types_stat.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class TypeStatSimpleView extends ConsumerWidget {
  final String typeName;
  final List<CollectorStatType> collectorsStats;
  const TypeStatSimpleView({
    super.key,
    required this.typeName,
    required this.collectorsStats,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const formCardWidth = 1100.0;

    return AlertDialog(
      contentPadding: const EdgeInsetsDirectional.symmetric(
        vertical: 20.0,
        horizontal: 5.0,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RSTText(
            text: typeName,
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
        margin: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        width: formCardWidth,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: collectorsStats.map(
              (collectorStat) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: RSTText(
                          text:
                              '${collectorStat.collector.name} ${collectorStat.collector.firstnames}          ${collectorStat.customersStats.length}',
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      buildCustomersStatsTable(
                        customersStats: collectorStat.customersStats,
                      )
                    ],
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: 170.0,
          child: RSTElevatedButton(
            text: 'Fermer',
            onPressed: () async {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}

Widget buildCustomersStatsTable(
    {required List<CustomerStatType> customersStats}) {
  return ConstrainedBox(
    constraints: const BoxConstraints(
      maxHeight: 300.0,
      minHeight: 10.0,
    ),
    child: HorizontalDataTable(
      leftHandSideColumnWidth: 100,
      rightHandSideColumnWidth: 1600,
      itemCount: customersStats.length,
      isFixedHeader: true,
      leftHandSideColBackgroundColor: Colors.transparent,
      rightHandSideColBackgroundColor: Colors.transparent,
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
        /* Container(
                  width: 100.0,
                  height: 50.0,
                  alignment: Alignment.center,
                  child: const SizedBox(),
                ),*/
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
          width: 300.0,
          height: 50.0,
          alignment: Alignment.centerLeft,
          child: const RSTText(
            text: 'Nombre Type',
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
            text: 'Règlements',
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
        final customerStat = customersStats[index];
        return Row(
          children: [
            /*  Container(
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
                                alertDialog: TypeStatSimpleView(
                                  typeName: typeStat.name,
                                  collectorsStats: performTypeStatsData(
                                    typeStake: typeStat.stake,
                                    cardsStat: typeStat.cards,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),*/
            Container(
              alignment: Alignment.centerLeft,
              width: 400.0,
              height: 30.0,
              child: RSTText(
                text: FunctionsController.truncateText(
                  text:
                      '${customerStat.customer.name} ${customerStat.customer.firstnames}',
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
                text: customerStat.cardData.label,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 300.0,
              height: 30.0,
              child: RSTText(
                text: customerStat.cardData.typesNumber.toString(),
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 300.0,
              height: 30.0,
              child: RSTText(
                text: customerStat.cardData.totalSettlementNumber.toString(),
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 300.0,
              height: 30.0,
              child: RSTText(
                text: customerStat.cardData.totalSettlementAmount
                    .toInt()
                    .toString(),
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
  );
}
