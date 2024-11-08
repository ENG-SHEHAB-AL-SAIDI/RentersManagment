import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/statement_layout.dart';
import '../../models/statement_model.dart';

class SingleStatementPrintLayout {
  static Future<Document> generate(Statement? statement,String buildName,) async {
    final pdf = Document();
    Widget statementLayout = await statementPrintLayout(statement);
    pdf.addPage(MultiPage(
      build: (context) =>  [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Build: $buildName"),
            ]
        ),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        Divider(),
        statementLayout,

      ],
    ));
    return pdf;
  }
}
