import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/locality/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/functions/on_changed/on_changed.function.dart';
import 'package:rst/common/widgets/selection_tools/search_input/search_input.widget.dart';
import 'package:rst/modules/definitions/localities/models/structure/structure.model.dart';

class LocalitySelectionDialogBody extends StatefulHookConsumerWidget {
  final String toolName;
  const LocalitySelectionDialogBody({
    super.key,
    required this.toolName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LocalitySelectionDialogBodyState();
}

class _LocalitySelectionDialogBodyState
    extends ConsumerState<LocalitySelectionDialogBody> {
  @override
  Widget build(BuildContext context) {
    final localitiesList =
        ref.watch(localitiesSelectionListStreamProvider(widget.toolName));

    return Expanded(
      child: Stack(
        children: [
          Container(
            width: 500,
            alignment: Alignment.center,
            child: localitiesList.when(
              data: (data) => HorizontalDataTable(
                leftHandSideColumnWidth: 100,
                rightHandSideColumnWidth: 400,
                itemCount: data.length,
                isFixedHeader: true,
                leftHandSideColBackgroundColor: Colors.transparent,
                rightHandSideColBackgroundColor: Colors.transparent,
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
                  const SizedBox(
                    width: 400.0,
                    height: 50.0,
                  ),
                  const SizedBox(
                    width: 300.0,
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
                  final locality = data[index];
                  return InkWell(
                    onTap: () {
                      ref
                          .read(
                            localitySelectionToolProvider(widget.toolName)
                                .notifier,
                          )
                          .state = locality;

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
                              text: locality.name,
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
          SizedBox(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 100.0,
                ),
                RSTSelectionSearchInput(
                  width: 400.0,
                  hintText: 'Nom',
                  field: LocalityStructure.name,
                  selectionListParametersProvider:
                      localitiesSelectionListParametersProvider(
                          widget.toolName),
                  onChanged: SelectionToolSearchInputOnChanged.stringInput,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
