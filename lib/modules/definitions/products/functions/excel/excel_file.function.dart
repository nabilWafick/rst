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
import 'package:rst/modules/definitions/products/controllers/products.controller.dart';
import 'package:rst/modules/definitions/products/models/products.model.dart';

Future<void> generateProductsExcelFile({
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

    // Get products list
    final productsList = await ProductsController.getMany(
      listParameters: listParameters,
    );

    // Create a new Excel workbook
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Write headers with formatting
    sheet.cell(CellIndex.indexByString("A1")).value = TextCellValue("Nom");
    sheet.cell(CellIndex.indexByString("B1")).value = TextCellValue("Prix");
    sheet.cell(CellIndex.indexByString("C1")).value =
        TextCellValue("Insertion");
    sheet.cell(CellIndex.indexByString("D1")).value =
        TextCellValue("Dernière Modification");

    // cast data to product model list
    final products = List<Product>.from(productsList.data);

    // Write data rows
    for (int i = 0; i < products.length; i++) {
      sheet
          .cell(
            CellIndex.indexByString("A${i + 2}"),
          )
          .value = TextCellValue(products[i].name);

      sheet
          .cell(
            CellIndex.indexByString("B${i + 2}"),
          )
          .value = TextCellValue(
        products[i].purchasePrice.toInt().toString(),
      );

      sheet
          .cell(
            CellIndex.indexByString("C${i + 2}"),
          )
          .value = TextCellValue(format.format(products[i].createdAt));

      sheet
          .cell(
            CellIndex.indexByString("D${i + 2}"),
          )
          .value = TextCellValue(format.format(products[i].updatedAt));
    }

    // Assuming excel.save() returns the bytes of the Excel file
    var fileBytes = excel.encode();
    var directory = await getApplicationDocumentsDirectory();

    // Specify the output file path
    String filePath = '${directory.path}/produits.xlsx';

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
