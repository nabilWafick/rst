// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/cash/settlements/controllers/settlements.controller.dart';
import 'package:rst/modules/cash/settlements/models/settlement/settlement.model.dart';

Future<void> generateCollectorActivitiesExcelFile({
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

    // format
    final format = DateFormat.yMMMMEEEEd('fr');

    // Get settlements list
    final settlementsList = await SettlementsController.getMany(
      listParameters: listParameters,
    );

    // Create a new Excel workbook
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Write headers with formatting
    sheet.cell(CellIndex.indexByString("A1")).value =
        const TextCellValue("Date Collecte");
    sheet.cell(CellIndex.indexByString("B1")).value =
        const TextCellValue("Client");
    sheet.cell(CellIndex.indexByString("C1")).value =
        const TextCellValue("Collecteur");
    sheet.cell(CellIndex.indexByString("D1")).value =
        const TextCellValue("Carte");
    sheet.cell(CellIndex.indexByString("E1")).value =
        const TextCellValue("Règlement");
    sheet.cell(CellIndex.indexByString("F1")).value =
        const TextCellValue("Montant");
    sheet.cell(CellIndex.indexByString("G1")).value =
        const TextCellValue("Agent");
    sheet.cell(CellIndex.indexByString("H1")).value =
        const TextCellValue("Insertion");
    sheet.cell(CellIndex.indexByString("I1")).value =
        const TextCellValue("Dernière Modification");

    // cast data to settlement model list
    final settlements = List<Settlement>.from(settlementsList.data);

    // Write data rows
    for (int i = 0; i < settlements.length; i++) {
      sheet
              .cell(
                CellIndex.indexByString("A${i + 2}"),
              )
              .value =
          TextCellValue(format.format(settlements[i].collection!.collectedAt));

      sheet
              .cell(
                CellIndex.indexByString("B${i + 2}"),
              )
              .value =
          TextCellValue(
              '${settlements[i].card.customer.name} ${settlements[i].card.customer.firstnames}');

      sheet
              .cell(
                CellIndex.indexByString("C${i + 2}"),
              )
              .value =
          TextCellValue(
              '${settlements[i].collection!.collector.name} ${settlements[i].collection!.collector.firstnames}');
      sheet
          .cell(
            CellIndex.indexByString("D${i + 2}"),
          )
          .value = TextCellValue(
        settlements[i].card.label,
      );

      sheet
          .cell(
            CellIndex.indexByString("E${i + 2}"),
          )
          .value = TextCellValue(
        '${settlements[i].number} * ${settlements[i].card.type.name}',
      );

      sheet
          .cell(
            CellIndex.indexByString("F${i + 2}"),
          )
          .value = TextCellValue(
        '${(settlements[i].card.typesNumber * settlements[i].number * settlements[i].card.type.stake).toInt()}',
      );

      sheet
          .cell(
            CellIndex.indexByString("G${i + 2}"),
          )
          .value = TextCellValue(
        '${settlements[i].agent.name} ${settlements[i].agent.firstnames}',
      );

      sheet
          .cell(
            CellIndex.indexByString("H${i + 2}"),
          )
          .value = TextCellValue(format.format(settlements[i].createdAt));

      sheet
          .cell(
            CellIndex.indexByString("I${i + 2}"),
          )
          .value = TextCellValue(format.format(settlements[i].updatedAt));
    }

    // Assuming excel.save() returns the bytes of the Excel file
    var fileBytes = excel.encode();
    var directory = await getApplicationDocumentsDirectory();

    // Specify the output file path
    String filePath = '${directory.path}/reglements.xlsx';

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
