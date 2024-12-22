import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:renters_management_front_end/app/controllers/build_reports_controller.dart';
import 'package:renters_management_front_end/app/models/statement_model.dart';
import 'package:renters_management_front_end/app/services/print/printing_components/pdf_text.dart';
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
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
  SizedBox(height: 0.3 * PdfPageFormat.cm),
  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    SizedBox(
      width: (PdfPageFormat.a4.width - 128) / 3,
      child: PdfText(
        "Year:  ${statement?.year}",
      ),
    ),
    SizedBox(
      width: (PdfPageFormat.a4.width - 128) / 3,
      child: PdfText(
        "Month:  ${months[statement?.month?.value]} (${statement?.month?.value})",
      ),
    ),
  ]),
  SizedBox(height: 8),
        for(Widget widget in await _statementCard())...[
          widget
        ],

  SizedBox(height: 0.3 * PdfPageFormat.cm),
  Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: PdfText(
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
                  child: PdfText(
                    "Date",
                  ),
                ),
                SizedBox(
                  width: (PdfPageFormat.a4.width - 128) / 8,
                  child: PdfText(
                    "Time",
                  ),
                ),
                SizedBox(
                  width: (PdfPageFormat.a4.width - 128) / 8,
                  child: PdfText(
                    "Amount",
                  ),
                ),
                SizedBox(
                  width: (PdfPageFormat.a4.width - 128) / 8,
                  child: PdfText(
                    "Payment\n   Type",
                  ),
                ),
                SizedBox(
                  width: (PdfPageFormat.a4.width - 128) / 8,
                  child: PdfText(
                    "Payment\n    ID",

                  ),
                ),
                SizedBox(
                  width: ((PdfPageFormat.a4.width - 128) / 8) * 2,
                  child: PdfText("Description",

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
                child: PdfText(
                  "Empty",

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
                        child: PdfText(
                          (statement.incomes![i].date
                              ?.value !=
                              null)
                              ? dateFormat
                              .format(DateTime.parse(statement.incomes![i]
                              .date!
                              .value))
                              .toString()
                              : "Unknown",

                        ),
                      ),
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 8,
                        child: PdfText(
                          (statement.incomes![i].date
                              ?.value !=
                              null)
                              ? timeFormat
                              .format(DateTime.parse(statement.incomes![i]
                              .date!
                              .value))
                              .toString()
                              : "Unknown",

                        ),
                      ),
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 8,
                        child: PdfText(
                          "${statement.incomes![i].paymentType
                              ?.value}",

                        ),
                      ),
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 8,
                        child: PdfText(
                          "${statement.incomes![i].paymentID
                              ?.value}",

                        ),
                      ),
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 8,
                        child: PdfText(
                          "${statement.incomes![i].amount
                              ?.value.toStringAsFixed(2)}",
                                                      ),
                      ),

                      SizedBox(
                        width: ((PdfPageFormat.a4.width - 128) / 6) * 3,
                        child: PdfText(
                          statement.incomes![i].description
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
  SizedBox(height: 0.3 * PdfPageFormat.cm),
  Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: PdfText(
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
                child: PdfText(
                  "Empty",
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
                        child: PdfText(
                          (statement.expenses![i].date
                              ?.value !=
                              null)
                              ? dateFormat
                              .format(DateTime.parse(statement.expenses![i]
                              .date!
                              .value))
                              .toString()
                              : "Unknown",
                        ),
                      ),
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 6,
                        child: PdfText(
                          (statement.expenses![i].date
                              ?.value !=
                              null)
                              ? timeFormat
                              .format(DateTime.parse(statement.expenses![i]
                              .date!
                              .value))
                              .toString()
                              : "Unknown",
                        ),
                      ),
                      SizedBox(
                        width: (PdfPageFormat.a4.width - 128) / 6,
                        child: PdfText(
                          "${statement.expenses![i].amount
                              ?.value.toStringAsFixed(2)}",
                        ),
                      ),
                      SizedBox(
                        width: ((PdfPageFormat.a4.width - 128) / 6) * 3,
                        child: PdfText(
                          statement.expenses![i].description
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
  SizedBox(height: 16),
  Container(height: 1, color: PdfColors.black),
  Container(height: 1, color: PdfColors.black),
      ],
    );
}

Future<List<Widget>> _statementCard() async {
  List<Renter> payingRenters = await RenterServices.getRentersGroup(
      controller.buildId, controller.payedRentersIds);
  List<Renter> partiallyPayingRenters = await RenterServices.getRentersGroup(
      controller.buildId, controller.partiallyPayedRentersIds);
  List<Renter> notPayingRenters = await RenterServices.getRentersGroup(
      controller.buildId, controller.notPayedRentersIds);

  return [
    Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.6, color: PdfColors.black),
        ),
        child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: PdfText(
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
                      PdfText(
                        "Total Amount:  ",
                      ),
                      Flexible(
                        child: PdfText(
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
                      PdfText(
                        "No.Renters:  ",
                      ),
                      Flexible(
                          child: PdfText(
                            controller.rentersCount.value.toString(),
                          ))
                    ],
                  ),
                ),
              ]),
              Container(height: 1, color: PdfColors.black),
            ]
        )
    ),
    SizedBox(height: 20),
    Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.6, color: PdfColors.black),
        ),
        child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: PdfText(
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
                      PdfText(
                        "Total Amount:  ",
                      ),
                      Flexible(
                        child: PdfText(
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
                      PdfText(
                        "No.Renters:  ",
                      ),
                      Flexible(
                          child: PdfText(
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
                  child: PdfText(
                    "Fully Payed Renters List:",
                  ),
                ),
                for (int i=0;i<payingRenters.length;i+=4) ...[
                  Row(
                    children: [
                      SizedBox(width: 30),
                      for(int j=i;j<(i+4);j++)...[
                        if(j<payingRenters.length)...[
                          SizedBox(
                            width: PdfPageFormat.a4.width/5,
                            child: PdfText("${j+1}- ${payingRenters[j].name?.value ?? " "}"),
                          )
                        ]
                      ]
                    ]
                  )
                ],
                SizedBox(height: 10),
              ]),

              Container(height: 1, color: PdfColors.black),

            ]
        )
    ),
    SizedBox(height: 20),
    Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.6, color: PdfColors.black),
        ),
        child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: PdfText(
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
                      PdfText(
                        "Total Amount:  ",
                      ),
                      Flexible(
                        child: PdfText(
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
                      PdfText(
                        "No.Renters:  ",
                      ),
                      Flexible(
                          child: PdfText(
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
                  child: PdfText(
                    "Partially Payed Renters List:",
                  ),
                ),
                for (int i=0;i<partiallyPayingRenters.length;i+=4) ...[
                  Row(
                      children: [
                        SizedBox(width: 30),
                        for(int j=i;j<(i+4);j++)...[
                          if(j<partiallyPayingRenters.length)...[
                            SizedBox(
                              width: PdfPageFormat.a4.width/5,
                              child: PdfText("${j+1}- ${payingRenters[j].name?.value ?? " "}"),
                            )
                          ]
                        ]
                      ]
                  )
                ],
                SizedBox(height: 10),
              ]),
              Container(height: 1, color: PdfColors.black),
            ]
        )),
    SizedBox(height: 20),
    Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.6, color: PdfColors.black),
        ),
        child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: PdfText(
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
                      PdfText(
                        "Total Amount:  ",
                      ),
                      Flexible(
                        child: PdfText(
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
                      PdfText(
                        "No.Renters:  ",
                      ),
                      Flexible(
                          child: PdfText(
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
                  child: PdfText(
                    "Not Payed Renters List:",
                  ),
                ),
                for (int i=0;i<notPayingRenters.length;i+=4) ...[
                  Row(
                      children: [
                        SizedBox(width: 30),
                        for(int j=i;j<(i+4);j++)...[
                          if(j<notPayingRenters.length)...[
                            SizedBox(
                              width: PdfPageFormat.a4.width/5,
                              child: PdfText("${j+1}- ${payingRenters[j].name?.value ?? " "}"),
                            )
                          ]
                        ]
                      ]
                  )
                ],
                SizedBox(height: 10),
              ]),
            ]
        )),

  ];
}


List<Widget> _test(){
  return [
    Text("1"),
    Text("2"),
    Text("3"),
  ];
}
