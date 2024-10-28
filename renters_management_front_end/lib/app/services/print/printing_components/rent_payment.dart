import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
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

Widget rentPaymentPrintLayout(RentPayment rentPayment,
    {bool includeInstallment = true}) {
  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 0.3 * PdfPageFormat.cm),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: (PdfPageFormat.a4.width - 128) / 4,
          child: Text(
            "Month:${months[rentPayment.month?.value]} (${rentPayment.month?.value})",
            style: TextStyle(fontSize: 8),
          ),
        ),
        SizedBox(
          width: (PdfPageFormat.a4.width - 128) / 4,
          child: Text(
            "State: ${rentPayment.state}",
            style: TextStyle(fontSize: 8),
          ),
        ),
        SizedBox(
          width: (PdfPageFormat.a4.width - 128) / 4,
          child: Text(
            "PayedAmount: ${rentPayment.payedAmount?.value.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 8),
          ),
        ),
        SizedBox(
          width: (PdfPageFormat.a4.width - 128) / 4,
          child: Text(
            "RemainAmount:${rentPayment.remainAmount?.value.toStringAsFixed(2)}",
            style: TextStyle(fontSize: 8),
          ),
        ),
      ]),
      if (!includeInstallment) ...[
        Divider(),
      ] else ...[
        Divider(),
        Text("  Installments:")
      ],
      if (includeInstallment) ...[
        SizedBox(height: 0.15 * PdfPageFormat.cm),
        Container(
            decoration: BoxDecoration(border: Border.all()),
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Row(
                    // mainAxisAlignment: ,
                    children: [
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 6,
                        child: Text(
                          "Date",
                          style: TextStyle(fontSize: 8),
                        ),
                      ),
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 6,
                        child: Text(
                          "Time",
                          style: TextStyle(fontSize: 8),
                        ),
                      ),
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 6,
                        child: Text(
                          "Amount",
                          style: TextStyle(fontSize: 8),
                        ),
                      ),
                      SizedBox(
                        width: ((PdfPageFormat.a4.width - 128) / 6) * 2,
                        child: Text("Note",
                            style: TextStyle(fontSize: 8),
                            textAlign: TextAlign.center),
                      ),
                      Divider(),
                    ]),
              ),
              Divider(),
              if ((rentPayment.rentPaymentsInstallment == null) ||
                  rentPayment.rentPaymentsInstallment!.isEmpty) ...[
                SizedBox(height: 0.5 * PdfPageFormat.cm),
                SizedBox(
                  width: (PdfPageFormat.a4.width),
                  child: Center(
                      child: Text(
                    "Empty",
                    style: TextStyle(fontSize: 8),
                  )),
                ),
                SizedBox(height: 0.5 * PdfPageFormat.cm),
              ] else ...[
                for (int i = 0;
                    i < rentPayment.rentPaymentsInstallment!.length;
                    i++) ...[
                  if (i != 0) ...[Divider()],
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Row(
                        // mainAxisAlignment: ,
                        children: [
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 6,
                            child: Text(
                              (rentPayment.rentPaymentsInstallment![i].date
                                          ?.value !=
                                      null)
                                  ? dateFormat
                                      .format(DateTime.parse(rentPayment
                                          .rentPaymentsInstallment![i]
                                          .date!
                                          .value))
                                      .toString()
                                  : "Unknown",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 6,
                            child: Text(
                              (rentPayment.rentPaymentsInstallment![i].date
                                          ?.value !=
                                      null)
                                  ? timeFormat
                                      .format(DateTime.parse(rentPayment
                                          .rentPaymentsInstallment![i]
                                          .date!
                                          .value))
                                      .toString()
                                  : "Unknown",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 6,
                            child: Text(
                              "${rentPayment.rentPaymentsInstallment![i].amount?.value.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          SizedBox(
                            width: ((PdfPageFormat.a4.width - 128) / 6) * 3,
                            child: Text(
                              rentPayment.rentPaymentsInstallment![i].notes
                                      ?.value ??
                                  "",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(height: 0.3 * PdfPageFormat.cm),
                ],
              ]
            ])),
      ],
    ],
  ));
}
