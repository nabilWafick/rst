import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/modules/cash/collections/providers/collections.provider.dart';
import 'package:rst/modules/dashboard/providers/dashboard.provider.dart';
import 'package:rst/modules/statistics/collectors_collections/models/collector_collection/collector_collection.model.dart';
import 'package:rst/utils/colors/colors.util.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashboardGlobalCollection extends ConsumerStatefulWidget {
  const DashboardGlobalCollection({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashboardGlobalCollectionState();
}

class _DashboardGlobalCollectionState
    extends ConsumerState<DashboardGlobalCollection> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final globalCollection = ref.watch(collectionsSumProvider);
    final globalCollectorsCollections =
        ref.watch(dashboardGlobalCollectorsCollectionsListStreamProvider);

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: const RSTText(
                  text: 'Collectes Globales',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: RSTText(
                  text: globalCollection.when(
                    data: (data) {
                      return data.ceil().toString();
                    },
                    error: (error, stackTrace) => '0',
                    loading: () => '0',
                  ),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Container(
            height: .5,
            width: double.infinity,
            color: RSTColors.sidebarTextColor,
            margin: const EdgeInsets.only(
              top: 10.0,
              bottom: 17.0,
            ),
          ),
          // todo
          // build dayly collection chart

          globalCollectorsCollections.when(
            data: (data) => buildGlobalCollectorsCollectionsChart(
              collectorsCollections: data,
            ),
            error: (error, stackTrace) => const SizedBox(),
            loading: () => const SizedBox(),
          ),
        ],
      ),
    );
  }

  Widget buildGlobalCollectorsCollectionsChart(
      {required List<CollectorCollection> collectorsCollections}) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: const ChartTitle(text: 'Collectes Globales'),
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: const NumericAxis(
        axisLine: AxisLine(width: 0),
        labelFormat: '{value}',
        majorTickLines: MajorTickLines(size: 0),
      ),
      series: <ColumnSeries<CollectorCollection, String>>[
        ColumnSeries<CollectorCollection, String>(
          dataSource: collectorsCollections,
          xValueMapper: (CollectorCollection collection, _) =>
              FunctionsController.truncateText(
            text: '${collection.name} ${collection.firstnames}',
            maxLength: 15,
          ),
          yValueMapper: (CollectorCollection collection, _) =>
              collection.totalAmount,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(fontSize: 10),
          ),
        )
      ],
      tooltipBehavior: TooltipBehavior(
        enable: true,
        header: '',
        canShowMarker: false,
      ),
    );
  }
}
