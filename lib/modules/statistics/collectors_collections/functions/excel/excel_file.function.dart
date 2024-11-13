// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/controller_response/controller_response.model.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/definitions/collectors/controllers/collectors.controller.dart';
import 'package:rst/modules/statistics/collectors_collections/models/collectors_collections.dart';
import 'package:rst/modules/statistics/collectors_collections/providers/collectors_collections.provider.dart';

Future<void> generateCollectorsCollectionsExcelFile({
  required BuildContext context,
  required WidgetRef ref,
  required Map<String, dynamic> listParameters,
  required ValueNotifier<bool> showExportButton,
}) async {
  // hide Export button
  showExportButton.value = false;
  try {
    // hide Export button
    showExportButton.value = false;

    final collectionType = ref.watch(collectorCollectionTypeProvider);

    ControllerResponse controllerResponse;

    switch (collectionType) {
      case CollectorCollectionType.day:
        controllerResponse = await CollectorsController.getDayCollections(
          listParameters: listParameters,
        );
        break;
      case CollectorCollectionType.week:
        controllerResponse = await CollectorsController.getWeekCollections(
          listParameters: listParameters,
        );
        break;
      case CollectorCollectionType.month:
        controllerResponse = await CollectorsController.getMonthCollections(
          listParameters: listParameters,
        );
        break;
      case CollectorCollectionType.year:
        controllerResponse = await CollectorsController.getYearCollections(
          listParameters: listParameters,
        );
        break;

      default:
        controllerResponse = await CollectorsController.getGlobalCollections(
          listParameters: listParameters,
        );
    }

    // Create a new Excel workbook
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Write headers with formatting
    sheet.cell(CellIndex.indexByString("A1")).value = TextCellValue("Nom");
    sheet.cell(CellIndex.indexByString("B1")).value = TextCellValue("Prénoms");
    sheet.cell(CellIndex.indexByString("C1")).value =
        TextCellValue("Téléphone");
    sheet.cell(CellIndex.indexByString("D1")).value =
        TextCellValue("Nombre Collectes");
    sheet.cell(CellIndex.indexByString("E1")).value =
        TextCellValue("Collecte Totale");

    // cast data to type model list
    final collectorsCollections =
        List<CollectorCollection>.from(controllerResponse.data);

    // Write data rows
    for (int i = 0; i < collectorsCollections.length; i++) {
      sheet
          .cell(
            CellIndex.indexByString("A${i + 2}"),
          )
          .value = TextCellValue(collectorsCollections[i].name);

      sheet
          .cell(
            CellIndex.indexByString("B${i + 2}"),
          )
          .value = TextCellValue(
        collectorsCollections[i].firstnames,
      );

      sheet
          .cell(
            CellIndex.indexByString("C${i + 2}"),
          )
          .value = TextCellValue(
        collectorsCollections[i].phoneNumber,
      );

      sheet
              .cell(
                CellIndex.indexByString("D${i + 2}"),
              )
              .value =
          TextCellValue(collectorsCollections[i].totalCollections.toString());

      sheet
              .cell(
                CellIndex.indexByString("E${i + 2}"),
              )
              .value =
          TextCellValue(collectorsCollections[i].totalAmount.toString());
    }

    // Assuming excel.save() returns the bytes of the Excel file
    var fileBytes = excel.encode();
    var directory = await getApplicationDocumentsDirectory();

    // Specify the output file path
    String filePath = '${directory.path}/collectes_periodiques.xlsx';

    // Write the bytes to the file
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: 'Excel',
      error: null,
      message: 'Fichier généré',
    );

    // show Export button
    showExportButton.value = true;

    // hide dialog
    Navigator.of(context).pop();

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  } catch (error) {
    debugPrint(error.toString());

    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: null,
      error: 'Excel',
      message: 'Une erreur s\'est produite',
    );

    // show Export button
    showExportButton.value = true;

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }
}
