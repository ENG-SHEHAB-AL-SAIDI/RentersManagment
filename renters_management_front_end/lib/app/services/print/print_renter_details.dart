import 'dart:typed_data';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/rent_payment.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/renter_info.dart';

import '../../models/rent_payments_model.dart';
import '../../models/renter_model.dart';

class PrintRenterDetails {
  static Future<Document> generate(List<Renter?> renters,
      {bool includeInstallment = true}) async {
    final pdf = Document();
    for (Renter? renter in renters) {
      pdf.addPage(
         await renterLayout(renter,includeInstallment: includeInstallment)
      );
    }


    return pdf;
  }

  static Future<MultiPage> renterLayout(Renter? renter,
          {bool includeInstallment = true}) async =>
      MultiPage(
        build: (context) => [
          renterInfoPrintLayout(renter!),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Divider(),
          _rentPayments(renter.rentPayments ?? RxMap({}),
              includeInstallment: includeInstallment)
        ],
      );

  static Widget _rentPayments(RxMap<String, List<RentPayment>> rentPayments,
          {bool includeInstallment = true}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("RentPayments per year:"),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        for (String key in rentPayments.keys) ...[
          Text("      Year $key"),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          for (RentPayment rentPayment in rentPayments[key] ?? []) ...[
            rentPaymentPrintLayout(rentPayment,
                includeInstallment: includeInstallment),
            SizedBox(height: 1 * PdfPageFormat.cm),
          ]
        ]
      ]);


  static printing(List<Renter?> renters,
      {bool includeInstallment = true}) async {
      Document pdf =
          await generate(renters, includeInstallment: includeInstallment);
    Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
