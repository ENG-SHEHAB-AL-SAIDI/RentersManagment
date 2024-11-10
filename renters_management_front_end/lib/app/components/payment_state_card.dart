// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:renters_management_front_end/app/components/pop_up_cards/show_notes.dart';
import 'package:renters_management_front_end/app/controllers/renter_details_controller.dart';
import 'package:renters_management_front_end/app/models/rent_payments_model.dart';
import '../globals.dart';
import 'buttons.dart';
import 'custom_text.dart';

class RentPaymentCard extends StatelessWidget {
  RentPayment? rentPayment;
  double height;
  double type;
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

  RentPaymentCard({
    super.key,
    required this.rentPayment,
    required this.height,
    required this.type,
    this.initiallyExpanded = false
  });

  double expansionTileChildrenFontSize = 12;
  Rx<Map<String,Row>> status = Rx({});
  RenterDetailsController controller = Get.find<RenterDetailsController>();
  bool initiallyExpanded;
  @override
  Widget build(BuildContext context) {
    (height < 200) ? height = 240 : null;
    Color color1;
    Color color2;
    Color textColor;
    if (type == 0) {
      color1 = AppColors.mainCardColor;
      color2 = AppColors.inverseCardColor;
      textColor = AppColors.secTextColor;
    } else {
      color1 = AppColors.inverseCardColor;
      color2 = AppColors.backColor;
      textColor = AppColors.mainTextColor;
    }
    status.value = {
      "payed": Row(
        children: [
          const Icon(
            Icons.check,
            color: Colors.greenAccent,
          ),
          const SizedBox(
            width: 6,
          ),
          SecText('Payed', textColor: color2)
        ],
      ),
      "partially_payed":Row(
        children: [
          const Icon(
            Icons.pie_chart_rounded,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 6,
          ),
          SecText('Partially Payed', textColor: color2),
        ],
      ),
      "not_payed":Row(
        children: [
          const Icon(
            Icons.close,
            color: Colors.red,
          ),
          const SizedBox(
            width: 6,
          ),
          SecText('Not Payed', textColor: color2),
        ],
      ),
      "excluded":Row(
        children: [
          const Icon(
            Icons.not_interested,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 6,
          ),
          SecText('Excluded', textColor: color2),
        ],
      ),
    };
    return Obx(()=>Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color1,
          border: Border(
            top: BorderSide(color: color2, width: 5, strokeAlign: 1),
            bottom: BorderSide(color: color2, width: 5, strokeAlign: 1),
            right: BorderSide(color: color2, width: 5, strokeAlign: 1),
            left: BorderSide(color: color2, width: 5, strokeAlign: 1),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SecText(
                            "Month:",
                            textColor: textColor,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SecText(
                            (rentPayment?.month?.value != null)
                                ? "${months[rentPayment?.month?.value]} (${rentPayment?.month?.value})"
                                : "Unknown",
                            textColor: textColor,
                          ),
                        ],
                      ),
                      PopupMenuButton<String>(
                        onSelected:(val)=>controller.paymentMore(val,rentPayment!),
                        color: AppColors.inverseCardColor,
                        itemBuilder: (ctx) => [
                          PopupMenuItem(
                            value: (rentPayment?.state?.value != "excluded")?"exclude":"include",
                            child: SecText(
                              (rentPayment?.state?.value != "excluded")?"Exclude":"Include",
                              textColor:
                              AppColors.mainTextColor,
                            ),
                          ),
                          PopupMenuItem(
                              value: "print",
                              child: SecText(
                                "Print",
                                textColor:
                                AppColors.mainTextColor,
                              )),
                        ],
                        child: Icon(Icons.more_vert_outlined,
                            color: AppColors.mainTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SecText(
                        "State:",
                        textColor: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: status.value[rentPayment?.state?.value??""],
                      ),

                      // SecText(
                      //   rentPayment?.state?.value ?? "Unknown",
                      //   textColor: textColor,
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      SecText(
                        "payedAmount:",
                        textColor: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SecText(
                        "${rentPayment?.payedAmount?.value ?? 0}",
                        textColor: textColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SecText(
                        "remainAmount:",
                        textColor: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SecText(
                        "${rentPayment?.remainAmount?.value ?? 0}",
                        textColor: textColor,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: color2,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: ExpansionTile(
                iconColor: color1,
                collapsedIconColor: color1,
                enabled: !((rentPayment?.state?.value??"") == "excluded"),
                initiallyExpanded: !((rentPayment?.state?.value??"") == "excluded") && initiallyExpanded,
                title: SecText(
                  "Rent Payments Installment",
                  textColor: color1,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                childrenPadding: const EdgeInsets.all(8),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: ((Get.width-45) * (1 / 5)),
                          child: SecText(
                            "Date",
                            textColor: color1,
                            fontSize:
                            Utils.fontSizeScale(expansionTileChildrenFontSize),
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                          width: ((Get.width-45) * (1 / 5)),
                          child: SecText(
                            "time",
                            textColor: color1,
                            fontSize:
                            Utils.fontSizeScale(expansionTileChildrenFontSize),
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                          width: ((Get.width-45) * (1 / 5)),
                          child: SecText(
                            "Amount",
                            textColor: color1,
                            fontSize:
                            Utils.fontSizeScale(expansionTileChildrenFontSize),
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                          width: ((Get.width-45) * (1 / 5)),
                          child:  SecText(
                            "Note",
                            textColor: color1,
                            fontSize:
                            Utils.fontSizeScale(expansionTileChildrenFontSize),
                            // textAlign: TextAlign.start,
                          )),
                      SizedBox(
                        width: ((Get.width-45) * (1 / 5)),
                      )
                    ],
                  ),
                  const Divider(),
                  if (rentPayment?.rentPaymentsInstallment?.isEmpty ??
                      true) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SecText(
                          "Empty",
                          textColor: AppColors.inverseSecTextColor,
                        ),
                      ],
                    ),
                  ] else ...[
                    for (int i = 0;
                    i < (rentPayment?.rentPaymentsInstallment?.length ?? 0);
                    i++) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: ((Get.width-45) * (1 / 5)),
                              child:SecText(
                                (rentPayment?.rentPaymentsInstallment?[i].date
                                    ?.value !=
                                    null)
                                    ? controller.dateFormat
                                    .format(DateTime.parse(rentPayment!
                                    .rentPaymentsInstallment![i]
                                    .date!
                                    .value))
                                    .toString()
                                    : "Unknown",
                                textColor: color1,
                                fontSize: Utils.fontSizeScale(
                                    expansionTileChildrenFontSize),
                                textAlign: TextAlign.start,
                              )),
                          SizedBox(
                              width: ((Get.width-45) * (1 / 5)),
                              child:SecText(
                                (rentPayment?.rentPaymentsInstallment?[i].date
                                    ?.value !=
                                    null)
                                    ? controller.timeFormat
                                    .format(DateTime.parse(rentPayment!
                                    .rentPaymentsInstallment![i]
                                    .date!
                                    .value))
                                    .toString()
                                    : "Unknown",
                                textColor: color1,
                                fontSize: Utils.fontSizeScale(
                                    expansionTileChildrenFontSize),
                                textAlign: TextAlign.start,
                              )),
                          SizedBox(
                              width: ((Get.width-45) * (1 / 5)),
                              child: SecText(
                                "${rentPayment?.rentPaymentsInstallment?[i].amount?.value ?? "Unknown"}",
                                textColor: color1,
                                fontSize: Utils.fontSizeScale(
                                    expansionTileChildrenFontSize),
                                textAlign: TextAlign.start,
                              )),
                          SizedBox(
                            width: ((Get.width-45) * (1 / 5)),
                            child: TextButton(
                              onPressed:()async{
                                await Get.dialog(const PopUpShowNotesCard(),arguments: {
                                  "notes":rentPayment?.rentPaymentsInstallment?[i].notes?.value??"help",
                                  'other':"done",
                                });
                              },
                              child: SecText(
                                "show",
                                textColor: color1,
                                fontSize: Utils.fontSizeScale(
                                    expansionTileChildrenFontSize),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ((Get.width-45) * (1 / 5)),
                            child: IconButton(
                                onPressed: ()=>controller.deleteInstallment(rentPayment?.id.value,rentPayment?.rentPaymentsInstallment?[i].id.value),
                                icon: Icon(
                                  Icons.delete,
                                  color: color1,
                                )),
                          )
                        ],
                      ),
                      const Divider(),
                    ],
                  ],
                  const SizedBox(
                    height: 16,
                  ),
                  CustomButton(
                    onPress:()=> controller.addInstallment(rentPayment?.id.value,rentPayment?.remainAmount?.value),
                    text: "Add Installment",
                    color: color1,
                    textColor: color2,
                    size: const Size(150, 40),
                  )
                ],
              ),
            )
          ],
        )),);
  }
}
