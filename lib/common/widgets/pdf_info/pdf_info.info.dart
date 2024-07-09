import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInfos extends pw.StatelessWidget {
  final String label;
  final String value;
  static pw.Font? regularFont;
  static pw.Font? mediumFont;

  PdfInfos({
    required this.label,
    required this.value,
  });

  static Future<void> loadFonts() async {
    if (regularFont == null || mediumFont == null) {
      final regularFontData =
          await rootBundle.load('assets/fonts/Poppins/Poppins-Regular.ttf');
      regularFont = pw.Font.ttf(regularFontData);

      final mediumFontData =
          await rootBundle.load('assets/fonts/Poppins/Poppins-Medium.ttf');
      mediumFont = pw.Font.ttf(mediumFontData);
    }
  }

  @override
  pw.Widget build(pw.Context context) {
    return pw.Row(
      children: [
        pw.Text(
          '$label: ',
          style: pw.TextStyle(
            font: regularFont ?? pw.Font.helvetica(),
            fontSize: 7,
          ),
        ),
        pw.Text(
          value,
          style: pw.TextStyle(
            font: mediumFont ?? pw.Font.helvetica(),
            fontSize: 7,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
