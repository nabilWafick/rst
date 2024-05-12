import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// Replace with your actual data
final List<Map<String, dynamic>> data = [
  {"Name": "Alice", "Age": 30, "City": "New York"},
  {"Name": "Bob", "Age": 25, "City": "London"},
  {"Name": "Charlie", "Age": 32, "City": "Paris"},
];

Future<void> createExcelFile() async {
  try {
    // Create a new Excel workbook
    var excel = Excel.createExcel();
    var sheet = excel['Sheet1'];

    CellStyle cellStyle = CellStyle(
        backgroundColorHex: '#1AFF1A',
        fontFamily: getFontFamily(FontFamily.Calibri));

    cellStyle.underline = Underline.Single;

    // Write headers with formatting
    sheet.cell(CellIndex.indexByString("A1")).value =
        const TextCellValue("Name");
    sheet.cell(CellIndex.indexByString("B1")).value =
        const TextCellValue("Age");
    sheet.cell(CellIndex.indexByString("C1")).value =
        const TextCellValue("City");

    // Write data rows
    for (int i = 0; i < data.length; i++) {
      sheet.cell(CellIndex.indexByString("A${i + 2}")).value =
          TextCellValue(data[i]["Name"]);
      sheet.cell(CellIndex.indexByString("B${i + 2}")).value =
          TextCellValue(data[i]["Age"].toString());
      sheet.cell(CellIndex.indexByString("C${i + 2}")).value =
          TextCellValue(data[i]["City"]);
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

    debugPrint('Done');
  } catch (error) {
    debugPrint(error.toString());
  }
}
