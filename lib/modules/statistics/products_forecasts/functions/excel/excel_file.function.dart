// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/definitions/products/controllers/products.controller.dart';
import 'package:rst/modules/statistics/products_forecasts/models/products_forecasts.model.dart';

Future<void> generateProductsForecastsExcelFile({
  required BuildContext context,
  required WidgetRef ref,
  required ProductsForecastsFilter productsForecastsFilter,
  required ValueNotifier<bool> showExportButton,
}) async {
  // hide Export button
  showExportButton.value = false;
  try {
    // hide Export button
    showExportButton.value = false;

    // Get productsForecasts list
    final productsForecastsList = await ProductsController.getProductsForecasts(
      productsForecastsFilter: productsForecastsFilter,
    );

    // Create a new Excel workbook
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    // Write headers with formatting
    sheet.cell(CellIndex.indexByString("A1")).value =
        const TextCellValue("Nom");
    sheet.cell(CellIndex.indexByString("B1")).value =
        const TextCellValue("Prévision Nombre");
    sheet.cell(CellIndex.indexByString("C1")).value =
        const TextCellValue("Prévision Montant");
    sheet.cell(CellIndex.indexByString("D1")).value =
        const TextCellValue("Nombre Clients");
    // cast data to type model list
    final productsForecasts =
        List<ProductForecast>.from(productsForecastsList.data);

    // Write data rows
    for (int i = 0; i < productsForecasts.length; i++) {
      sheet
          .cell(
            CellIndex.indexByString("A${i + 2}"),
          )
          .value = TextCellValue(productsForecasts[i].productName);

      sheet
          .cell(
            CellIndex.indexByString("B${i + 2}"),
          )
          .value = TextCellValue(
        productsForecasts[i].forecastNumber.toString(),
      );

      sheet
          .cell(
            CellIndex.indexByString("C${i + 2}"),
          )
          .value = TextCellValue(
        productsForecasts[i].forecastAmount.toString(),
      );

      sheet
          .cell(
            CellIndex.indexByString("D${i + 2}"),
          )
          .value = TextCellValue(
        productsForecasts[i]
            .customersIds
            .where(
              (customerId) => customerId != null,
            )
            .length
            .toString(),
      );
    }

    // Assuming excel.save() returns the bytes of the Excel file
    var fileBytes = excel.encode();
    var directory = await getApplicationDocumentsDirectory();

    // Specify the output file path
    String filePath = '${directory.path}/prevision_produits.xlsx';

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
