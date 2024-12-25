import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/pdf_text.dart';

import '../../../models/renter_model.dart';

Widget renterInfoPrintLayout(Renter renter) {
  return Center(
      child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 85,
          child: PdfText("Renter Name: ",isBold: true,fontSize: 12),
        ),
        PdfText(renter.name?.value ?? "",isBold: true,fontSize: 12),
      ]),
      SizedBox(height: 0.4 * PdfPageFormat.cm),
      Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 85,
          child: PdfText("Rent: ",isBold: true,fontSize: 12),
        ),
        PdfText("${renter.rent?.value ?? ""}",isBold: true,fontSize: 12),
      ]),
      SizedBox(height: 0.4 * PdfPageFormat.cm),
      Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 85,
          child: PdfText("Activity: ",isBold: true,fontSize: 12),
        ),
        PdfText(renter.jobDomain?.value ?? "",isBold: true,fontSize: 12),
      ]),
      SizedBox(height: 0.4 * PdfPageFormat.cm),
      Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 85,
          child: PdfText("Phones:",isBold: true,fontSize: 12),
        ),
        PdfText("[ ",isBold: true,fontSize: 12),
        for (RxString phone in renter.phones ?? []) ...[
          PdfText("${phone.value} ,",isBold: true,fontSize: 12),
        ],
        PdfText("  ]",isBold: true,fontSize: 12),
      ]),
    ],
  ));
}
