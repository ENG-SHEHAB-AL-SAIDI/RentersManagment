import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../../../models/renter_model.dart';

Widget renterInfoPrintLayout(Renter renter) {
  return Center(
      child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 85,
          child: Text("Renter Name: "),
        ),
        Text(renter.name?.value ?? ""),
      ]),
      SizedBox(height: 0.4 * PdfPageFormat.cm),
      Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 85,
          child: Text("Rent: "),
        ),
        Text("${renter.rent?.value ?? ""}"),
      ]),
      SizedBox(height: 0.4 * PdfPageFormat.cm),
      Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 85,
          child: Text("Activity: "),
        ),
        Text(renter.jobDomain?.value ?? ""),
      ]),
      SizedBox(height: 0.4 * PdfPageFormat.cm),
      Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 85,
          child: Text("Phones:"),
        ),
        Text("[ "),
        for (RxString phone in renter.phones ?? []) ...[
          Text("${phone.value} ,"),
        ],
        Text("  ]"),
      ]),
    ],
  ));
}
