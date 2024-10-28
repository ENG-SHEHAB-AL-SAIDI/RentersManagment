import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/rent_payment.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/renter_info.dart';
import '../../../models/rent_payments_model.dart';
import '../../../models/renter_model.dart';

class RenterDetailsPrintLayout {
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
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          Divider(),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          _rentPayments(renter.rentPayments ?? RxMap({}),
              includeInstallment: includeInstallment),
        ],
      );

  static Widget _rentPayments(RxMap<String, List<RentPayment>> rentPayments,
          {bool includeInstallment = true}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        for (String key in rentPayments.keys) ...[
          Text("Year $key"),
          SizedBox(height: 0.3 * PdfPageFormat.cm),
          Divider(),
          for (RentPayment rentPayment in rentPayments[key] ?? []) ...[
            Container(
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: rentPaymentPrintLayout(rentPayment,
                  includeInstallment: includeInstallment),
            ),
            SizedBox(height: 0.8 * PdfPageFormat.cm),
          ]
        ]
      ]);

}
