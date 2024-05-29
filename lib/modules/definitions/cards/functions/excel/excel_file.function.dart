// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/definitions/cards/controllers/cards.controller.dart';
import 'package:rst/modules/definitions/cards/models/card/card.model.dart';

Future<void> generateCardsExcelFile({
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

    // Get cards list
    final cardsList = await CardsController.getMany(
      listParameters: listParameters,
    );

    // Create a new Excel workbook
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Write headers with formatting
    sheet.cell(CellIndex.indexByString("A1")).value =
        const TextCellValue("Libellé");
    sheet.cell(CellIndex.indexByString("B1")).value =
        const TextCellValue("Nombre Type");
    sheet.cell(CellIndex.indexByString("C1")).value =
        const TextCellValue("Type");
    sheet.cell(CellIndex.indexByString("D1")).value =
        const TextCellValue("Client");
    sheet.cell(CellIndex.indexByString("E1")).value =
        const TextCellValue("Remboursement");
    sheet.cell(CellIndex.indexByString("F1")).value =
        const TextCellValue("Satisfaction");
    sheet.cell(CellIndex.indexByString("G1")).value =
        const TextCellValue("Transfert");
    sheet.cell(CellIndex.indexByString("H1")).value =
        const TextCellValue("Insertion");
    sheet.cell(CellIndex.indexByString("I1")).value =
        const TextCellValue("Dernière Modification");

    // cast data to card model list
    final cards = List<Card>.from(cardsList.data);

    // Write data rows
    for (int i = 0; i < cards.length; i++) {
      sheet
          .cell(
            CellIndex.indexByString("A${i + 2}"),
          )
          .value = TextCellValue(cards[i].label.toString());

      sheet
          .cell(
            CellIndex.indexByString("B${i + 2}"),
          )
          .value = TextCellValue(
        cards[i].typesNumber.toInt().toString(),
      );

      sheet
          .cell(
            CellIndex.indexByString("C${i + 2}"),
          )
          .value = TextCellValue(
        cards[i].type.name,
      );

      sheet
          .cell(
            CellIndex.indexByString("D${i + 2}"),
          )
          .value = TextCellValue(
        '${cards[i].customer.name} ${cards[i].customer.firstnames}',
      );

      sheet
          .cell(
            CellIndex.indexByString("E${i + 2}"),
          )
          .value = TextCellValue(
        cards[i].repaidAt != null ? format.format(cards[i].repaidAt!) : '',
      );

      sheet
          .cell(
            CellIndex.indexByString("F${i + 2}"),
          )
          .value = TextCellValue(
        cards[i].satisfiedAt != null
            ? format.format(cards[i].satisfiedAt!)
            : '',
      );

      sheet
          .cell(
            CellIndex.indexByString("G${i + 2}"),
          )
          .value = TextCellValue(
        cards[i].transferredAt != null
            ? format.format(cards[i].transferredAt!)
            : '',
      );

      sheet
          .cell(
            CellIndex.indexByString("H${i + 2}"),
          )
          .value = TextCellValue(format.format(cards[i].createdAt));

      sheet
          .cell(
            CellIndex.indexByString("I${i + 2}"),
          )
          .value = TextCellValue(format.format(cards[i].updatedAt));
    }

    // Assuming excel.save() returns the bytes of the Excel file
    var fileBytes = excel.encode();
    var directory = await getApplicationDocumentsDirectory();

    // Specify the output file path
    String filePath = '${directory.path}/cartes.xlsx';

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
