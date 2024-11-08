import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/statement_layout.dart';
import '../../models/statement_model.dart';

class StatementPrintLayout {
  static Future<Document> generateSingleStatement(Statement? statement,String buildName,) async {
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

  static Future<Document> generateMultiStatement(List<Statement>? statements,String buildName,) async {
    final pdf = Document();
    List<Widget> statementLayouts = [];
    for(Statement statement in statements??[]){
      statementLayouts.add(await statementPrintLayout(statement));
    }
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
        for(Widget statementLayout in statementLayouts )...[
          statementLayout
        ],

      ],
    ));
    return pdf;
  }
}
