import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInfos extends pw.StatelessWidget {
  final String label;
  final String value;

  PdfInfos({
    required this.label,
    required this.value,
  });

  @override
  pw.Widget build(pw.Context context) {
    // customise font
    final Uint8List regularFontData =
        File('assets/fonts/Poppins/Poppins-Regular.ttf').readAsBytesSync();
    final regularFont = pw.Font.ttf(regularFontData.buffer.asByteData());
    final Uint8List mediumFontData =
        File('assets/fonts/Poppins/Poppins-Medium.ttf').readAsBytesSync();
    final mediumFont = pw.Font.ttf(mediumFontData.buffer.asByteData());
    return pw.Row(
      children: [
        pw.Text(
          '$label: ',
          style: pw.TextStyle(
            font: regularFont,
            fontSize: 7,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            font: mediumFont,
            fontSize: 7,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
