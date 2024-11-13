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
import 'package:rst/modules/transfers/controllers/transfers.controller.dart';
import 'package:rst/modules/transfers/models/transfer/transfer.model.dart';

Future<void> generateTransfersExcelFile({
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

    // Get transfers list
    final transfersList = await TransfersController.getMany(
      listParameters: listParameters,
    );

    // Create a new Excel workbook
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Write headers with formatting
    sheet.cell(CellIndex.indexByString("A1")).value =
        TextCellValue("Client Émetteur");
    sheet.cell(CellIndex.indexByString("B1")).value =
        TextCellValue("Carte Émettrice");
    sheet.cell(CellIndex.indexByString("C1")).value = TextCellValue("Type");
    sheet.cell(CellIndex.indexByString("D1")).value =
        TextCellValue("Client Récepteur");
    sheet.cell(CellIndex.indexByString("E1")).value =
        TextCellValue("Carte Réceptrice");
    sheet.cell(CellIndex.indexByString("F1")).value = TextCellValue("Type");
    sheet.cell(CellIndex.indexByString("G1")).value =
        TextCellValue("Validation");
    sheet.cell(CellIndex.indexByString("H1")).value = TextCellValue("Rejet");
    sheet.cell(CellIndex.indexByString("I1")).value = TextCellValue("Agent");
    sheet.cell(CellIndex.indexByString("J1")).value =
        TextCellValue("Insertion");
    sheet.cell(CellIndex.indexByString("K1")).value =
        TextCellValue("Dernière Modification");

    // cast data to transfer model list
    final transfers = List<Transfer>.from(transfersList.data);

    // Write data rows
    for (int i = 0; i < transfers.length; i++) {
      sheet
              .cell(
                CellIndex.indexByString("A${i + 2}"),
              )
              .value =
          TextCellValue(
              '${transfers[i].issuingCard.customer.name} ${transfers[i].issuingCard.customer.firstnames}');

      sheet
          .cell(
            CellIndex.indexByString("B${i + 2}"),
          )
          .value = TextCellValue(
        transfers[i].issuingCard.label,
      );

      sheet
          .cell(
            CellIndex.indexByString("C${i + 2}"),
          )
          .value = TextCellValue(
        transfers[i].issuingCard.type.name,
      );

      sheet
              .cell(
                CellIndex.indexByString("D${i + 2}"),
              )
              .value =
          TextCellValue(
              '${transfers[i].receivingCard.customer.name} ${transfers[i].receivingCard.customer.firstnames}');

      sheet
          .cell(
            CellIndex.indexByString("E${i + 2}"),
          )
          .value = TextCellValue(
        transfers[i].receivingCard.label,
      );

      sheet
          .cell(
            CellIndex.indexByString("F${i + 2}"),
          )
          .value = TextCellValue(
        transfers[i].receivingCard.type.name,
      );
      sheet
              .cell(
                CellIndex.indexByString("G${i + 2}"),
              )
              .value =
          TextCellValue(transfers[i].validatedAt != null
              ? format.format(transfers[i].validatedAt!)
              : '');

      sheet
              .cell(
                CellIndex.indexByString("H${i + 2}"),
              )
              .value =
          TextCellValue(transfers[i].rejectedAt != null
              ? format.format(transfers[i].rejectedAt!)
              : '');

      sheet
              .cell(
                CellIndex.indexByString("I${i + 2}"),
              )
              .value =
          TextCellValue(
              '${transfers[i].agent.name} ${transfers[i].agent.firstnames}');

      sheet
          .cell(
            CellIndex.indexByString("J${i + 2}"),
          )
          .value = TextCellValue(format.format(transfers[i].createdAt));

      sheet
          .cell(
            CellIndex.indexByString("K${i + 2}"),
          )
          .value = TextCellValue(format.format(transfers[i].updatedAt));
    }

    // Assuming excel.save() returns the bytes of the Excel file
    var fileBytes = excel.encode();
    var directory = await getApplicationDocumentsDirectory();

    // Specify the output file path
    String filePath = '${directory.path}/transferts.xlsx';

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
