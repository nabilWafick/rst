import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/text/text.widget.dart';
import 'package:rst/common/widgets/tooltip/tooltip.widget.dart';
import 'package:rst/common/widgets/tooltip/tooltip_option/tooltip_option.model.dart';
import 'package:rst/modules/activities/collectors/providers/collectors_activities.provider.dart';
import 'package:rst/modules/activities/collectors/views/widgets/simple_view/simple_view.widget.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CollectorsActivitiesPageBody extends StatefulHookConsumerWidget {
  const CollectorsActivitiesPageBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorsActivitiesPageBodyState();
}

class _CollectorsActivitiesPageBodyState
    extends ConsumerState<CollectorsActivitiesPageBody> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr');
  }

  @override
  Widget build(BuildContext context) {
    final collectorsActivitiesList =
        ref.watch(collectorsActivitiesListStreamProvider);

    final format = DateFormat.yMMMMEEEEd('fr');

    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: collectorsActivitiesList.when(
          data: (data) => HorizontalDataTable(
            leftHandSideColumnWidth: 100,
            rightHandSideColumnWidth: MediaQuery.of(context).size.width + 1232,
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
                  text: 'Date Collecte',
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
                  text: 'Collecteur',
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
                  text: 'Règlement',
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
              final collectorActivity = data[index];
              return collectorActivity.isValidated
                  ? Row(
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
                                    alertDialog: CollectorActivitySimpleView(
                                      settlement: collectorActivity,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 300.0,
                          height: 30.0,
                          child: RSTText(
                            text: format.format(
                                collectorActivity.collection!.collectedAt),
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
                                  '${collectorActivity.card.customer.name} ${collectorActivity.card.customer.firstnames}',
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
                                  '${collectorActivity.collection!.collector.name} ${collectorActivity.collection!.collector.firstnames}',
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
                            text: FunctionsController.truncateText(
                              text: collectorActivity.card.label,
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
                                  '${collectorActivity.number} * ${collectorActivity.card.type.name}',
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
                                  '${(collectorActivity.card.typesNumber * collectorActivity.number * collectorActivity.card.type.stake).toInt()}',
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
                                  '${collectorActivity.agent.name} ${collectorActivity.agent.firstnames}',
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
                            text: format.format(collectorActivity.createdAt),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 300.0,
                          height: 30.0,
                          child: RSTText(
                            text: format.format(collectorActivity.updatedAt),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox();
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
