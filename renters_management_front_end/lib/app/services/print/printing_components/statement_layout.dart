import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:renters_management_front_end/app/controllers/build_reports_controller.dart';
import 'package:renters_management_front_end/app/models/statement_model.dart';
import 'package:renters_management_front_end/app/services/renter_services.dart';

import '../../../models/renter_model.dart';

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
BuildReportsController controller = BuildReportsController();

Future<Widget> statementPrintLayout(
  Statement? statement,
) async {
  controller = Get.find<BuildReportsController>();

  return Center(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      SizedBox(height: 0.3 * PdfPageFormat.cm),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: (PdfPageFormat.a4.width - 128) / 3,
          child: Text(
            "Year:  ${statement?.year}",
          ),
        ),
        SizedBox(
          width: (PdfPageFormat.a4.width - 128) / 3,
          child: Text(
            "Month:  ${months[statement?.month?.value]} (${statement?.month?.value})",
          ),
        ),
      ]),
      SizedBox(height: 8),
      await _statementCard(),

      SizedBox(height: 0.3 * PdfPageFormat.cm),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          "Incomes:",
        ),
      ),
      SizedBox(height: 0.3 * PdfPageFormat.cm),
      Container(
          decoration: BoxDecoration(border: Border.all(
              width: 1.6
          )),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(left: 8,right: 8, top: 4),
              child: Row(
                // mainAxisAlignment: ,
                  children: [
                    SizedBox(
                      width: (PdfPageFormat.a4.width - 128) / 8,
                      child: Text(
                        "Date",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                    SizedBox(
                      width: (PdfPageFormat.a4.width - 128) / 8,
                      child: Text(
                        "Time",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                    SizedBox(
                      width: (PdfPageFormat.a4.width - 128) / 8,
                      child: Text(
                        "Amount",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                    SizedBox(
                      width: (PdfPageFormat.a4.width - 128) / 8,
                      child: Text(
                        "Payment\n   Type",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                    SizedBox(
                      width: (PdfPageFormat.a4.width - 128) / 8,
                      child: Text(
                        "Payment\n    ID",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                    SizedBox(
                      width: ((PdfPageFormat.a4.width - 128) / 8) * 2,
                      child: Text("Description",
                          style: TextStyle(fontSize: 8),
                          textAlign: TextAlign.center),
                    ),
                    Divider(),
                  ]),
            ),
            Divider(
                thickness: 1.6
            ),
            if ((statement?.incomes == null) ||
                (statement?.incomes?.isEmpty??true)) ...[
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
            ] else
              ...[
                for (int i = 0;
                i < statement!.incomes!.length;
                i++) ...[
                  if (i != 0) ...[Divider(thickness: 1.6)],
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Row(
                      // mainAxisAlignment: ,
                        children: [
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 8,
                            child: Text(
                              (statement.incomes![i].date
                                  ?.value !=
                                  null)
                                  ? dateFormat
                                  .format(DateTime.parse(statement.incomes![i]
                                  .date!
                                  .value))
                                  .toString()
                                  : "Unknown",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 8,
                            child: Text(
                              (statement.incomes![i].date
                                  ?.value !=
                                  null)
                                  ? timeFormat
                                  .format(DateTime.parse(statement.incomes![i]
                                  .date!
                                  .value))
                                  .toString()
                                  : "Unknown",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 8,
                            child: Text(
                              "${statement.incomes![i].paymentType
                                  ?.value}",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 8,
                            child: Text(
                              "${statement.incomes![i].paymentID
                                  ?.value}",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 8,
                            child: Text(
                              "${statement.incomes![i].amount
                                  ?.value.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),

                          SizedBox(
                            width: ((PdfPageFormat.a4.width - 128) / 6) * 3,
                            child: Text(
                              statement.incomes![i].description
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


      SizedBox(height: 0.3 * PdfPageFormat.cm),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          "Expenses:",
        ),
      ),
      SizedBox(height: 0.3 * PdfPageFormat.cm),
      Container(
          decoration: BoxDecoration(border: Border.all(
              width: 1.6
          )),
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
            Divider(
                thickness: 1.6
            ),
            if ((statement?.expenses == null) ||
                (statement?.expenses?.isEmpty??true)) ...[
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
            ] else
              ...[
                for (int i = 0;
                i < statement!.expenses!.length;
                i++) ...[
                  if (i != 0) ...[Divider(thickness: 1.6)],
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    child: Row(
                      // mainAxisAlignment: ,
                        children: [
                          SizedBox(
                            width: (PdfPageFormat.a4.width - 128) / 6,
                            child: Text(
                              (statement.expenses![i].date
                                  ?.value !=
                                  null)
                                  ? dateFormat
                                  .format(DateTime.parse(statement.expenses![i]
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
                              (statement.expenses![i].date
                                  ?.value !=
                                  null)
                                  ? timeFormat
                                  .format(DateTime.parse(statement.expenses![i]
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
                              "${statement.expenses![i].amount
                                  ?.value.toStringAsFixed(2)}",
                              style: TextStyle(fontSize: 8),
                            ),
                          ),
                          SizedBox(
                            width: ((PdfPageFormat.a4.width - 128) / 6) * 3,
                            child: Text(
                              statement.expenses![i].description
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
      SizedBox(height: 16),
      Container(height: 1, color: PdfColors.black),
      Container(height: 1, color: PdfColors.black),
    ],
  ));
}

Future<Widget> _statementCard() async {
  List<Renter> payingRenters = await RenterServices.getRentersGroup(
      controller.buildId, controller.payedRentersIds);
  List<Renter> partiallyPayingRenters = await RenterServices.getRentersGroup(
      controller.buildId, controller.partiallyPayedRentersIds);
  List<Renter> notPayingRenters = await RenterServices.getRentersGroup(
      controller.buildId, controller.notPayedRentersIds);
  return Container(
    decoration: BoxDecoration(
      border: Border.all(width: 1.6, color: PdfColors.black),
    ),
    child: Column(children: [
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          "Total Rents",
        ),
      ),
      Container(height: 1, color: PdfColors.black),
      Row(children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              SizedBox(width: 16),
              Text(
                "Total Amount:  ",
              ),
              Flexible(
                child: Text(
                  controller.monthTotalRent.value.toStringAsFixed(2),
                ),
              )
            ],
          ),
        ),
        Container(height: 25, width: 1, color: PdfColors.black),
        SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              Text(
                "No.Renters:  ",
              ),
              Flexible(
                  child: Text(
                controller.rentersCount.value.toString(),
              ))
            ],
          ),
        ),
      ]),
      Container(height: 1, color: PdfColors.black),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          "Fully Payed Rents",
        ),
      ),
      Container(height: 1, color: PdfColors.black),
      Row(children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              SizedBox(width: 16),
              Text(
                "Total Amount:  ",
              ),
              Flexible(
                child: Text(
                  controller.payedTotalRent.value.toStringAsFixed(2),
                ),
              )
            ],
          ),
        ),
        Container(height: 25, width: 1, color: PdfColors.black),
        SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              Text(
                "No.Renters:  ",
              ),
              Flexible(
                  child: Text(
                controller.payedRentersCount.value.toString(),
              ))
            ],
          ),
        ),
      ]),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 1, color: PdfColors.black),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Partially Payed Renters List:",
          ),
        ),
        for (Renter renter in payingRenters) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 32),
              Text("- ${renter.name?.value ?? " "}"),
            ],
          ),
          SizedBox(height: 16),
        ]
      ]),
      Container(height: 1, color: PdfColors.black),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          "Partially Payed Rents",
        ),
      ),
      Container(height: 1, color: PdfColors.black),
      Row(children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              SizedBox(width: 16),
              Text(
                "Total Amount:  ",
              ),
              Flexible(
                child: Text(
                  controller.partiallyPayedTotalRent.value.toStringAsFixed(2),
                ),
              )
            ],
          ),
        ),
        Container(height: 25, width: 1, color: PdfColors.black),
        SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              Text(
                "No.Renters:  ",
              ),
              Flexible(
                  child: Text(
                controller.partiallyPayedRentersCount.value.toString(),
              ))
            ],
          ),
        ),
      ]),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 1, color: PdfColors.black),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Partially Payed Renters List:",
          ),
        ),
        for (Renter renter in partiallyPayingRenters) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 32),
              Text("- ${renter.name?.value ?? " "}"),
            ],
          ),
          SizedBox(height: 16),
        ]
      ]),
      Container(height: 1, color: PdfColors.black),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          "Not Payed Rents",
        ),
      ),
      Container(height: 1, color: PdfColors.black),
      Row(children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              SizedBox(width: 16),
              Text(
                "Total Amount:  ",
              ),
              Flexible(
                child: Text(
                  controller.notPayedTotalRent.value.toStringAsFixed(2),
                ),
              )
            ],
          ),
        ),
        Container(height: 25, width: 1, color: PdfColors.black),
        SizedBox(width: 16),
        Expanded(
          child: Row(
            children: [
              Text(
                "No.Renters:  ",
              ),
              Flexible(
                  child: Text(
                controller.notPayedRentersCount.value.toString(),
              ))
            ],
          ),
        ),
      ]),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(height: 1, color: PdfColors.black),
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Partially Payed Renters List:",
          ),
        ),
        for (Renter renter in notPayingRenters) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 32),
              Text("- ${renter.name?.value ?? " "}"),
            ],
          ),
          SizedBox(height: 8),
        ]
      ]),
    ]),
  );
}
