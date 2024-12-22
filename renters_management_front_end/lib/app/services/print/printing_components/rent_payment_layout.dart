import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:renters_management_front_end/app/models/rent_payments_model.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/pdf_text.dart';

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
          child: PdfText(
            "Month:${months[rentPayment.month?.value]} (${rentPayment.month?.value})",
            fontSize: 8
          ),
        ),
        SizedBox(
          width: (PdfPageFormat.a4.width - 128) / 4,
          child: PdfText(
            "State: ${rentPayment.state}",
              fontSize: 8
          ),
        ),
        SizedBox(
          width: (PdfPageFormat.a4.width - 128) / 4,
          child: PdfText(
            "PayedAmount: ${rentPayment.payedAmount?.value.toStringAsFixed(2)}",
              fontSize: 8
          ),
        ),
        SizedBox(
          width: (PdfPageFormat.a4.width - 128) / 4,
          child: PdfText(
            "RemainAmount:${rentPayment.remainAmount?.value.toStringAsFixed(2)}",
              fontSize: 8
          ),
        ),
      ]),
      if (!includeInstallment) ...[
        Divider(),
      ] else ...[
        Divider(),
        PdfText("  Installments:")
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
                        child: PdfText(
                          "Date",
                        ),
                      ),
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 6,
                        child: PdfText(
                          "Time",
                        ),
                      ),
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 6,
                        child: PdfText(
                          "Amount",
                        ),
                      ),
                      SizedBox(
                        width: ((PdfPageFormat.a4.width - 128) / 6) * 2,
                        child: PdfText("Note",
                            textAlign: TextAlign.center,
                        ),
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
                      child: PdfText(
                    "Empty",
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
                            child: PdfText(
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
                            ),
                          ),
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 6,
                            child: PdfText(
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
                            ),
                          ),
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 6,
                            child: PdfText(
                              "${rentPayment.rentPaymentsInstallment![i].amount?.value.toStringAsFixed(2)}",
                            ),
                          ),
                          SizedBox(
                            width: ((PdfPageFormat.a4.width - 128) / 6) * 3,
                            child: PdfText(
                              rentPayment.rentPaymentsInstallment![i].notes
                                      ?.value ??
                                  "",
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
