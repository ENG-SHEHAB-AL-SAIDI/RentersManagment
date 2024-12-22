import 'package:pdf/widgets.dart' as pw;
import 'package:renters_management_front_end/app/globals.dart';


class PdfText extends pw.StatelessWidget {
  pw.Font? regularFont;
  pw.Font? boldFont;

  final String text;
  final double fontSize;
  final bool isBold;
  final pw.TextAlign textAlign;

  // Constructor to initialize the class with required parameters
  PdfText(this.text,{
    this.fontSize = 8.0,
    this.isBold = false,
    this.textAlign = pw.TextAlign.left,
  }){
    boldFont = pw.Font.ttf(AppFonts.arial);
    regularFont = pw.Font.ttf(AppFonts.ciroRegular);
  }


  // Override build method to generate the pdf text
  @override
  pw.Widget build(pw.Context context) {

    final selectedFont = isBold ? boldFont : regularFont;

    return pw.Text(
      text,
      style: pw.TextStyle(
        font: selectedFont,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
      textDirection: pw.TextDirection.rtl
    );
  }
}
