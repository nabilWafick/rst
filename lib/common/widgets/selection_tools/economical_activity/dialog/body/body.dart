import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/economical_activity/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/functions/on_changed/on_changed.function.dart';
import 'package:rst/common/widgets/selection_tools/search_input/search_input.widget.dart';
import 'package:rst/modules/definitions/economical_activities/models/structure/structure.model.dart';

class EconomicalActivitySelectionDialogBody extends StatefulHookConsumerWidget {
  final String toolName;
  const EconomicalActivitySelectionDialogBody({
    super.key,
    required this.toolName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EconomicalActivitySelectionDialogBodyState();
}

class _EconomicalActivitySelectionDialogBodyState
    extends ConsumerState<EconomicalActivitySelectionDialogBody> {
  @override
  Widget build(BuildContext context) {
    final economicalActivitiesList =
        ref.watch(economicalActivitiesSelectionListStreamProvider);

    return Expanded(
      child: Stack(
        children: [
          Container(
            width: 800,
            alignment: Alignment.center,
            child: economicalActivitiesList.when(
              data: (data) => HorizontalDataTable(
                leftHandSideColumnWidth: 100,
                rightHandSideColumnWidth: 700,
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
                  final economicalActivity = data[index];
                  return InkWell(
                    onTap: () {
                      ref
                          .read(
                            economicalActivitySelectionToolProvider(
                                    widget.toolName)
                                .notifier,
                          )
                          .state = economicalActivity;

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
                              text: economicalActivity.name,
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
                  field: EconomicalActivityStructure.name,
                  selectionListParametersProvider:
                      economicalActivitiesSelectionListParametersProvider,
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
