import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/widgets/common.widgets.dart';
import 'package:rst/common/widgets/selection_tools/customer/providers/selection.provider.dart';
import 'package:rst/common/widgets/selection_tools/functions/on_changed/on_changed.function.dart';
import 'package:rst/common/widgets/selection_tools/search_input/search_input.widget.dart';
import 'package:rst/modules/definitions/customers/models/structure/structure.model.dart';
import 'package:rst/utils/colors/colors.util.dart';

class CustomerSelectionDialogBody extends StatefulHookConsumerWidget {
  final String toolName;
  const CustomerSelectionDialogBody({
    super.key,
    required this.toolName,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomerSelectionDialogBodyState();
}

class _CustomerSelectionDialogBodyState
    extends ConsumerState<CustomerSelectionDialogBody> {
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final customersList =
        ref.watch(customersSelectionListStreamProvider(widget.toolName));

    return Expanded(
      child: Stack(
        children: [
          Container(
            width: 2500,
            alignment: Alignment.center,
            child: customersList.when(
              data: (data) => HorizontalDataTable(
                leftHandSideColumnWidth: 100,
                rightHandSideColumnWidth: 2400,
                itemCount: data.length,
                isFixedHeader: true,
                leftHandSideColBackgroundColor: Colors.transparent,
                rightHandSideColBackgroundColor: Colors.transparent,
                horizontalScrollbarStyle: ScrollbarStyle(
                  thickness: 20.0,
                  thumbColor: RSTColors.sidebarTextColor.withOpacity(.2),
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
                  final customer = data[index];
                  return InkWell(
                    onTap: () {
                      ref
                          .read(customerSelectionToolProvider(widget.toolName)
                              .notifier)
                          .state = customer;

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
                              text: customer.name,
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
                              text: customer.firstnames,
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
                              text: customer.phoneNumber,
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
                              text: customer.address,
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
                              text: customer.occupation ?? '',
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
                              text: customer.nicNumber?.toString() ?? '',
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
            child: Scrollbar(
              controller: scrollController,
              child: SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RSTSelectionSearchInput(
                      width: 400.0,
                      hintText: 'Nom',
                      field: CustomerStructure.name,
                      selectionListParametersProvider:
                          customersSelectionListParametersProvider(
                              widget.toolName),
                      onChanged: SelectionToolSearchInputOnChanged.stringInput,
                    ),
                    RSTSelectionSearchInput(
                      width: 400.0,
                      hintText: 'Prénoms',
                      field: CustomerStructure.firstnames,
                      selectionListParametersProvider:
                          customersSelectionListParametersProvider(
                              widget.toolName),
                      onChanged: SelectionToolSearchInputOnChanged.stringInput,
                    ),
                    RSTSelectionSearchInput(
                      width: 400.0,
                      hintText: 'Téléphone',
                      field: CustomerStructure.phoneNumber,
                      selectionListParametersProvider:
                          customersSelectionListParametersProvider(
                              widget.toolName),
                      onChanged: SelectionToolSearchInputOnChanged.stringInput,
                    ),
                    RSTSelectionSearchInput(
                      width: 400.0,
                      hintText: 'Adresse',
                      field: CustomerStructure.address,
                      selectionListParametersProvider:
                          customersSelectionListParametersProvider(
                              widget.toolName),
                      onChanged: SelectionToolSearchInputOnChanged.stringInput,
                    ),
                    RSTSelectionSearchInput(
                      width: 400.0,
                      hintText: 'Profession',
                      field: CustomerStructure.occupation,
                      selectionListParametersProvider:
                          customersSelectionListParametersProvider(
                              widget.toolName),
                      onChanged: SelectionToolSearchInputOnChanged.stringInput,
                    ),
                    RSTSelectionSearchInput(
                      width: 400.0,
                      hintText: 'NCI/NPI',
                      field: CustomerStructure.nicNumber,
                      selectionListParametersProvider:
                          customersSelectionListParametersProvider(
                              widget.toolName),
                      onChanged: SelectionToolSearchInputOnChanged.intInput,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
