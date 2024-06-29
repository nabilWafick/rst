// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:rst/common/functions/practical/pratical.function.dart';
import 'package:rst/common/models/feedback_dialog_response/feedback_dialog_response.model.dart';
import 'package:rst/common/providers/common.provider.dart';
import 'package:rst/common/widgets/feedback_dialog/feedback_dialog.widget.dart';
import 'package:rst/modules/definitions/types/controllers/types.controller.dart';
import 'package:rst/modules/definitions/types/models/type/type.model.dart';
import 'package:rst/modules/definitions/types/models/types.model.dart';
import 'package:rst/modules/home/providers/home.provider.dart';
import 'package:rst/utils/utils.dart';
import 'package:rst/common/widgets/pdf_info/pdf_info.info.dart';

Future<void> generateTypesPdf({
  required BuildContext context,
  required WidgetRef ref,
  required Map<String, dynamic> listParameters,
  required ValueNotifier<bool> showPrintButton,
}) async {
// hide Export button
  showPrintButton.value = false;
  try {
    // hide Export button
    showPrintButton.value = false;

    // format
    final format = DateFormat.yMMMMEEEEd('fr');

    // Get types list
    final typesList = await TypesController.getMany(
      listParameters: listParameters,
    );

    final authName = ref.watch(authNameProvider);
    final authFirstnames = ref.watch(authFirstnamesProvider);

    // Create a new pdf docu,ent
    final pdf = pw.Document();

    // customise font
    final Uint8List regularFontData =
        File('assets/fonts/Poppins/Poppins-Regular.ttf').readAsBytesSync();
    final regularFont = pw.Font.ttf(regularFontData.buffer.asByteData());
    final Uint8List mediumFontData =
        File('assets/fonts/Poppins/Poppins-Medium.ttf').readAsBytesSync();
    final mediumFont = pw.Font.ttf(mediumFontData.buffer.asByteData());

    final image = await rootBundle.load(RSTImages.companyLogo);
    final imageBytes = image.buffer.asUint8List();
    pw.Image companyLogo = pw.Image(
      pw.MemoryImage(imageBytes),
    );

    // Function to create the header text
    pw.Widget buildHeader() {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                children: [
                  pw.Container(
                    margin: const pw.EdgeInsets.only(
                      right: 3.0,
                    ),
                    child: companyLogo,
                    alignment: pw.Alignment.center,
                    width: 40.0,
                    height: 40.0,
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        RSTCompanyDataConstants.name,
                        style: pw.TextStyle(
                          font: mediumFont,
                          fontSize: 10.0,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(
                        height: 4.0,
                      ),
                      PdfInfos(
                        label: 'Tel',
                        value:
                            '${RSTCompanyDataConstants.phoneNumber1} /  ${RSTCompanyDataConstants.phoneNumber2}',
                      ),
                      PdfInfos(
                        label: 'BP',
                        value: RSTCompanyDataConstants.postBox,
                      )
                    ],
                  )
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  PdfInfos(
                    label: 'Imprimé le',
                    value: format.format(DateTime.now()),
                  ),
                  pw.SizedBox(height: 3.0),
                  PdfInfos(
                    label: 'Imprimé par',
                    value: '${authName ?? ''} ${authFirstnames ?? ''}',
                  )
                ],
              ),
            ],
          ),
          pw.SizedBox(
            height: 25.0,
          ),
          pw.Text(
            'LISTE DES TYPES',
            style: pw.TextStyle(
              font: mediumFont,
              fontSize: 10.0,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      );
    }

    // Function to create the table
    pw.Widget buildDataTable({
      required List<Type> types,
    }) {
      List<String> typeProducts = [];

      for (int i = 0; i < types.length; i++) {
        for (int j = 0; j < types[i].typeProducts.length; j++) {
          if (typeProducts[i].isEmpty) {
            typeProducts[i] =
                '${types[i].typeProducts[j].productNumber} * ${types[i].typeProducts[j].product.name}';
          } else {
            typeProducts[i] =
                '$typeProducts, ${types[i].typeProducts[j].productNumber} * ${types[i].typeProducts[j].product.name}';
          }
        }
      }

      return pw.Table(
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: pw.Text(
                  'Nom',
                  style: pw.TextStyle(
                    font: mediumFont,
                    fontSize: 7,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: pw.Text(
                  'Mise',
                  style: pw.TextStyle(
                    font: mediumFont,
                    fontSize: 7,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: pw.Text(
                  'Produits',
                  style: pw.TextStyle(
                    font: mediumFont,
                    fontSize: 7,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: pw.Text(
                  'Insertion',
                  style: pw.TextStyle(
                    font: mediumFont,
                    fontSize: 7,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 5.0,
                ),
                child: pw.Text(
                  'Dernière Modification',
                  style: pw.TextStyle(
                    font: mediumFont,
                    fontSize: 7,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          for (int i = 0; i < types.length; ++i)
            pw.TableRow(
              children: [
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 5.0,
                  ),
                  child: pw.Text(
                    types[i].name,
                    style: pw.TextStyle(
                      font: regularFont,
                      fontSize: 7,
                    ),
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 5.0,
                  ),
                  child: pw.Text(
                    types[i].stake.toInt().toString(),
                    style: pw.TextStyle(
                      font: regularFont,
                      fontSize: 7,
                    ),
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 5.0,
                  ),
                  child: pw.Text(
                    typeProducts[i],
                    style: pw.TextStyle(
                      font: regularFont,
                      fontSize: 7,
                    ),
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 5.0,
                  ),
                  child: pw.Text(
                    format.format(types[i].createdAt),
                    style: pw.TextStyle(
                      font: regularFont,
                      fontSize: 7,
                    ),
                  ),
                ),
                pw.Container(
                  margin: const pw.EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 5.0,
                  ),
                  child: pw.Text(
                    format.format(types[i].updatedAt),
                    style: pw.TextStyle(
                      font: regularFont,
                      fontSize: 7,
                    ),
                  ),
                ),
              ],
            ),
        ],
      );
    }

    // cast data to type model list
    final types = List<Type>.from(typesList.data);

    // Build PDF content
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          buildHeader(),
          pw.SizedBox(
            height: 20,
          ),
          buildDataTable(
            types: types,
          ),
        ],
      ),
    );

    // Save and open the PDF
    final output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/types.pdf');
    await file.writeAsBytes(
      await pdf.save(),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    ref.read(feedbackDialogResponseProvider.notifier).state =
        FeedbackDialogResponse(
      result: 'PDF',
      error: null,
      message: 'Fichier généré',
    );

    // show Export button
    showPrintButton.value = true;

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
      error: 'PDF',
      message: 'Une erreur s\'est produite',
    );

    // show Export button
    showPrintButton.value = true;

    // show response
    FunctionsController.showAlertDialog(
      context: context,
      alertDialog: const FeedbackDialog(),
    );
  }
}

// PdfInfo Widget
