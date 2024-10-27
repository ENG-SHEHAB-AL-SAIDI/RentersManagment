import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/rent_payment.dart';
import '../../../models/rent_payments_model.dart';

class SingleRentPaymentPrintLayout {
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
}
