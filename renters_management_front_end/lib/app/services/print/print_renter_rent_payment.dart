import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/rent_payment.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/renter_info.dart';

import '../../models/rent_payments_model.dart';
import '../../models/renter_model.dart';

class PrintRentPayment {

  static Future<Document> generate(RentPayment? rentPayment,String renterName,double rent) async {
    final pdf = Document();
    pdf.addPage(MultiPage(
      build: (context) => [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Renter: $renterName"),
            Text("Rent: $rent"),
            Text("Year ${rentPayment?.year}"),
          ]
        ),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        Divider(),
        rentPaymentPrintLayout(rentPayment!),

      ],
    ));

    return pdf;
  }


  static printing(RentPayment? rentPayment,String renterName,double rent) async {
    Document pdf = await generate(rentPayment,renterName,rent);
    Printing.layoutPdf(
      onLayout: (format) => pdf.save(),
    );
  }
}
