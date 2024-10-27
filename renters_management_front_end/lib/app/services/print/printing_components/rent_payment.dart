import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:renters_management_front_end/app/models/rent_payments_Installment_model.dart';
import 'package:renters_management_front_end/app/models/rent_payments_model.dart';

Map<String, String> months = {
  '1': 'January',
  '2': 'February',
  '3': 'March',
  '4': 'April',
  '5': 'May',
  '6': 'June',
  '7': 'July',
  '8': 'August',
  '9': 'September',
  '10': 'October',
  '11': 'November',
  '12': 'December'
};

DateFormat dateFormat = DateFormat("yyyy-dd-MM");
DateFormat timeFormat = DateFormat("hh:mm a");

Widget rentPaymentPrintLayout(RentPayment rentPayment,{bool includeInstallment = true}) {
  return Center(
      child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
          if(includeInstallment)...[ Divider(),],
      Row(
          // mainAxisAlignment: ,
          children: [
            SizedBox(
              width: (PdfPageFormat.a4.width - 64) / 4,
              child: Text(
                "Month:${months[rentPayment.month?.value]} (${rentPayment.month?.value})",
                style: TextStyle(fontSize: 8),
              ),
            ),
            SizedBox(
              width: (PdfPageFormat.a4.width - 64) / 4,
              child: Text(
                "State: ${rentPayment.state}",
                style: TextStyle(fontSize: 8),
              ),
            ),
            SizedBox(
              width: (PdfPageFormat.a4.width - 64) / 4,
              child: Text(
                "PayedAmount: ${rentPayment.payedAmount?.value.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 8),
              ),
            ),
            SizedBox(
              width: (PdfPageFormat.a4.width - 64) / 4,
              child: Text(
                "RemainAmount:${rentPayment.remainAmount?.value.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 8),
              ),
            ),
          ]),
      Divider(),

      if(includeInstallment)...[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
          child: Row(
            // mainAxisAlignment: ,
              children: [
                SizedBox(
                  width: (PdfPageFormat.a4.width - 64) / 5,
                  child: Text(
                    "Date",
                    style: TextStyle(fontSize: 8),
                  ),
                ),
                SizedBox(
                  width: (PdfPageFormat.a4.width - 64) / 5,
                  child: Text(
                    "Time",
                    style: TextStyle(fontSize: 8),
                  ),
                ),
                SizedBox(
                  width: (PdfPageFormat.a4.width - 64) / 5,
                  child: Text(
                    "Amount",
                    style: TextStyle(fontSize: 8),
                  ),
                ),
                SizedBox(
                  width: ((PdfPageFormat.a4.width - 64) / 5) * 2,
                  child: Text(
                    "Note",
                    style: TextStyle(fontSize: 8),
                  ),
                ),
                Divider(),
              ]),
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 16,vertical: 0),
          child: Divider(),),
        if ((rentPayment.rentPaymentsInstallment == null) || rentPayment.rentPaymentsInstallment!.isEmpty) ...[
          SizedBox(height: 0.5 * PdfPageFormat.cm),
          SizedBox(
            width: (PdfPageFormat.a4.width),
            child: Center(
                child: Text(
                  "Empty",
                  style: TextStyle(fontSize: 8),
                )
            ),
          ),
          SizedBox(height: 0.5 * PdfPageFormat.cm),
        ]
        else...[
          for (RentPaymentsInstallment installment
          in rentPayment.rentPaymentsInstallment!) ...[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Row(
                // mainAxisAlignment: ,
                  children: [
                    SizedBox(
                      width: (PdfPageFormat.a4.width - 64) / 5,
                      child: Text(
                        (installment.date?.value != null)
                            ? dateFormat
                            .format(DateTime.parse(installment.date!.value))
                            .toString()
                            : "Unknown",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                    SizedBox(
                      width: (PdfPageFormat.a4.width - 64) / 5,
                      child: Text(
                        (installment.date?.value != null)
                            ? timeFormat
                            .format(DateTime.parse(installment.date!.value))
                            .toString()
                            : "Unknown",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                    SizedBox(
                      width: (PdfPageFormat.a4.width - 64) / 5,
                      child: Text(
                        "${installment.amount?.value.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                    SizedBox(
                      width: ((PdfPageFormat.a4.width - 64) / 5) * 2,
                      child: Text(
                        installment.notes?.value ?? "",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                  ]),
            ),
          ],
        ]
      ]

    ],
  ));
}
