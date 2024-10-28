import 'package:pdf/widgets.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/renter_details_print_layout.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/renter_rent_payment_print_layout.dart';
import '../../models/rent_payments_model.dart';
import 'package:printing/printing.dart';

import '../../models/renter_model.dart';

class AppPrinting{

  static printRenterDetailsPrintLayout(List<Renter?> renters,
      {bool includeInstallment = true, List<String>? selectedYears}) async {
    Document pdf =
    await RenterDetailsPrintLayout.generate(renters, includeInstallment: includeInstallment,selectedYears: selectedYears);
    Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  static printSingleRentPaymentPrintLayout(RentPayment? rentPayment,String renterName,double rent) async {
    Document pdf = await SingleRentPaymentPrintLayout.generate(rentPayment,renterName,rent);
    Printing.layoutPdf(
      onLayout: (format) => pdf.save(),
    );
  }

}