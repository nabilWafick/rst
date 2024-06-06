import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/collector/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/functions/on_changed/on_changed.function.dart';
import 'package:rst/common/widgets/selection_tools/search_input/search_input.widget.dart';
import 'package:rst/modules/definitions/collectors/models/structure/structure.model.dart';

class CollectorSelectionDialogBody extends StatefulHookConsumerWidget {
  final String toolName;
  const CollectorSelectionDialogBody({
    super.key,
    required this.toolName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectorSelectionDialogBodyState();
}

class _CollectorSelectionDialogBodyState
    extends ConsumerState<CollectorSelectionDialogBody> {
  @override
  Widget build(BuildContext context) {
    final collectorsList = ref.watch(collectorsSelectionListStreamProvider);

    return Expanded(
      child: Stack(
        children: [
          Container(
            width: 2400,
            alignment: Alignment.center,
            child: collectorsList.when(
              data: (data) => HorizontalDataTable(
                leftHandSideColumnWidth: 100,
                rightHandSideColumnWidth: 1600,
                itemCount: data.length,
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
                  const SizedBox(
                    width: 400.0,
                    height: 50.0,
                  ),
                  const SizedBox(
                    width: 400.0,
                    height: 50.0,
                  ),
                  const SizedBox(
                    width: 400.0,
                    height: 50.0,
                  ),
                  const SizedBox(
                    width: 400.0,
                    height: 50.0,
                  ),
                  const SizedBox(
                    width: 400.0,
                    height: 50.0,
                  ),
                  const SizedBox(
                    width: 400.0,
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
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
                rightSideItemBuilder: (BuildContext context, int index) {
                  final collector = data[index];
                  return InkWell(
                    onTap: () {
                      ref
                          .read(collectorSelectionToolProvider(widget.toolName)
                              .notifier)
                          .state = collector;

                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: 400.0,
                          height: 30.0,
                          child: RSTText(
                            text: FunctionsController.truncateText(
                              text: collector.name,
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
                              text: collector.firstnames,
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
                              text: collector.phoneNumber,
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
                              text: collector.address,
                              maxLength: 45,
                            ),
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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
          Container(
            margin: const EdgeInsets.only(left: 100.0),
            height: 50,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RSTSelectionSearchInput(
                    width: 400.0,
                    hintText: 'Nom',
                    field: CollectorStructure.name,
                    selectionListParametersProvider:
                        collectorsSelectionListParametersProvider,
                    onChanged: SelectionToolSearchInputOnChanged.stringInput,
                  ),
                  RSTSelectionSearchInput(
                    width: 400.0,
                    hintText: 'Prénoms',
                    field: CollectorStructure.firstnames,
                    selectionListParametersProvider:
                        collectorsSelectionListParametersProvider,
                    onChanged: SelectionToolSearchInputOnChanged.stringInput,
                  ),
                  RSTSelectionSearchInput(
                    width: 400.0,
                    hintText: 'Téléphone',
                    field: CollectorStructure.phoneNumber,
                    selectionListParametersProvider:
                        collectorsSelectionListParametersProvider,
                    onChanged: SelectionToolSearchInputOnChanged.stringInput,
                  ),
                  RSTSelectionSearchInput(
                    width: 400.0,
                    hintText: 'Adresse',
                    field: CollectorStructure.address,
                    selectionListParametersProvider:
                        collectorsSelectionListParametersProvider,
                    onChanged: SelectionToolSearchInputOnChanged.stringInput,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
